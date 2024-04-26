import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).popAndPushNamed('home-screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final widht = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Asset Image
          Center(
            child: Image.asset(
              'assets/images/splash_pic.jpg',
              fit: BoxFit.cover,
              width: widht * 0.9,
              height: height * 0.5,
            ),
          ),

          SizedBox(
            height: height * 0.04,
          ),

          Text('Flutter-Feed',
              style: GoogleFonts.anton(
                      letterSpacing: 3, color: Colors.grey.shade700)
                  .copyWith(fontSize: 25.0)),

          SizedBox(
            height: height * 0.04,
          ),
          //Spinkit Loader
          const SpinKitChasingDots(
            color: Colors.blue,
            size: 50.0,
          )
        ],
      ),
    );
  }
}
