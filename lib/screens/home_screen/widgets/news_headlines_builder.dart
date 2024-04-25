import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feed/screens/home_screen/screen_home.dart';
import 'package:flutter_feed/screens/news_display_screen/screen_news_display.dart';
import 'package:flutter_feed/services/apicalls.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_feed/models/news_headlines_model/news_headlines_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsHeadlinesBuilder extends StatelessWidget {
  const NewsHeadlinesBuilder({
    super.key,
    required this.newsTypeNotifer,
    required this.height,
    required this.width,
    required this.dateFormat,
  });

  final ValueNotifier<NewsTypes> newsTypeNotifer;
  final double height;
  final double width;
  final String dateFormat;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsHeadLinesModel>(
      future: NewsAppServer.instance
          .fetchNewsHeadlines(type: newsTypeNotifer.value),
      builder:
          (BuildContext context, AsyncSnapshot<NewsHeadLinesModel> snapshot) {
        // Connection waiting
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return const Center(
            child: SpinKitWanderingCubes(
              color: Colors.blue,
            ),
          );
        } else {
          // News-Scroll-Widget
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _newsScrollItem(height, width,
                  snapshot.data!.articles![index], dateFormat, context);
            },
            itemCount: snapshot.data!.articles!.length,
          );
        }
      },
    );
  }
}

// ignore: non_constant_identifier_names
Widget _newsScrollItem(double height, double width, Articles article,
    String dateFormat, BuildContext context) {
  final dateTime = DateTime.parse(article.publishedAt!);

  return GestureDetector(
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ScreenNewsDisplay(
            source: article.source!.name!,
            headline: article.title!,
            date: article.publishedAt!,
            description: article.description!,
            imageUrl: article.urlToImage,
            content: article.content!))),
    child: Stack(
      children: [
        //News-Image-Widget
        Container(
          height: height * 0.5,
          width: width * 0.9,
          padding: EdgeInsets.symmetric(horizontal: height * .02),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage.toString(),
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
        //News-Headline-Widget
        Positioned(
          bottom: 0,
          left: height * .02,
          right: height * .02,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              padding: EdgeInsets.only(
                left: height * .02,
                right: height * .02,
                top: height * .015,
              ),
              width: width * .9,
              height: height * .2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //News-Heading
                  Center(
                    child: Text(
                      article.title!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //News-Source
                  Padding(
                    padding: EdgeInsets.only(bottom: height * .01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //News-Author
                        Flexible(
                          child: Text(
                              article.author?? 'Unknown',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              )),
                        ),
                        //News-Date-Time
                        Text(
                          DateFormat(dateFormat).format(dateTime),
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
