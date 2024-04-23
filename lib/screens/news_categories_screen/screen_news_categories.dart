import 'package:flutter/material.dart';
import 'package:flutter_feed/models/news_headlines_model/news_headlines_model.dart';
import 'package:flutter_feed/screens/news_categories_screen/widgets/news_category_list.dart';
import 'package:flutter_feed/screens/news_categories_screen/widgets/news_category_scroll.dart';
import 'package:flutter_feed/services/apicalls.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ScreenNewsCategories extends StatelessWidget {
  //News Category List
  ScreenNewsCategories({super.key});
  final newsCateogryList = [
    'General',
    'Entertainment',
    'Business',
    'Health',
    'Science',
    'Sports',
    'Technologies'
  ];

  //News-Category-Notifier
  ValueNotifier<String> newsCateogryNotifier = ValueNotifier('General');
  static const dateFormat = 'dd MMMM, yyyy';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categorical News',
          style: GoogleFonts.poppins(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          //News-Category-Scroll-Widget
          ValueListenableBuilder(
              valueListenable: newsCateogryNotifier,
              builder:
                  (BuildContext context, String selectedCategory, Widget? _) {
                return SizedBox(
                  width: width,
                  height: height * 0.07,
                  child: NewsCategoryScroll(
                      newsCateogryList: newsCateogryList,
                      newsCateogryNotifier: newsCateogryNotifier,
                      height: height),
                );
              }),

          //Category-News-Display-Widget
          ValueListenableBuilder(
            valueListenable: newsCateogryNotifier,
            builder: (BuildContext context, String newsCategory, Widget? _) {
              return FutureBuilder<NewsHeadLinesModel>(
                future: NewsAppServer.instance.fetchNewsHeadlinesByCategory(
                  newsCategory: newsCateogryNotifier.value,
                ),
                builder: (ctx, snapshot) {
                  //Connection-Waiting
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !(snapshot.hasData)) {
                    return const Center(
                      child: SpinKitWanderingCubes(
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return buildCategoryNewsList(context, snapshot.data!);
                  }
                },
              );
            },
          )
        ],
      )),
    );
  }
}
