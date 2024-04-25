import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ScreenNewsDisplay extends StatelessWidget {
  //News Variables

  String source;
  String headline;
  String date;
  String description;
  String? imageUrl;
  String content;
  static const dateFormat = 'dd MMMM, yyyy';

  ScreenNewsDisplay(
      {super.key,
      required this.source,
      required this.headline,
      required this.date,
      required this.description,
      required this.imageUrl,
      required this.content});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    final dateTime = DateTime.parse(date);
    return Scaffold(
      appBar: AppBar(
        title: Text(source,
            style: GoogleFonts.poppins(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            //News image
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.fill,
                      height: height * .50,
                      width: width,
                      errorWidget:
                          (BuildContext context, String url, Object _) =>
                              Image.asset(
                        'assets/images/news_cover_image.png',
                        fit: BoxFit.fill,
                        height: height * 0.5,
                        width: width,
                      ),
                    )
                  : Image.asset(
                      'assets/images/news_cover_image.png',
                      fit: BoxFit.fill,
                      height: height * .50,
                      width: width,
                    ),
            ),

            //News Title Container
            Card(
              elevation: 4.0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0)),
                padding: EdgeInsets.only(
                  top: height * .01,
                  left: height * .01,
                  right: height * .01,
                ),
                width: width,
                height: height * 0.50,
                child: Column(
                  children: [
                    //News-Title
                    Text(headline,
                        maxLines: 4,
                        overflow: TextOverflow.visible,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: height * .01,
                    ),

                    //News-source-date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          source ,
                          style: GoogleFonts.poppins(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(DateFormat(dateFormat).format(dateTime),
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: height * .06,
                    ),
                    //News Description
                    Text(description,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: height * .01,
                    ),
                    //News-Content
                    Text(content ,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
