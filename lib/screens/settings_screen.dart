import 'package:e_commerce/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffF67952),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              onPressed: ()  async{
                SharedPreferences shared = await SharedPreferences.getInstance();
                setState(() {
                  shared.setBool("isLogin", false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => LoginScreen(),));
                });
              },
              child: Text(
                "Log out",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "sans-serif-condensed-light"),
              )
          ),
        ));
  }
}
