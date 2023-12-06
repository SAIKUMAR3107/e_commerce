import 'package:e_commerce/database/database_helper.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:flutter/material.dart';

import '../model/address_model.dart';

class MyOrderDetailsScreen extends StatefulWidget {
  CartProduct product;
  MyOrderDetailsScreen({required this.product,super.key});

  @override
  State<MyOrderDetailsScreen> createState() => _MyOrdersDetailsScreenState();
}

class _MyOrdersDetailsScreenState extends State<MyOrderDetailsScreen> {
  var sets;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  Future<List<Map<String, Object?>>> getData() async{
    var m = await DatabaseHelper.instance.getEachAddress(widget.product.addressId!);
    setState(() {
      m.map((e) {
          sets=e;
      }).toList();
    });
    print("MM $sets");
    return m;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Orders",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "sans-serif-condensed-light")),centerTitle: true,backgroundColor: Colors.white,iconTheme: IconThemeData(color: Color(0xffF67952)),),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text("Order Summary",style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "sans-serif-condensed-light")),
              SizedBox(height: 20,),
              ClipRRect(borderRadius: BorderRadius.circular(40),child: Image.network(widget.product.thumbnail,height: 300,width: double.infinity,fit: BoxFit.fill,)),
              SizedBox(height: 20,),
              Container(padding: EdgeInsets.only(left: 5,right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: "sans-serif-condensed-light"),
                    ),
                    Text(
                      "\$ ${widget.product.price.toString()} x ${widget.product.quantity}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: "sans-serif-condensed-light"),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "You Have Ordered On :",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                        fontSize: 20,
                        fontFamily: "sans-serif-condensed-light"),
                  ),
                  Text(
                    widget.product.date!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                        fontSize: 20,
                        fontFamily: "sans-serif-condensed-light"),
                  )
                ],
              ),
              SizedBox(height: 30,),
              Container(alignment: Alignment.topLeft,
                child: Text(
                  "Address Details : ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: "sans-serif-condensed-light"),
                ),
              ),
              SizedBox(height: 10,),

              Card(
                elevation: 10,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white)),
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sets["fullName"],style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontFamily: "sans-serif-condensed-light"),),
                      SizedBox(height: 10,),
                      Text(sets["buildingName"],style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontFamily: "sans-serif-condensed-light"),),
                      Text(sets['street'],style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontFamily: "sans-serif-condensed-light"),),
                      Text(sets['city'],style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontFamily: "sans-serif-condensed-light"),),
                      Text(sets['state'],style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontFamily: "sans-serif-condensed-light"),),
                      Text(sets['pinCode'].toString(),style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontFamily: "sans-serif-condensed-light"),),
                      SizedBox(height: 10,),
                      Text("Phone : ${sets["mobileNumber"]}",style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontFamily: "sans-serif-condensed-light"),),
                    ],
                  ),
                ),
              )

            ],
          )
        ),
      ),
    );
  }
}
