import 'package:flutter/material.dart';
import 'package:flutter_feed/screens/home_screen/widgets/news_headlines_builder.dart';
import 'package:flutter_feed/screens/home_screen/widgets/top_headlines_builder.dart';
import 'package:google_fonts/google_fonts.dart';

enum NewsTypes { bbcnews, foxnews, fortune, globo, cnn }

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const dateFormat = 'dd MMMM, yyyy';
    ValueNotifier<NewsTypes> newsTypeNotifer = ValueNotifier(NewsTypes.bbcnews);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('news-category-screen');
          },
          icon: Image.asset(
            'assets/images/category_icon.png',
            width: 25.0,
            height: 25.0,
          ),
        ),
        title: Text(
          'News Feeds',
          style: GoogleFonts.poppins(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              color: Colors.white,
              surfaceTintColor: Colors.white24,
              onSelected: (newstype) {
                newsTypeNotifer.value = newstype;
              },
              itemBuilder: (BuildContext ctx) {
                return [
                  const PopupMenuItem<NewsTypes>(
                      value: NewsTypes.bbcnews, child: Text('BBC News')),
                  const PopupMenuItem(
                      value: NewsTypes.foxnews, child: Text('Fox News')),
                  const PopupMenuItem(
                      value: NewsTypes.fortune, child: Text('Fortune')),
                  const PopupMenuItem(
                      value: NewsTypes.globo, child: Text('Globo')),
                  const PopupMenuItem(value: NewsTypes.cnn, child: Text('CNN'))
                ];
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
                width: width,
                height: height * 0.50,
                //News-Headlines-Widget
                child: ValueListenableBuilder(
                    valueListenable: newsTypeNotifer,
                    builder: (BuildContext ctx, NewsTypes newNewsType, widget) {
                      return NewsHeadlinesBuilder(
                          newsTypeNotifer: newsTypeNotifer,
                          height: height,
                          width: width,
                          dateFormat: dateFormat);
                    })),
            // Top-News-Headlines-Widget
            const TopHeadlinesBuilder()
          ],
        ),
      ),
    );
  }
}
