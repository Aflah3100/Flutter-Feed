import 'package:flutter/material.dart';
import 'package:flutter_feed/screens/home_screen/screen_home.dart';
import 'package:flutter_feed/screens/news_categories_screen/screen_news_categories.dart';
import 'package:flutter_feed/screens/splash_screen/screen_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter-Feed-App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ScreenSplash(),
        routes: {
          'home-screen': (context) => const ScreenHome(),
          'news-category-screen': (context) => ScreenNewsCategories()
        });
  }
}
