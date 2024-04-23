import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed/models/news_headlines_model/news_headlines_model.dart';
import 'package:flutter_feed/services/apicalls.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ScreenNewsCategories extends StatelessWidget {
  ScreenNewsCategories({super.key});
  final newsCateogryList = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technologies'
  ];
  ValueNotifier<String> newsCateogryNotifier = ValueNotifier('Business');
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
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final currentNewsCategory = newsCateogryList[index];
                        return GestureDetector(
                          onTap: () {
                            newsCateogryNotifier.value = currentNewsCategory;
                          },
                          child: Card(
                            elevation: 2.0,
                            color: (currentNewsCategory ==
                                    newsCateogryNotifier.value)
                                ? Colors.blue
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0)),
                            child: Padding(
                              padding: EdgeInsets.all(height * .01),
                              child: Center(
                                child: Text(
                                  newsCateogryList[index],
                                  style: GoogleFonts.rubik(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox();
                      },
                      itemCount: newsCateogryList.length),
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
                      return Expanded(
                        // Wrap with Expanded widget

                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            final currentArticle =
                                snapshot.data!.articles![index];
                            final dateTime =
                                DateTime.parse(currentArticle.publishedAt!);

                            //News Headline widget
                            return Padding(
                              padding: EdgeInsets.only(top: height * .02),
                              child: Row(
                                children: [
                                  Container(
                                    width: width * .25,
                                    height: height * .18,
                                    padding:
                                        EdgeInsets.only(left: height * .01),
                                    color: Colors.white,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: CachedNetworkImage(
                                        imageUrl: currentArticle.urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (BuildContext context,
                                                String url) =>
                                            const SpinKitCircle(
                                          color: Colors.blue,
                                          size: 20.0,
                                        ),
                                        errorWidget: (BuildContext context,
                                                String url, Object _) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: width * .02,
                                  ),
                                  //News title and details
                                  Container(
                                    width: width * .70,
                                    height: height * .18,
                                    padding: EdgeInsets.only(
                                      left: height * .01,
                                      right: height * .01,
                                      top: height * .01,
                                    ),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //News title
                                        Text(
                                          currentArticle.title!,
                                          maxLines: 4,
                                          overflow: TextOverflow.visible,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        //News source-date
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              currentArticle.source!.id!,
                                              style: GoogleFonts.poppins(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                            Text(
                                              DateFormat(dateFormat)
                                                  .format(dateTime),
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            height: height * .02,
                          ),
                          itemCount: snapshot.data!.articles!.length,
                        ),
                      );
                    }
                  },
                );
              })
        ],
      )),
    );
  }
}
