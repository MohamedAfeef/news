import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news_article.dart';
import '../viewmodels/news_viewmodel.dart';
import '../views/detail_screen.dart';

class NewsListItem extends StatelessWidget {
  final NewsArticle article;

  const NewsListItem({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsViewModel>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(article: article),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background Image
            Container(
              height: 200, // Adjusted height for modern design
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: article.imageUrl.isNotEmpty
                      ? NetworkImage(article.imageUrl)
                      : const AssetImage('assets/placeholder.jpg') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Gradient Overlay
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // News Title and Bookmark
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Bookmark Button
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: Icon(
                  article.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: () => viewModel.toggleBookmark(article),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
