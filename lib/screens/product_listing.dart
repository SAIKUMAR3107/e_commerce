
import 'dart:convert';

import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as Flutter;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/all_products_model.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  List<String> category = [];
  var isloading = false;
  Products? product;
  var searchResult = TextEditingController();


  Future<void> getApiData() async {
    var client = http.Client();
    var categoryResponse =await client.get(Uri.parse("https://dummyjson.com/products/categories"));
    var productResponse = await client.get(Uri.parse("https://dummyjson.com/products"));
    if(categoryResponse.statusCode == 200){
      setState((){
        category = categoryFromJson(categoryResponse.body);
        isloading = true;
      });
    }
    if(productResponse.statusCode == 200){
      setState(() {
        product = productsFromJson(productResponse.body);
      });
    }
  }

  Future<void> categoryResponse(String text) async{
    var baseUrl = "https://dummyjson.com/products/category/$text";
    var response = await http.Client().get(Uri.parse(baseUrl));
    if(response.statusCode == 200){
      setState(() {
        product = productsFromJson(response.body);
      });
    }
  }

  Future<void> searchResponse(String text) async{
    var baseUrl = "https://dummyjson.com/products/search";
    Map<String, String> queryParams = {
      'q': '$text',
    };

    String query = Uri(queryParameters : queryParams).query;
    var result = baseUrl + "?" + query;

    var searchResponse = await http.Client().get(Uri.parse(result));
    if(searchResponse.statusCode == 200){
      setState(() {
        product = productsFromJson(searchResponse.body);
      });

    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData();
    print(DateTime.timestamp().toString().substring(0,10));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Column(children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Flutter.Text(
                      "Explore",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 35,
                          fontFamily: "sans-serif-condensed-light",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Flutter.Text(
                      "Best Shopping Experience for you",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontFamily: "sans-serif-condensed-light",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: searchResult,
                      onChanged: (text){
                        searchResponse(text);
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(color: Color(0xffF67952))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(color: Color(0xffF67952))),
                          labelText: "Search",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          floatingLabelStyle: TextStyle(
                              color: Color(0xffF67952),
                              fontFamily: "sans-serif-condensed-light",
                              fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontFamily: "sans-serif-condensed-light",
                              fontWeight: FontWeight.bold),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Color(0xffF67952),
                        suffixIconColor: Color(0xffF67952),
                        /*suffixIcon: searchResult.text.isNotEmpty
                            ? IconButton(
                              onPressed: searchResult.clear,
                              icon: Icon(Icons.clear))
                            : Container()*/
                      ),
                    ),
                  ),
                  SizedBox(height: 10,)
                ],),
                Visibility(
                    visible: isloading,
                    replacement: Center(child: CircularProgressIndicator(color: Color(0xffF67952))),
                    child: Expanded(
                  child: Column(children: [
                    Container(
                      height: 60,
                      alignment: Alignment.center,
                      child: ListView.builder(itemCount: category.length,scrollDirection: Axis.horizontal,itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            categoryResponse(category[index]);
                          },
                          child: Container(
                            width: 130,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Color(0xffF67952).withOpacity(0.7),borderRadius: BorderRadius.circular(25),),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Flutter.Text(
                                  category[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "sans-serif-condensed-light",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
                      },),
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                        child: GridView.builder(itemCount: product?.limit,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context, index) {
                          return Card(shape:OutlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)),borderRadius: BorderRadius.circular(20)),
                            elevation: 10,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product!.products[index]),));
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Expanded(child: Image.network(product!.products[index].thumbnail,fit:BoxFit.fill,height: 200,)),
                                    Flutter.Text(product!.products[index].title,style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "sans-serif-condensed-light",
                                        fontWeight: FontWeight.bold),
                                    ),
                                    Flutter.Text("\$ ${product!.products[index].price.toString()} /-",style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "sans-serif-condensed-light",
                                        fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },))
                  ],),
                )),
              ],
            ),
          ),
    );
  }

}
