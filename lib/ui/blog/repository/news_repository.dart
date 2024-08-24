// import 'dart:convert';

// import 'package:account_saver/ui/blog/model/news_headline_model.dart';
// import 'package:http/http.dart' as http;

// class NewsRepository {
//   Future<NewsChannelHeadlineModel> fetchNewsChannelHeadlinesApi() async {
//     String url =
//         "https://newsapi.org/v2/top-headlines?sources=cnn&apiKey=bd61599e25784282985ea77175e3de2f";

//     final response = await http.get(Uri.parse(url));
//     print(response.body);
//     if (response.statusCode == 200) {
//       final body = jsonDecode(response.body);
//       return NewsChannelHeadlineModel.fromJson(body);
//     }
//     throw Exception("Error");
//   }
// }

import 'dart:convert';
import 'package:account_saver/ui/blog/model/catogery_news_model.dart';
import 'package:http/http.dart' as http;
import 'package:account_saver/ui/blog/model/news_headline_model.dart';

class NewsRepository {
  final String apiKey = 'your_api_key_here'; // Replace with your actual API key

  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadlinesApi(String channel,) async {
    final String url =
        "https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=bd61599e25784282985ea77175e3de2f";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlineModel.fromJson(body);
    } else {
      // You can handle different status codes here
      throw Exception("Failed to load news headlines. Status Code: ${response.statusCode}");
    }
  }
    Future<CatogeryNewsModel> fetchNewsChannelCatogeryApi(String cateogry,) async {
    final String url =
        "https://newsapi.org/v2/everything?q=$cateogry&apiKey=bd61599e25784282985ea77175e3de2f";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CatogeryNewsModel.fromJson(body);
    } else {
      // You can handle different status codes here
      throw Exception("Failed to load news headlines. Status Code: ${response.statusCode}");
    }
  }
}
