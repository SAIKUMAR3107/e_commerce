import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../model/cart_model.dart';
import 'my_orders_details_screen.dart';

class MyOrdersScreens extends StatefulWidget {
  const MyOrdersScreens({super.key});

  @override
  State<MyOrdersScreens> createState() => _MyOrdersScreensState();
}

class _MyOrdersScreensState extends State<MyOrdersScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Orders",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "sans-serif-condensed-light")),centerTitle: true,backgroundColor: Colors.white,iconTheme: IconThemeData(color: Color(0xffF67952)),),
    body: Container(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder<List<CartProduct>>(
        future: DatabaseHelper.instance.getMyOrderItems(),
        builder: (BuildContext content,
            AsyncSnapshot<List<CartProduct>> snapshot) {

          if (!snapshot.hasData) {
            return Center(
                child: Text("Loading...",
                    style:
                    TextStyle(color: Color(0xffF67952), fontSize: 30)));
          }
          return snapshot.data!.isEmpty
              ? Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    "assets/svg_icons/emptycart.png",
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "You Haven't order Anything Previously",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: "sans-serif-condensed-light"),
                ),
              ],
            ),
          )
              : Column(
            children: [
              Expanded(
                child: ListView(
                  children: snapshot.data!.map((e) {
                    //m.add(CartProduct(productId: e.productId, title: e.title, description: e.description, price: e.price, discountPercentage: e.discountPercentage, rating: e.rating, stock: e.stock, brand: e.brand, category: e.category, thumbnail: e.thumbnail));
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderDetailsScreen( product: e),));
                      },
                      child: Card(
                        elevation: 10,
                        margin: EdgeInsets.all(10),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                  children: [
                                    Expanded(flex:3,child: Container(padding:EdgeInsets.all(10),child: Image.network(
                                      e.thumbnail,
                                      fit: BoxFit.fill,
                                      height: 70,
                                      width: 70,
                                    ),)),
                                    Expanded(flex:5,child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                fontFamily: "sans-serif-condensed-light"),
                                          ),
                                          SizedBox(height: 15,),
                                          Text(
                                            "\$ ${(e.price).toString()}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontFamily: "sans-serif-condensed-light"),
                                          )
                                        ],),
                                    )),
                                    Expanded(flex: 3,child: Column(
                                      children: [
                                        Text("Quantity",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: "sans-serif-condensed-light")),
                                        SizedBox(height: 5,),
                                        Text("x ${e.quantity}",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: "sans-serif-condensed-light"))

                                      ],
                                    ))
                                  ],
                                ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "You Have Ordered On :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade700,
                                        fontFamily: "sans-serif-condensed-light"),
                                  ),
                                  Text(
                                    e.date!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade700,
                                        fontFamily: "sans-serif-condensed-light"),
                                  )

                                ],
                              )
                            ],
                          ),
                        ),

                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    ),);
  }
}
