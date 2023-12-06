import 'dart:async';

import 'package:e_commerce/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              IconButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              }, icon: Icon(Icons.arrow_back),color: Color(0xffF67952),),
              Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                SvgPicture.asset(
                  "assets/svg_icons/Vector.svg",
                  height: 62,
                  width: 54,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: "sans-serif-condensed-light",
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffF67952)),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffF67952)),
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor: Color(0xffF67952)),
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffF67952),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Password send to registerd Email")));
                      setState(() {
                        Timer(Duration(seconds: 3), () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                        });
                      });
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "sans-serif-condensed-light"),
                    ),
                  ),
                ),

              ],
            )],
          ),
        ),
      ),
    );
  }
}
