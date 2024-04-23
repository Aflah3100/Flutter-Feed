import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed/models/news_headlines_model/news_headlines_model.dart';
import 'package:flutter_feed/screens/news_categories_screen/screen_news_categories.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Widget buildCategoryNewsList(
    BuildContext context, NewsHeadLinesModel snapshotData) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return Expanded(
    child: ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        final currentArticle = snapshotData.articles![index];
        final dateTime = DateTime.parse(currentArticle.publishedAt!);

        return Padding(
          padding: EdgeInsets.only(top: height * .02),
          child: Row(
            children: [
              //News-Image-Widget
              Container(
                width: width * .25,
                height: height * .18,
                padding: EdgeInsets.only(left: height * .01),
                color: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(
                    imageUrl: currentArticle.urlToImage.toString(),
                    fit: BoxFit.cover,
                    placeholder: (BuildContext context, String url) =>
                        const SpinKitCircle(
                      color: Colors.blue,
                      size: 20.0,
                    ),
                    errorWidget: (BuildContext context, String url, Object _) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),

              SizedBox(
                width: width * .02,
              ),

              //News-title-details-widget
              Container(
                width: width * .70,
                height: height * .18,
                padding: EdgeInsets.only(
                  left: height * .01,
                  right: height * .01,
                  top: height * .01,
                ),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //News-title
                    Text(
                      currentArticle.title!,
                      maxLines: 4,
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //News-source-date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          DateFormat(ScreenNewsCategories.dateFormat)
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
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        height: height * .02,
      ),
      itemCount: snapshotData.articles!.length,
    ),
  );
}
