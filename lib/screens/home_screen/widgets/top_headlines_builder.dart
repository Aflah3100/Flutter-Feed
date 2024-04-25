import 'package:flutter/material.dart';
import 'package:flutter_feed/models/news_headlines_model/news_headlines_model.dart';
import 'package:flutter_feed/screens/news_categories_screen/widgets/news_list.dart';
import 'package:flutter_feed/services/apicalls.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TopHeadlinesBuilder extends StatelessWidget {
  const TopHeadlinesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsHeadLinesModel>(
        future: NewsAppServer.instance.fetchTopHeadlines(),
        builder: (context, snapshot) {
          //Connection-Waiting
          if (snapshot.connectionState == ConnectionState.waiting ||
              !(snapshot.hasData) || snapshot.data!.articles!.isEmpty) {
            return const Center(
              child: SpinKitWanderingCubes(
                color: Colors.blue,
              ),
            );
          }else{

            return buildNewsList(context, snapshot.data!);
          }
        });
  }
}
