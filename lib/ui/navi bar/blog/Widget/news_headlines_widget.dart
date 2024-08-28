
import 'package:account_saver/ui/navi%20bar/blog/Widget/news_headline_detailscreen.dart';
import 'package:account_saver/ui/navi%20bar/blog/model/catogery_news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String source;
  final String publishedAt;
  final Articles? article;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.source,
    required this.publishedAt,
     this.article,
  });

  @override
    Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(article: article!),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 8.0,
        child: Stack(
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl.isNotEmpty
                    ? imageUrl
                    : 'https://via.placeholder.com/400',
                fit: BoxFit.cover,
                height: 300.0,
                width: double.infinity,
                errorWidget: (context, url, error) => Container(
                  height: 200.0,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            ),
            // Transparent Dark Background and Text
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color:
                      Colors.black.withOpacity(0.5), // Transparent dark color
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   publishedAt,
                        //   style: const TextStyle(
                        //     fontSize: 14.0,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        //const SizedBox(width: 10.0),
                        Text(
                          source,
                          style: const TextStyle(
                            fontSize: 11.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
