import 'package:e_commerce/screens/intro_screen1.dart';
import 'package:e_commerce/screens/intro_screen2.dart';
import 'package:e_commerce/screens/intro_screen3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingscreens extends StatefulWidget {
  const OnBoardingscreens({super.key});

  @override
  State<OnBoardingscreens> createState() => _OnBoardingscreensState();
}

class _OnBoardingscreensState extends State<OnBoardingscreens> {
  var count = PageController();
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Stack(
          children:  [
            PageView(controller: count,
            children: [
              IntroScreen1(),
              IntroScreen2(),
              IntroScreen3()
            ],
          ),
            Container(
              alignment: Alignment(0,0.87),
              child: SmoothPageIndicator(controller: count , count: 3,effect: const SlideEffect(
                activeDotColor: Color(0xffF67952),
                dotHeight: 15,
                dotColor: Colors.grey,
                dotWidth: 15,
              ),
                onDotClicked: (index) => count.animateToPage(index, duration: Duration(milliseconds: 300), curve:Curves.easeIn),
              ),
            )
    ]
        )
      );
  }
}
