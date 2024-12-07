import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = 'fe88af524eda4f42bf6eeae628c7291e';

  // Fetch top headlines
  Future<List<NewsArticle>> fetchTopHeadlines() async {
    final url = Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$_apiKey');
    return _fetchArticles(url);
  }

  // Fetch news by category
  Future<List<NewsArticle>> fetchNewsByCategory(String category) async {
    final url = Uri.parse('$_baseUrl/top-headlines?country=us&category=$category&apiKey=$_apiKey');
    return _fetchArticles(url);
  }

  // Search articles by query
  Future<List<NewsArticle>> searchNews(String query) async {
    final url = Uri.parse('$_baseUrl/everything?q=$query&apiKey=$_apiKey');
    try {
      debugPrint('Searching articles for query: $query');
      final response = await http.get(url);
      debugPrint('Search response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['articles'] != null) {
          final List articles = data['articles'];
          return articles.map((json) => NewsArticle.fromJson(json)).toList();
        } else {
          throw Exception('No articles found.');
        }
      } else {
        throw Exception('Search failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error during search: $e');
      rethrow;
    }
  }

  // General method to fetch articles
  Future<List<NewsArticle>> _fetchArticles(Uri url) async {
    try {
      final response = await http.get(url);
      debugPrint('Requesting: $url');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['articles'] != null) {
          final List articles = data['articles'];
          return articles.map((json) => NewsArticle.fromJson(json)).toList();
        } else {
          throw Exception('No articles found in response.');
        }
      } else {
        throw Exception('Failed to fetch articles: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error fetching articles: $e');
      rethrow;
    }
  }
}
