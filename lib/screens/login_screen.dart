
import 'dart:convert';

import 'package:e_commerce/screens/forgot_screen.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisibility = true;
  var username = TextEditingController();
  var password = TextEditingController();
  
  Future<void> login() async{

    if(username.text.isNotEmpty && password.text.isNotEmpty){
      var shared = await SharedPreferences.getInstance();
      var httpResponse = http.Client();
      var response = await httpResponse.post(Uri.parse("https://dummyjson.com/auth/login"),body: ({
        "username" : username.text.toString(),
        "password" : password.text.toString()
      }));
      if(response.statusCode == 200){
        var result = jsonDecode(response.body);
        print(result);
        setState(() {
          var fullName = result['firstName'] + " " + result['lastName'];
          shared.setBool("isLogin", true);
          shared.setString("profileImage", result['image']);
          shared.setString("fullName", fullName);
          shared.setString("email", result['email']);
          shared.setString("gender", result['gender']);
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Username and Password")));
    }

  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
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
                "Log in",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: "sans-serif-condensed-light",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              TextField(
                controller: username,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Color(0xffF67952))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Color(0xffF67952))),
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Color(0xffF67952)),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: password,
                obscureText: passwordVisibility,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xffF67952))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xffF67952))),
                  hintText: "Password",
                  suffixIconColor: Color(0xffF67952),
                  suffixIcon: IconButton(icon : Icon(passwordVisibility ? Icons.visibility_off : Icons.visibility), onPressed: () {
                    setState(() {
                      passwordVisibility = !passwordVisibility;
                    });
                  },
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.lock),
                  prefixIconColor: Color(0xffF67952),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotScreen(),));
                  },
                  child: Text(
                    "Forgot passeord?",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "sans-serif-condensed-light",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF67952),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  onPressed: () {
                    setState(() {
                      login();
                    });
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "sans-serif-condensed-light"),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text(
                "---------------    Using    ---------------",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "sans-serif-condensed-light"),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton.outlined(onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Created using Facebook")));
                  }, icon: Icon(Icons.facebook,color: Colors.blue,size: 40,)),
                  IconButton.outlined(onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Created using Google")));
                  }, icon: Icon(Icons.g_mobiledata,color: Colors.blue,size: 50,)),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                      style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontFamily: "sans-serif-condensed-light")),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                    },
                    child: Text(" Sign up",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "sans-serif-condensed-light")),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
