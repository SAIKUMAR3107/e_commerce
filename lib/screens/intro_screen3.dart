import 'package:e_commerce/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

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
                        "3",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "sans-serif-condensed-light"),
                      ),Text(
                        "/3",
                        style: TextStyle(
                            color: Colors.black,
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
              SvgPicture.asset("assets/svg_icons/Group 233.svg"),
              SizedBox(height: 20),
              Text(
                "Get Your Order",
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
                  "Business or commerce an order is a stated intention either spoken to engage in a commercial transaction specific products",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "sans-serif-condensed-light",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                    },
                    child: Text("Get Started"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      backgroundColor: Color(0xffF67952),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
