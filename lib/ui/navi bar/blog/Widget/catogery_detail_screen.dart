// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:account_saver/ui/blog/model/catogery_news_model.dart'; // Adjust as needed

// class ArticleDetailScreen extends StatelessWidget {
//   final Articles article;

//   const ArticleDetailScreen({
//     required this.article,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(article.title ?? "Article Details"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.share),
//             onPressed: () {
//               // Share the article link
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image
//             CachedNetworkImage(
//               imageUrl: article.urlToImage ?? 'https://via.placeholder.com/300',
//               fit: BoxFit.cover,
//               placeholder: (context, url) =>
//                   const Center(child: CircularProgressIndicator()),
//               errorWidget: (context, url, error) => const Icon(Icons.error),
//               width: double.infinity,
//               height: 200,
//             ),
//             const SizedBox(height: 16.0),
//             // Title
//             Text(
//               article.title ?? "No Title",
//               style: const TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             // Description
//             Text(
//               article.description ?? "",
//               style: const TextStyle(
//                 fontSize: 16.0,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Source
//             Text(
//               'Source: ${article.source}',
//               style: const TextStyle(
//                 fontSize: 14.0,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Read More Link
//             if (article.url != null && article.url!.isNotEmpty)
//               GestureDetector(
//                 onTap: () {
//                   // Open the article URL
//                   _launchURL(article.url!);
//                 },
//                 child: const Text.rich(
//                   TextSpan(
//                     text: 'Read More',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 16.0,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _launchURL(String url) async {
//     try {
//       // ignore: deprecated_member_use
//       await launch(url);
//     } catch (e) {
//       // Handle the error if the URL can't be opened
//     }
//   }
// }
import 'package:account_saver/ui/navi%20bar/blog/model/catogery_news_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

// Adjust as needed

class ArticleDetailScreen extends StatelessWidget {
  final Articles article;

  const ArticleDetailScreen({
    required this.article,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          article.title ?? "Article Details",
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share the article link
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular Image with shadow
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        article.urlToImage ?? 'https://via.placeholder.com/300',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              article.title ?? "No Title",
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              article.description ?? "",
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Roboto',
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Source: ${article.source}',
              style: const TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20.0),
            if (article.url != null && article.url!.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _launchURL(article.url!);
                },
                child: const Text(
                  'Read More',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    try {
      await launch(url);
    } catch (e) {
      // Handle the error if the URL can't be opened
    }
  }
}
