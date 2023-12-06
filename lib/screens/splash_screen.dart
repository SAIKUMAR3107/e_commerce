import 'dart:async';

import 'package:e_commerce/on_bording_screens.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),() {
      shared();

  });
  }
  void shared() async{
    var shared =await SharedPreferences.getInstance();
    if(shared.getBool("isLogin")==false || shared.getBool("isLogin")== null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingscreens(),));
    }
    else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(child: SvgPicture.asset("assets/svg_icons/Vector.svg")),
      ),
    );
  }
}
