import 'package:e_commerce/database/database_helper.dart';
import 'package:e_commerce/screens/address_screen.dart';
import 'package:e_commerce/screens/notification_service.dart';
import 'package:e_commerce/screens/order_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../model/address_model.dart';
import '../model/cart_model.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  double total = 0;
  bool value = false;
  bool isFinished = false;
  int isSelected=0;
  List<Address> list= [];

  void getTotal(){
      var totalPrice =DatabaseHelper.instance.checkOutTotal();
      totalPrice.then((value) {
        setState(() {
          total = double.tryParse((value as int).toString())!;
          total = (total/10)*9;
        });
      });
  }

  @override
  void initState() {
    getTotal();
    // TODO: implement initState
    super.initState();
    getRecord();
  }

  Future<void> getRecord() async{
    var result = await DatabaseHelper.instance.getAddress();
    setState(() {
      list = result;
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 400,
                child: FutureBuilder<List<CartProduct>>(
                  future: DatabaseHelper.instance.getCheckoutItems(),
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
                            "No Items to checkout",
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
                              return Card(
                                elevation: 10,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.white)),
                                child: Row(
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

                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              Container(alignment: Alignment.topLeft,
                child: Text("Billing Information :",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "sans-serif-condensed-light")),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 15,
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
                child: Container(
                  padding: EdgeInsets.only(top :20,left: 10,right: 10,bottom: 30),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivary Fee     : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                fontFamily: "sans-serif-condensed-light"),
                          ),
                          total != 0 ? Text(
                            "50.00 /-",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "sans-serif-condensed-light"),
                          ) : Text(
                            "0.00 /-",
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
                            "Sub Total          : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                                fontSize: 16,
                                fontFamily: "sans-serif-condensed-light"),
                          ),
                          Text(
                            "${total.toStringAsFixed(2).toString()} /-",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "sans-serif-condensed-light"),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("----------------------------------------------------------------------------------",style: TextStyle(color: Colors.grey),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total                  :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                                fontSize: 16,
                                fontFamily: "sans-serif-condensed-light"),
                          ),
                          total != 0 ? Text(
                            "${(total+50).toStringAsFixed(2).toString()} /-",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "sans-serif-condensed-light"),
                          ) : Text(
                            "0.00 /-",
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
              SizedBox(height: 15,),
              Container(alignment: Alignment.topLeft,
                child: Text("Choose Payment Method :",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "sans-serif-condensed-light")),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 15,
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
                child: Container(
                  padding: EdgeInsets.only(top :20,left: 10,right: 10,bottom: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cash On Delivery          : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                fontFamily: "sans-serif-condensed-light"),
                          ),
                          Checkbox(side: BorderSide(color:Color(0xffF67952) ),activeColor: Color(0xffF67952),value: this.value, onChanged: (value) {
                            setState(() {
                              this.value = value!;
                            });
                          },)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Credit or Debit Card     : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                                fontSize: 16,
                                fontFamily: "sans-serif-condensed-light"),
                          ),
                          Container(padding: EdgeInsets.only(right: 14),child: Icon(Icons.credit_card,color: Color(0xffF67952),))
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "UPI Payment                :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                                fontSize: 16,
                                fontFamily: "sans-serif-condensed-light"),
                          ),
                          Container(padding: EdgeInsets.only(right: 14),child: Icon(Icons.paypal,color: Color(0xffF67952),))
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(alignment: Alignment.topLeft,
                child: Text("Choose Address :",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "sans-serif-condensed-light")),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 15,
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
                child: Container(height: 300,
                  padding: EdgeInsets.only(top :20,left: 10,right: 10,bottom: 30),
                  child: list.isEmpty ? Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No Address to display",style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF67952),
                              fontFamily: "sans-serif-condensed-light")),
                          SizedBox(height: 15,),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffF67952),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen(),));
                              },
                              child: Text(
                                "Add Address",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "sans-serif-condensed-light"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  : ListView.builder(scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          setState(() {
                            isSelected = index;
                            print(isSelected);
                          });
                        },
                        child: Card(
                          elevation: 10,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(list[index].fullName,style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                      fontFamily: "sans-serif-condensed-light"),),
                                  SizedBox(height: 10,),
                                  Text(list[index].buildingName,style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                      fontFamily: "sans-serif-condensed-light"),),
                                  Text(list[index].street,style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                      fontFamily: "sans-serif-condensed-light"),),
                                  Text(list[index].city,style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                      fontFamily: "sans-serif-condensed-light"),),
                                  Text(list[index].state,style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                      fontFamily: "sans-serif-condensed-light"),),
                                  Container(
                                    child: Text(list[index].pinCode.toString(),style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade700,
                                        fontFamily: "sans-serif-condensed-light"),),
                                  ),
                                  SizedBox(height: 10,),
                                  Text("Phone : ${list[index].mobileNumber}",style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                      fontFamily: "sans-serif-condensed-light"),),
                                  SizedBox(height: 10,),
                                  isSelected != index
                                      ? Container(alignment:Alignment.bottomCenter,child: Icon(Icons.check_circle,color: Colors.grey,))
                                      : Container(alignment:Alignment.bottomCenter,child: Icon(Icons.check_circle,color: Color(0xffF67952) ,))
                                ],
                              ),
                            ),

                        ),
                      );
                  },),
                ),
              ),
              SizedBox(height: 20,),
              (list.isEmpty || total == 0.0)
                  ? Container()
                  : Padding(
                padding: const EdgeInsets.all(10.0),
                child:SwipeableButtonView(
                  buttonText: 'PROCEED TO PLACE ORDER',
                  buttonWidget: Container(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                  ),
                  activeColor: Color(0xffF67952).withOpacity(0.9),
                  isFinished: isFinished,
                  onWaitingProcess: () async{
                    Future.delayed(Duration(seconds: 2),(){
                      setState((){
                        isFinished = true;
                        DatabaseHelper.instance.getCheckoutItems().then((value) {
                          value.map((e) async{
                            print(e.date);
                            await DatabaseHelper.instance.addMyOrderItem(CartProduct(productId: e.productId, title: e.title, description: e.description, price: e.price, discountPercentage: e.discountPercentage, rating: e.rating, stock: e.stock, brand: e.brand, category: e.category, thumbnail: e.thumbnail,quantity: e.quantity,date: DateTime.now().toString().substring(0,16),addressId: isSelected+1));
                          }).toList();
                        });
                      });
                    });
                  },
                  onFinish: (){
                      Navigator.pushReplacement(context, PageTransition(type:PageTransitionType.fade,child: OrderSuccessScreen()));
                    //TODO: For reverse ripple effect animation
                    setState(() {
                      isFinished = false;
                      DatabaseHelper.instance.deleteCheckOutTable();
                      NotificationService().showNotification(title: "Clothing",body: "Congratulations Order Placed Successfully");
                    });
                  },
                )
              ),

              SizedBox(height: 50,)

            ],
          )
        ),
      ),
    );
  }



}
