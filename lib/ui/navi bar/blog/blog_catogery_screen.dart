// import 'package:account_saver/ui/blog/Widget/catogery_widget.dart';
// import 'package:account_saver/ui/blog/model/catogery_news_model.dart';
// import 'package:flutter/material.dart';
// import 'package:account_saver/ui/blog/controller/news_controller.dart';

// class BlogCategoryScreen extends StatefulWidget {
//   const BlogCategoryScreen({super.key});

//   @override
//   State<BlogCategoryScreen> createState() => _BlogCategoryScreenState();
// }

// class _BlogCategoryScreenState extends State<BlogCategoryScreen> {
//   late Future<CatogeryNewsModel> _newsFuture;
//   NewsController newsController = NewsController();
//   String? _selectedCategory;

//   List<String> btnCategories = [
//     "General",
//     "Entertainment",
//     "Health",
//     "Sports",
//     "Business",
//     "Technology"
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _selectedCategory = "General"; // Default value
//     _newsFuture = newsController.getNewsChannelCategory(_selectedCategory!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width =
//         MediaQuery.of(context).size.width; // Corrected MediaQuery usage

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Category Chips
//         SizedBox(
//           height: 60,
//           width: width,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: btnCategories.map((category) {
//               return _buildCategoryChip(category);
//             }).toList(),
//           ),
//         ),
//         Expanded(
//           child: FutureBuilder<CatogeryNewsModel>(
//             future: _newsFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (snapshot.hasData) {
//                 var newsList = snapshot.data?.articles ?? [];
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: newsList.length,
//                   itemBuilder: (context, index) {
//                     final newsItem = newsList[index];
//                     return InfoCard(
//                       article: newsItem,
//                     );
//                     // ListTile(
//                     //   title: Text(newsItem.title ?? ""),
//                     //   subtitle: Text(newsItem.description ?? ""),
//                     //   onTap: () {
//                     //     // Navigate to detail screen
//                     //     // Navigator.push(
//                     //     //   context,
//                     //     //   MaterialPageRoute(
//                     //     //     builder: (context) => BlogHeadlineScreen(
//                     //     //       category: _selectedCategory?.toLowerCase() ??
//                     //     //           "general",
//                     //     //       newsItem: newsItem,
//                     //     //     ),
//                     //     //   ),
//                     //     // );
//                     //   },
//                     // );
//                   },
//                 );
//               } else {
//                 return const Center(child: Text('No data available.'));
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCategoryChip(String category) {
//     bool isSelected = _selectedCategory == category ||
//         (category == 'General' && _selectedCategory == null);

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 9),
//       child: FilterChip(
//         label: Text(
//           category,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.black,
//           ),
//         ),
//         selected: isSelected,
//         onSelected: (selected) {
//           setState(() {
//             _selectedCategory = selected ? category : null;
//             _newsFuture =
//                 newsController.getNewsChannelCategory(_selectedCategory!);
//           });
//         },
//         selectedColor: Colors.black,
//         backgroundColor: Colors.grey[200],
// //        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//         showCheckmark: false,
//       ),
//     );
//   }
// }

import 'package:account_saver/ui/navi%20bar/blog/Widget/catogery_widget.dart';
import 'package:account_saver/ui/navi%20bar/blog/controller/news_controller.dart';
import 'package:account_saver/ui/navi%20bar/blog/model/catogery_news_model.dart';
import 'package:flutter/material.dart';


class BlogCategoryScreen extends StatefulWidget {
  const BlogCategoryScreen({super.key});

  @override
  State<BlogCategoryScreen> createState() => _BlogCategoryScreenState();
}

class _BlogCategoryScreenState extends State<BlogCategoryScreen> {
  late Future<CatogeryNewsModel> _newsFuture;
  NewsController newsController = NewsController();
  String? _selectedCategory;

  List<String> btnCategories = [
    "General",
    "Entertainment",
    "Health",
    "Sports",
    "Business",
    "Technology"
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = "General"; // Default value
    _newsFuture = newsController.getNewsChannelCategory(_selectedCategory!);
  }

  Future<void> _fetchNews() async {
    setState(() {
      _newsFuture = newsController.getNewsChannelCategory(_selectedCategory!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Chips
        SizedBox(
          height: 60,
          width: width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: btnCategories.map((category) {
              return _buildCategoryChip(category);
            }).toList(),
          ),
        ),
        Expanded(
          child: FutureBuilder<CatogeryNewsModel>(
            future: _newsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _fetchNews,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                var newsList = snapshot.data?.articles ?? [];
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final newsItem = newsList[index];
                    return InfoCard(
                      article: newsItem,
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available.'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String category) {
    bool isSelected = _selectedCategory == category ||
        (category == 'General' && _selectedCategory == null);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: FilterChip(
        label: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = selected ? category : null;
            _fetchNews();
          });
        },
        selectedColor: Colors.black,
        backgroundColor: Colors.grey[200],
        showCheckmark: false,
      ),
    );
  }
}
