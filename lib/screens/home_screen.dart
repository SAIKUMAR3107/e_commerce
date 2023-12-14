import 'package:e_commerce/screens/address_screen.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/checkout_screen.dart';
import 'package:e_commerce/screens/favorite_screen.dart';
import 'package:e_commerce/screens/product_listing.dart';
import 'package:e_commerce/screens/profile_screen.dart';
import 'package:e_commerce/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/product_provider.dart';
import 'login_screen.dart';
import 'my_orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var my_index = 0;
  var advancedDrawerController = AdvancedDrawerController();
  var profileImage="";
  var fullName = "";
  var email = "";

  void profileDetails() async{
    var shared =await SharedPreferences.getInstance();
    setState(() {
      profileImage = shared.getString("profileImage")!;
      fullName = shared.getString("fullName")!;
      email = shared.getString("email")!;
    });
  }

  List<Widget> screens = [
    ProductListingScreen(),
    CartScreen(),
    ProfileScreen(),
    CheckOutScreen()
  ];

  Text? titles() {
    if(my_index == 0){
      return Text(
        "CLOTHING",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "sans-serif-condensed-light"),
      );
    }else if(my_index == 1)
      {
        return Text(
          "My Cart",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "sans-serif-condensed-light"),
        );
      }
    else if(my_index == 2){
      return Text(
        "My Profile",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "sans-serif-condensed-light"),
      );

    }
    else{
      return Text(
        "Check Out",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "sans-serif-condensed-light"),
      );
    }
  }

  void drawerController(){
    advancedDrawerController.toggleDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: advancedDrawerController,
      backdropColor: Colors.grey.shade200,
      animationCurve: Curves.easeOutQuart,
      openScale: 0.75,
      openRatio: 0.55,
      disabledGestures: true,
      animationDuration: Duration(milliseconds: 700),
      drawer: SafeArea(child: Column(
        children: [
          Column(
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 24.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.network(profileImage),
              ),
              Text(
                fullName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "sans-serif-condensed-light"),
              ),
              SizedBox(height: 10,),
              Text(
                email,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontFamily: "sans-serif-condensed-light"),
              ),
            ],
          ),
          SizedBox(height: 20,),
          ListTile(
            onTap: () {
              drawerController();
            },
            leading: Icon(Icons.home,color : Color(0xffF67952)),
            title: Text('Home'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrdersScreens(),));
            },
            leading: Icon(Icons.shopping_cart_outlined,color : Color(0xffF67952)),
            title: Text('My Orders'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen(),));
            },
            leading: Icon(Icons.location_on_outlined,color : Color(0xffF67952)),
            title: Text('Add Address'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen(),));
            },
            leading: Icon(Icons.favorite,color : Color(0xffF67952)),
            title: Text('My Favorites'),
          ),
          ListTile(
            onTap: () {

            },
            leading: Icon(Icons.people_outline_rounded,color : Color(0xffF67952)),
            title: Text('About Us'),
          ),
          ListTile(
            onTap: () async{
              SharedPreferences shared = await SharedPreferences.getInstance();
              setState(() {
                shared.setBool("isLogin", false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => LoginScreen(),));
              });
            },
            leading: Icon(Icons.logout,color : Color(0xffF67952)),
            title: Text('Log Out'),
          ),
          Spacer(),
          Container(padding: EdgeInsets.only(left: 40),alignment: Alignment.topLeft,child: SvgPicture.asset("assets/svg_icons/Vector.svg",height: 70,width: 70,)),
          SizedBox(height: 40,)
          /*DefaultTextStyle(
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: Text('Terms of Service | Privacy Policy'),
            ),
          )*/
        ],
      ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_active),
              color: Color(0xffF67952),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Notifications")));
              },
            ),
          ],
          leading: IconButton(onPressed: () {
            drawerController();
          }, icon: Icon(Icons.menu,color: Color(0xffF67952),),),
          //iconTheme: IconThemeData(color: Color(0xffF67952)),
          title: titles(),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        //drawer: Drawer(),
        bottomNavigationBar: Container(
          height: 60,
          padding: EdgeInsets.only(bottom: 4),
          margin: EdgeInsets.all(11),
          decoration: BoxDecoration(
              color: Color(0xffF67952).withOpacity(0.9),
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      my_index = 0;
                      print(my_index);
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 6,
                        width: 25,
                        decoration: my_index == 0 ? BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white) : BoxDecoration(borderRadius: BorderRadius.circular(120)),
                      ),
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.home_filled,
                            color: Colors.white,
                          )),
                      Text(
                        "Home",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "sans-serif-condensed-light"),
                      )
                    ],
                  )),
              InkWell(
                  onTap: () {
                    setState(() {
                      my_index = 1;
                      print(my_index);
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 6,
                        width: 25,
                        decoration: my_index == 1 ? BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white) : BoxDecoration(borderRadius: BorderRadius.circular(120)),
                      ),
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          )),
                      Text(
                        "Cart",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "sans-serif-condensed-light"),
                      )
                    ],
                  )),
              InkWell(
                  onTap: () {
                    setState(() {
                      my_index = 2;
                      print(my_index);
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 6,
                        width: 25,
                        decoration: my_index == 2 ? BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white) : BoxDecoration(borderRadius: BorderRadius.circular(120)),
                      ),
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          )),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "sans-serif-condensed-light"),
                      )
                    ],
                  )),
              InkWell(
                  onTap: () {
                    setState(() {
                      my_index = 3;
                      print(my_index);
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 6,
                        width: 25,
                        decoration: my_index == 3 ? BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white) : BoxDecoration(borderRadius: BorderRadius.circular(120)),
                      ),
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.shopping_cart_checkout,
                            color: Colors.white,
                          )),
                      Text(
                        "Checkout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "sans-serif-condensed-light"),
                      ),
                    ],
                  ))
            ],
          ),
        ),
        body: screens[my_index],
      ),
    );
  }
}
