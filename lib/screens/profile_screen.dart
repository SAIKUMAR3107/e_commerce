import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var profileImage="";
  var fullName = "";
  var email = "";
  var gender = "";
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileDetails();
  }

  void profileDetails() async{
    var shared =await SharedPreferences.getInstance();
    setState(() {
      profileImage = shared.getString("profileImage")!;
      fullName = shared.getString("fullName")!;
      email = shared.getString("email")!;
      gender = shared.getString("gender")!;
      print(profileImage);
      isloading = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        child:Column(
          children: [
            SizedBox(height: 70,),
            Visibility(
              visible: isloading,
              replacement: Center(child: CircularProgressIndicator()),
              child: Card(
                shape: OutlineInputBorder(borderRadius:BorderRadius.circular(40),borderSide: BorderSide(color: Colors.white) ),
                elevation: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(profileImage,height: 200,width:200),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text(
              fullName,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: "sans-serif-condensed-light"),
            ),
            SizedBox(height: 20,),
            Text(
              email,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontFamily: "sans-serif-condensed-light"),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 15,
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
              child: Container(
                padding: EdgeInsets.only(top :20,left: 10,right: 10,bottom: 30),
                child: Column(
                  children: [
                    Text(
                      "User Information",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "sans-serif-condensed-light"),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Full name ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey.shade700,
                              fontFamily: "sans-serif-condensed-light"),
                        ),
                        Text(
                          fullName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "sans-serif-condensed-light"),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Email ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                              fontSize: 16,
                              fontFamily: "sans-serif-condensed-light"),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "sans-serif-condensed-light"),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                              fontSize: 16,
                              fontFamily: "sans-serif-condensed-light"),
                        ),
                        Text(
                          gender,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "sans-serif-condensed-light"),
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
