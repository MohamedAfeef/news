import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/news_viewmodel.dart';
import '../widgets/news_list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Articles'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter search query...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    viewModel.searchArticles(_searchController.text);
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: viewModel.searchArticles,
            ),
          ),
          if (viewModel.isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (viewModel.articles.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'No articles found. Try another search.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.articles.length,
                itemBuilder: (context, index) {
                  final article = viewModel.articles[index];
                  return NewsListItem(article: article);
                },
              ),
            ),
        ],
      ),
    );
  }
}
