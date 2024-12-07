import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsService _newsService = NewsService();
  List<NewsArticle> _articles = [];
  List<NewsArticle> _filteredArticles = [];
  List<NewsArticle> _bookmarks = []; // Independent list for bookmarks
  bool _isLoading = false;

  List<NewsArticle> get articles => _filteredArticles.isEmpty ? _articles : _filteredArticles;
  List<NewsArticle> get bookmarkedArticles => _bookmarks;
  bool get isLoading => _isLoading;

  // Fetch all news (Top Headlines)
  Future<void> fetchNews() async {
    _setLoading(true);
    try {
      _articles = await _newsService.fetchTopHeadlines();
      _clearFilter();
    } catch (e) {
      _articles = [];
      debugPrint('Error fetching news: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Search articles by query
  Future<void> searchArticles(String query) async {
    if (query.isEmpty) {
      _clearFilter();
      return;
    }
    _setLoading(true);
    try {
      final stopwatch = Stopwatch()..start();
      _filteredArticles = await _newsService.searchNews(query);
      stopwatch.stop();
      debugPrint('Search for "$query" took ${stopwatch.elapsedMilliseconds} ms');
    } catch (e) {
      debugPrint('Error searching articles: $e');
      _filteredArticles = [];
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Sort articles by title or date
  void sortArticles(String sortBy) {
    if (sortBy == 'date') {
      _articles.sort((a, b) => b.url.compareTo(a.url)); // Replace with actual date field
    } else if (sortBy == 'title') {
      _articles.sort((a, b) => a.title.compareTo(b.title));
    }
    notifyListeners();
  }

  // Fetch articles by category
  Future<void> fetchNewsByCategory(String category) async {
    _setLoading(true);
    try {
      _articles = await _newsService.fetchNewsByCategory(category);
      _clearFilter();
    } catch (e) {
      _articles = [];
      debugPrint('Error fetching category news: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Toggle bookmark state of an article
  void toggleBookmark(NewsArticle article) {
    article.isBookmarked = !article.isBookmarked;

    if (article.isBookmarked) {
      if (!_bookmarks.contains(article)) {
        _bookmarks.add(article);
      }
    } else {
      _bookmarks.removeWhere((a) => a.url == article.url);
    }

    // Update bookmark state in both main and search results
    for (final list in [_articles, _filteredArticles]) {
      final index = list.indexWhere((a) => a.url == article.url);
      if (index != -1) {
        list[index] = article;
      }
    }

    notifyListeners();
  }

  // Helper: Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Helper: Clear filters
  void _clearFilter() {
    _filteredArticles = [];
    notifyListeners();
  }
}
