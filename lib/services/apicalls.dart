import 'dart:convert';
import 'package:flutter_feed/models/news_headlines_model/news_headlines_model.dart';
import 'package:http/http.dart' as http;

abstract class ApiCalls {
  Future<NewsHeadLinesModel> fetchNewsHeadlines();
}

class NewsAppServer implements ApiCalls {
  //apikey
  static const apiKey = '18c25434594b4a79a2740151893f6d85';

  // Single-ton-object
  NewsAppServer._internal();
  static NewsAppServer instance = NewsAppServer._internal();
  factory NewsAppServer() => instance;

  @override
  Future<NewsHeadLinesModel> fetchNewsHeadlines() async {
    final uri = Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$apiKey');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return NewsHeadLinesModel.fromJson(jsonResponse);
    }

    throw Exception('Error Fetching News Headlines');
  }
}
