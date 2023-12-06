import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/my_orders_screen.dart';
import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child:
            Stack(children:
            [
              Icon(Icons.circle_outlined,size: 300,color: Color(0xffF67952),),
              Container(padding: EdgeInsets.only(left: 75,top: 70),child: Icon(Icons.check,color: Color(0xffF67952),size: 150,))
            ]),
            ),
            SizedBox(height: 30,),
            Text(
              "Congratulations!!!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                  fontFamily: "sans-serif-condensed-light"),
            ),
            SizedBox(height: 30,),
            Text(
              "You have Successfully Placed The Order.......",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  fontFamily: "sans-serif-condensed-light"),
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 60,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF67952),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrdersScreens(),));
                },
                child: Text(
                  "Goto My Orders",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "sans-serif-condensed-light"),
                ),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 60,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                },
                child: Text(
                  "Back to home",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffF67952),
                      fontFamily: "sans-serif-condensed-light"),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
