import 'package:e_commerce/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var username = TextEditingController();
  var password = TextEditingController();
  var email = TextEditingController();
  bool passwordVisibility = true;
  bool checkBoxValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Container(
              child: Stack(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                  }, icon: Icon(Icons.arrow_back,color: Color(0xffF67952),)),
                  Column(
                  children: [
                    SizedBox(
                      height: 70,
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
                      "Register",
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: TextField(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Color(0xffF67952))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Color(0xffF67952))),
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.mail),
                            prefixIconColor: Color(0xffF67952)),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    CheckboxListTile(value: checkBoxValue, onChanged: (value) {
                        setState(() {
                          checkBoxValue = value!;
                        });
                      },
                          activeColor: Color(0xffF67952),
                          controlAffinity: ListTileControlAffinity.leading,
                      title: Text("I accept all the Terms and Conditions",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontFamily: "sans-serif-condensed-light"),
                      )),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffF67952),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        onPressed: () {},
                        child: Text(
                          "Register",
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
                        Text("Already have an account? ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontFamily: "sans-serif-condensed-light")),
                        InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                          },
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "sans-serif-condensed-light")),
                        )
                      ],
                    )
                  ],
                )],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
