// import 'package:account_saver/ui/blog/model/news_headline_model.dart';
// import 'package:flutter/material.dart';

// class NewsDetailsScreen extends StatelessWidget {
//   final Articles article;

//   const NewsDetailsScreen({Key? key, required this.article}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print(article.content);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(article.title ?? 'News Details'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.share),
//             onPressed: () {
// //              Share.share(article.url ?? '');
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               article.urlToImage != null
//                   ? Image.network(article.urlToImage!)
//                   : Container(
//                       height: 200,
//                       color: Colors.grey,
//                       child: const Center(
//                         child: Text('No Image Available'),
//                       ),
//                     ),
//               const SizedBox(height: 16),
//               Text(
//                 article.title ?? 'No Title',
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 article.author ?? 'Unknown Author',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 article.description ?? 'No Content Available',
//                 style: const TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 16),
//               SelectableText(
//                 article.url ?? 'No Content Available',
//                 style: const TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:account_saver/ui/blog/model/news_headline_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Articles article;

  const NewsDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? 'News Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Implement sharing functionality here
//              Share.share(article.url ?? '');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Image
              if (article.urlToImage != null)
                CachedNetworkImage(imageUrl: article.urlToImage!)
              else
                Container(
                  height: 200,
                  color: Colors.grey,
                  child: const Center(
                    child: Text('No Image Available'),
                  ),
                ),

              const SizedBox(height: 16),

              // Title
              Text(
                article.title ?? 'No Title',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Author
              Text(
                article.author != null
                    ? 'By ${article.author}'
                    : 'Author: Unknown',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 8),

              // Source and Published Date
              if (article.source?.name != null || article.publishedAt != null)
                Row(
                  children: [
                    if (article.source?.name != null)
                      Text(
                        'Source: ${article.source!.name}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    if (article.source?.name != null &&
                        article.publishedAt != null)
                      const SizedBox(width: 10),
                    if (article.publishedAt != null)
                      Text(
                        'Published: ${_formatDate(article.publishedAt!)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                  ],
                ),

              const SizedBox(height: 16),

              // Description
              if (article.description != null)
                Text(
                  article.description!,
                  style: const TextStyle(fontSize: 16),
                ),

              const SizedBox(height: 16),

              // Content
              if (article.content != null)
                Text(
                  article.content!,
                  style: const TextStyle(fontSize: 16),
                ),

              const SizedBox(height: 16),

              // Article URL
              if (article.url != null)
                SelectableText(
                  'Read more: ${article.url}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to format the published date
  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
  }
}
