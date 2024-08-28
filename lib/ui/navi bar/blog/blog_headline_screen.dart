
import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/ui/navi%20bar/blog/Widget/news_headlines_widget.dart';
import 'package:account_saver/ui/navi%20bar/blog/controller/news_controller.dart';
import 'package:flutter/material.dart';

import 'model/news_headline_model.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BlogScreenState createState() => _BlogScreenState();
}

enum FilterNewChannel { bbcNews, aryNews, reuters, cnn, aljazeera }

class _BlogScreenState extends State<BlogScreen> {
  late Future<NewsChannelHeadlineModel> _newsFuture;
  NewsController newsController = NewsController();
  FilterNewChannel? selectedValue;
  String defaultChannelName =
      "bbc-news"; // Use lowercase hyphenated names for API

  @override
  void initState() {
    super.initState();
    _newsFuture =
        newsController.getNewsChannelHeadline(channel: defaultChannelName);
  }

  void _loadNewsForChannel(String channelName) {
    setState(() {
      defaultChannelName = channelName;
      _newsFuture =
          newsController.getNewsChannelHeadline(channel: defaultChannelName);
    });
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow beneath the AppBar
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Add your action here
          },
        ),
        title: const Text(
          'News',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.black54,
            shadows: [
              Shadow(
                blurRadius: 4.0,
                color: Colors.black45,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        centerTitle: true, // Center the title
        actions: [
          PopupMenuButton<FilterNewChannel>(
              color: Colors.white,
              initialValue: selectedValue,
              onSelected: (FilterNewChannel item) {
                // setState(() {
                //   selectedValue = item;
                // });

                switch (item) {
                  case FilterNewChannel.bbcNews:
                    _loadNewsForChannel('bbc-news');
                    break;
                  case FilterNewChannel.aryNews:
                    _loadNewsForChannel('ary-news');
                    break;
                  // case FilterNewChannel.independent:
                  //   _loadNewsForChannel('independent');
                  //   break;
                  case FilterNewChannel.reuters:
                    _loadNewsForChannel('reuters');
                    break;
                  case FilterNewChannel.cnn:
                    _loadNewsForChannel('cnn');
                    break;
                  case FilterNewChannel.aljazeera:
                    _loadNewsForChannel('al-jazeera-english');
                    break;
                }
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterNewChannel>>[
                    const PopupMenuItem<FilterNewChannel>(
                      value: FilterNewChannel.bbcNews,
                      child: Text('BBC News'),
                    ),
                    const PopupMenuItem<FilterNewChannel>(
                      value: FilterNewChannel.aryNews,
                      child: Text('ARY News'),
                    ),
                    // const PopupMenuItem<FilterNewChannel>(
                    //   value: FilterNewChannel.independent,
                    //   child: Text('Independent'),
                    // ),
                    const PopupMenuItem<FilterNewChannel>(
                      value: FilterNewChannel.reuters,
                      child: Text('Reuters'),
                    ),
                    const PopupMenuItem<FilterNewChannel>(
                      value: FilterNewChannel.cnn,
                      child: Text('CNN'),
                    ),
                    const PopupMenuItem<FilterNewChannel>(
                      value: FilterNewChannel.aljazeera,
                      child: Text('Al Jazeera'),
                    ),
                  ]),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: width,
            height: 150,
            child: FutureBuilder<NewsChannelHeadlineModel>(
              future: _newsFuture,
              builder: (BuildContext context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapShot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _loadNewsForChannel(defaultChannelName);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (!snapShot.hasData ||
                    snapShot.data?.articles?.isEmpty == true) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('No Articles Found'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _loadNewsForChannel(defaultChannelName);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapShot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      final article = snapShot.data!.articles![index];
                      return SizedBox(
                        width: 150,
                        child: NewsCard(
                          imageUrl: article.urlToImage ?? '',
                          title: truncateTitle(article.title ?? 'No Title', 13),
                          author: article.author ?? 'Unknown Author',
                          //content: article.content ?? 'No Content Available',
                          //article: article,
                          source: article.source?.name ?? "No Source Available",
                          publishedAt: article.publishedAt ?? 'UnKnown',
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
//          SizedBox(width: width, height: 500, child: BlogCategoryScreen())
        ],
      ),
    );
  }

  String truncateTitle(String title, int wordLimit) {
    List<String> words = title.split(' ');
    if (words.length > wordLimit) {
      return '${words.sublist(0, wordLimit).join(' ')}...';
    }
    return title;
  }
}
