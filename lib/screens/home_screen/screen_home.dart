import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed/models/news_headlines_model/news_headlines_model.dart';
import 'package:flutter_feed/services/apicalls.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

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

                          return Stack(
                            children: [
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
                              )
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
