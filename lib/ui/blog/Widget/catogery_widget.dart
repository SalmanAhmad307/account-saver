// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:account_saver/ui/blog/model/catogery_news_model.dart'; // Adjust as per your actual path

// // InfoCard widget to display a single Article
// class InfoCard extends StatelessWidget {
//   final Articles article;
//   final VoidCallback? onTap; // Optional callback for tap events

//   const InfoCard({
//     required this.article,
//     this.onTap, // Allow passing an onTap callback
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap, // Execute the onTap callback when the card is tapped
//       child: Card(
//         elevation: 2.0,
//         margin: const EdgeInsets.all(8.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Left Side: Image
//             Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: CachedNetworkImage(
//                 imageUrl: article.urlToImage ?? 'https://via.placeholder.com/120', // Placeholder image URL
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) =>
//                     const Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//             ),
//             // Right Side: Text Information
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Title
//                     Text(
//                       article.title ?? "No Title",
//                       style: const TextStyle(
//                         fontSize: 18.0,  // Adjust font size as needed
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4.0),
//                     // Description
//                     Text(
//                       article.description ?? "",
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 8.0),
//                     // Source
//                     Text(
//                       'Source: ${article.source}',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:account_saver/ui/blog/Widget/catogery_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:account_saver/ui/blog/model/catogery_news_model.dart'; // Adjust as per your actual path

// InfoCard widget to display a single Article
class InfoCard extends StatelessWidget {
  final Articles article;

  const InfoCard({
    required this.article,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the detail screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(
              article: article,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5.0,
//        margin: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Side: Image
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ??
                    'https://via.placeholder.com/120', // Placeholder image URL
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            // Right Side: Text Information
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      article.title ?? "No Title",
                      style: const TextStyle(
                        fontSize: 18.0, // Adjust font size as needed
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    // Description
                    Text(
                      article.description ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    // Source
                    Text(
                      'Source: ${article.source}',
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
