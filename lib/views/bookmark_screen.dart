import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/news_viewmodel.dart';
import '../widgets/news_list_item.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Articles'),
      ),
      body: viewModel.bookmarkedArticles.isEmpty
          ? const Center(
        child: Text(
          'No bookmarks yet.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: viewModel.bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = viewModel.bookmarkedArticles[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: NewsListItem(article: article),
          );
        },
      ),
    );
  }
}
