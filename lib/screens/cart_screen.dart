import 'package:e_commerce/model/cart_model.dart';
import 'package:e_commerce/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../database/database_helper.dart';
import '../provider/product_provider.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0;
  var counter = 1;
  bool isFinished = false;
  int total1 = 0;
  bool cart1 = false;
  int isSelected = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotal();
  }

  void getTotal() {
    setState(() {
      var total = DatabaseHelper.instance.cartTotal();
      total.then((value) {
        totalPrice = double.tryParse((value as int).toString())!;
      });
    });

    //return totalPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder<List<CartProduct>>(
          future: DatabaseHelper.instance.getCart(),
          builder: (BuildContext content,
              AsyncSnapshot<List<CartProduct>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Text("Loading...",
                      style:
                          TextStyle(color: Color(0xffF67952), fontSize: 30)));
            }
            return snapshot.data!.isEmpty || cart == true
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/svg_icons/emptycart.png",
                          height: 400,
                          width: 400,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "Cart is Empty",
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
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                        return Card(
                          elevation: 10,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          child: Row(
                            children: [
                              Expanded(flex:3,child: Container(padding:EdgeInsets.all(10),child: Image.network(
                                snapshot.data![index].thumbnail,
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
                                      snapshot.data![index].title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          fontFamily: "sans-serif-condensed-light"),
                                    ),
                                    SizedBox(height: 15,),

                                    Text(
                                      "\$ ${(snapshot.data![index].price * snapshot.data![index].quantity!).toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontFamily: "sans-serif-condensed-light"),
                                    )
                                  ],),
                              )),
                              Expanded(flex:4,child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(onPressed: (){
                                        setState(() {
                                          getTotal();
                                        });
                                        int quantity = snapshot.data![index].quantity!;
                                        int price = snapshot.data![index].price;
                                        setState(() {
                                          if(quantity>1){
                                            quantity--;
                                            int eachTotal =  quantity * price;
                                            DatabaseHelper.instance.updateCart(CartProduct(productId: snapshot.data![index].productId, title: snapshot.data![index].title, description: snapshot.data![index].description, price: snapshot.data![index].price, discountPercentage: snapshot.data![index].discountPercentage.toDouble(), rating: snapshot.data![index].rating, stock: snapshot.data![index].stock, brand: snapshot.data![index].brand, category: snapshot.data![index].category, thumbnail: snapshot.data![index].thumbnail,quantity: quantity,eachtotal: eachTotal)).then((value) {
                                              quantity = 0 ;
                                            });
                                            var total = DatabaseHelper.instance.cartTotal();
                                            total.then((value) {
                                              totalPrice = double.tryParse((value as int).toString())!;
                                            });

                                            /*var total = DatabaseHelper.instance.cartTotal();
                        total.then((value) {
                          _CartScreenState().totalPrice  = double.tryParse((value as int).toString())!;
                        });*/
                                          }
                                        });
                                      }, icon: Icon(Icons.remove,color:Color(0xffF67952) ,)),
                                      Text(
                                        snapshot.data![index].quantity.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "sans-serif-condensed-light"),
                                      ),
                                      IconButton(onPressed: (){
                                        setState(() {
                                          getTotal();
                                        });
                                        setState(() {
                                          int quantity = snapshot.data![index].quantity!;
                                          int price = snapshot.data![index].price;
                                          quantity++;
                                          int eachTotal = price * quantity;
                                          DatabaseHelper.instance.updateCart(CartProduct(productId: snapshot.data![index].productId, title: snapshot.data![index].title, description: snapshot.data![index].description, price: snapshot.data![index].price, discountPercentage: snapshot.data![index].discountPercentage.toDouble(), rating: snapshot.data![index].rating, stock: snapshot.data![index].stock, brand: snapshot.data![index].brand, category: snapshot.data![index].category, thumbnail: snapshot.data![index].thumbnail,quantity: quantity,eachtotal: eachTotal)).then((value) {
                                            quantity = 0;
                                          });
                                          var total = DatabaseHelper.instance.cartTotal();
                                          total.then((value) {
                                            totalPrice = double.tryParse((value as int).toString())!;
                                          });
                                        });
                                      }, icon: Icon(Icons.add,color: Color(0xffF67952),)),
                                    ],
                                  ),

                                  SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xffF67952).withOpacity(0.7),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(40))),
                                      onPressed: () {
                                        setState(() {
                                          DatabaseHelper.instance.deleteCartItem(snapshot.data![index].productId);
                                          cart.removeCount();
                                          getTotal();
                                          showDialog(context: context, builder: (context){
                                            return AlertDialog(
                                              title: Text(
                                                "Delete ?",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "sans-serif-condensed-light"),
                                              ),
                                              content: Text(
                                                "Item Deleted Successfully",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "sans-serif-condensed-light"),
                                              ),
                                              actions: [
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                  getTotal();
                                                }, child: Text("Done"))
                                              ],
                                            );
                                          });
                                        });

                                      }, child: Icon(Icons.delete) ,),
                                  )
                                ],
                              )),
                            ],
                          ),

                        );
                      },)
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total price :",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontFamily: "sans-serif-condensed-light"),
                        ),
                        Text(
                          "\$ ${totalPrice.toStringAsFixed(2).toString()} /-",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontFamily: "sans-serif-condensed-light"),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: !isFinished ? SwipeableButtonView(
                        buttonText: 'SLIDE TO GET DISCOUNT PRICE',
                        buttonWidget: Container(
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                          ),
                        ),
                        activeColor: Color(0xffF67952).withOpacity(0.9),
                        isFinished: isFinished,
                        onWaitingProcess: () {
                          Future.delayed(Duration(seconds: 3), () {
                            setState(() {
                              isFinished = true;
                              var total = DatabaseHelper.instance.cartTotal();
                              total.then((value) => totalPrice = ((value as int)/10) * 9 );
                            });
                          });
                        },
                        onFinish: (){
                          //TODO: For reverse ripple effect animation
                          setState(() {
                            isFinished = false;
                          });
                        },
                      ) : SizedBox(
                        height: 50,
                        width: 150,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF67952),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          onPressed: () async{
                            setState(() {
                              //var total = DatabaseHelper.instance.cartTotal();
                              //total.then((value) => totalPrice = value as int );
                              snapshot.data!.map((e) async{
                                await DatabaseHelper.instance.addCheckoutItem(CartProduct(productId: e.productId, title: e.title, description: e.description, price: e.price, discountPercentage: e.discountPercentage, rating: e.rating, stock: e.stock, brand: e.brand, category: e.category, thumbnail: e.thumbnail,quantity: e.quantity,eachtotal: e.eachtotal,date: DateTime.now().toString().substring(0,16)));
                                print(e.productId);
                              }).toList();
                              //cart = true;
                            });

                            setState(() async{
                              await DatabaseHelper.instance.deleteCartTable();
                              cart1 = true;
                              var setquan=await SharedPreferences.getInstance();
                              setquan.setInt("quantity", 0);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Go to Check Out Screen to Order The Item")));
                            });

                          },
                          child: Text(
                            "Check Out",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "sans-serif-condensed-light"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 80,)
                  ],
                );
          },
        ),
      ),
    );
  }
}

/*class LisItemWidget extends StatefulWidget {
  CartProduct e;
  LisItemWidget({required this.e,super.key});

  @override
  State<LisItemWidget> createState() => _LisItemWidgetState();
}

class _LisItemWidgetState extends State<LisItemWidget> {
  var counter1 = 1;
  var eachTotalPrice1 = 0 ;

  @override
  void initState() {
    // TODO: implement initState
    eachTotalPrice1 = widget.e.eachtotal!;
    counter1 = widget.e.quantity!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<ProductProvider>(context);
    return Card(
      elevation: 10,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white)),
      child: Row(
        children: [
          Expanded(flex:3,child: Container(padding:EdgeInsets.all(10),child: Image.network(
            widget.e.thumbnail,
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
                  widget.e.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: "sans-serif-condensed-light"),
                ),
                SizedBox(height: 15,),

                Text(
                  "\$ ${(widget.e.price * counter1).toString()}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: "sans-serif-condensed-light"),
                )
              ],),
          )),
          Expanded(flex:4,child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                    setState(() {
                      if(counter1>1){
                        CartScreen();
                        counter1--;
                        eachTotalPrice1 =  widget.e.price * counter1;
                        DatabaseHelper.instance.updateCart(CartProduct(productId: widget.e.productId, title: widget.e.title, description: widget.e.description, price: widget.e.price, discountPercentage: widget.e.discountPercentage.toDouble(), rating: widget.e.rating, stock: widget.e.stock, brand: widget.e.brand, category: widget.e.category, thumbnail: widget.e.thumbnail,quantity: counter1,eachtotal: eachTotalPrice1));
                        */
/*var total = DatabaseHelper.instance.cartTotal();
                        total.then((value) {
                          _CartScreenState().totalPrice  = double.tryParse((value as int).toString())!;
                        });*/
/*
                      }
                    });
                  }, icon: Icon(Icons.remove,color:Color(0xffF67952) ,)),
                  Text(
                    counter1.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "sans-serif-condensed-light"),
                  ),
                  IconButton(onPressed: (){
                    setState(() {
                      counter1++;
                      eachTotalPrice1 = widget.e.price * counter1;
                      DatabaseHelper.instance.updateCart(CartProduct(productId: widget.e.productId, title: widget.e.title, description: widget.e.description, price: widget.e.price, discountPercentage: widget.e.discountPercentage.toDouble(), rating: widget.e.rating, stock: widget.e.stock, brand: widget.e.brand, category: widget.e.category, thumbnail: widget.e.thumbnail,quantity: counter1,eachtotal: eachTotalPrice1));
                    });
                  }, icon: Icon(Icons.add,color: Color(0xffF67952),)),
                ],
              ),

              SizedBox(
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF67952).withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  onPressed: () {
                    setState(() {
                      DatabaseHelper.instance.deleteCartItem(widget.e.productId);
                      cart.removeCount();
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: Text(
                            "Delete ?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "sans-serif-condensed-light"),
                          ),
                          content: Text(
                            "Item Deleted Successfully",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "sans-serif-condensed-light"),
                          ),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();
                              CartScreen();
                            }, child: Text("Done"))
                          ],
                        );
                      });
                    });

                  }, child: Icon(Icons.delete) ,),
              )
            ],
          )),
        ],
      ),

    );
  }
}*/
/*ListTile(
                                leading: Image.network(
                                  e.thumbnail,
                                  height: 70,
                                  width: 70,
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Color(0xffF67952),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      DatabaseHelper.instance.deleteItem(e.productId);
                                    });
                                  },
                                ),
                                title: Text(
                                  e.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sans-serif-condensed-light"),
                                ),
                                subtitle: Text(
                                  e.price.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sans-serif-condensed-light"),
                                ),
                              )*/


