

// Assuming you have an API response handling file

import 'package:account_saver/ui/navi%20bar/blog/model/catogery_news_model.dart';
import 'package:account_saver/ui/navi%20bar/blog/model/news_headline_model.dart';
import 'package:account_saver/ui/navi%20bar/blog/repository/news_repository.dart';

class NewsController {
  final NewsRepository _res =
      NewsRepository(); // Assuming ApiService is where you make your API calls

  Future<NewsChannelHeadlineModel> getNewsChannelHeadline(
      {String channel = 'bbc-news'}) async {
    try {
      // Fetch the data from the API
      final response = await _res.fetchNewsChannelHeadlinesApi(channel);

      return response;
    } catch (e) {
      // Handle errors here, possibly returning an empty NewsChannelHeadlineModel or rethrowing the error
      throw Exception('Failed to load news headlines: $e');
    }
  }

    Future<CatogeryNewsModel> getNewsChannelCategory(
      String category) async {
    try {
      // Fetch the data from the API
      final response = await _res.fetchNewsChannelCatogeryApi(category);

      return response;
    } catch (e) {
      // Handle errors here, possibly returning an empty NewsChannelHeadlineModel or rethrowing the error
      throw Exception('Failed to load news headlines: $e');
    }
  }
}
