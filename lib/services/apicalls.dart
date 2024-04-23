import 'dart:convert';
import 'package:flutter_feed/models/news_headlines_model/news_headlines_model.dart';
import 'package:flutter_feed/screens/home_screen/screen_home.dart';
import 'package:http/http.dart' as http;

abstract class ApiCalls {
  Future<NewsHeadLinesModel> fetchNewsHeadlines({required NewsTypes type});
}

class NewsAppServer implements ApiCalls {
  //apikey
  static const apiKey = '18c25434594b4a79a2740151893f6d85';

  // Single-ton-object
  NewsAppServer._internal();
  static NewsAppServer instance = NewsAppServer._internal();
  factory NewsAppServer() => instance;

  @override
  Future<NewsHeadLinesModel> fetchNewsHeadlines(
      {required NewsTypes type}) async {
    final newsType = {
      NewsTypes.bbcnews: 'bbc-news',
      NewsTypes.foxnews: 'fox-news',
      NewsTypes.fortune: 'fortune',
      NewsTypes.globo: 'globo',
      NewsTypes.cnn: 'cnn'
    };
    final uri = Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=${newsType[type]}&apiKey=$apiKey');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return NewsHeadLinesModel.fromJson(jsonResponse);
    }

    throw Exception('Error Fetching News Headlines');
  }
}
