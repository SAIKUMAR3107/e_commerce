import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login_screen.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "2",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "sans-serif-condensed-light"),
                      ),Text(
                        "/3",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "sans-serif-condensed-light"),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: "sans-serif-condensed-light"),
                    ),
                  )
                ],
              ),
              SizedBox(height: 80),
              SvgPicture.asset("assets/svg_icons/Group 265.svg"),
              SizedBox(height: 20),
              Text(
                "Make Payment",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: "sans-serif-condensed-light",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Text(
                  "Payment is the transfer of money services in exchange product or Payments typically made terms agreed",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "sans-serif-condensed-light",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
