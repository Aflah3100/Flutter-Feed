import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed/models/news_headlines_model/news_headlines_model.dart';
import 'package:flutter_feed/services/apicalls.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    const dateFormat = 'dd MMMM, yyyy';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/category_icon.png',
              width: 25.0,
              height: 25.0,
            )),
        title: Text(
          'Latest News',
          style:
              GoogleFonts.poppins(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          //News Scroll Widget
          SizedBox(
            width: width,
            height: height * 0.50,
            child: FutureBuilder<NewsHeadLinesModel>(
                future: NewsAppServer.instance.fetchNewsHeadlines(),
                builder: (BuildContext context,
                    AsyncSnapshot<NewsHeadLinesModel> snapshot) {
                  //Connection waiting
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !(snapshot.hasData)) {
                    return const Center(
                      child: SpinKitWanderingCubes(
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final currentArticle =
                              snapshot.data!.articles![index];
                          final dateTime =
                              DateTime.parse(currentArticle.publishedAt!);

                          return Stack(
                            children: [
                              //News-Image-Widget
                              Container(
                                height: height * 0.5,
                                width: width * 0.9,
                                padding: EdgeInsets.symmetric(
                                    horizontal: height * .02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        currentArticle.urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (BuildContext context, String url) =>
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
                              //News-Headline-Widget
                              Positioned(
                                bottom: 0,
                                left: height *
                                    .02, // Adjust the left positioning to match the padding
                                right: height *
                                    .02, // Adjust the right positioning to match the padding
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: height * .02,
                                        right: height * .02,
                                        top: height * .015),
                                    width: width * .9,
                                    height: height * .2,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //News-Heading
                                        Center(
                                            child: Text(
                                          currentArticle.title!,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        //News-Details
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: height * .01),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(currentArticle.author!,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.redAccent)),
                                              Text(
                                                DateFormat(dateFormat)
                                                    .format(dateTime),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                          );
                        },
                        itemCount: snapshot.data!.articles!.length,
                      ),
                    );
                  }
                }),
          )
        ],
      )),
    );
  }
}
