import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/news_viewmodel.dart';
import '../widgets/news_list_item.dart';
import 'bookmark_screen.dart';
import 'search_screen.dart'; // Import the SearchScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsViewModel>(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News App'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.bookmark),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookmarkScreen()),
                );
              },
            ),
            PopupMenuButton<String>(
              onSelected: (value) => viewModel.sortArticles(value),
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'date', child: Text('Sort by Date')),
                PopupMenuItem(value: 'title', child: Text('Sort by Title')),
              ],
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: const Color(0xFFFF7043),
            onTap: (index) {
              final categories = ['business', 'entertainment', 'health', 'science', 'sports'];
              viewModel.fetchNewsByCategory(categories[index]);
            },
            tabs: const [
              Tab(text: 'Business'),
              Tab(text: 'Entertainment'),
              Tab(text: 'Health'),
              Tab(text: 'Science'),
              Tab(text: 'Sports'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: viewModel.articles.length,
                itemBuilder: (context, index) {
                  final article = viewModel.articles[index];
                  return NewsListItem(article: article);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => viewModel.fetchNews(),
                child: const Text('Fetch News'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
