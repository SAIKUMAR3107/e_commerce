import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../model/cart_model.dart';
import '../provider/product_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Favorites",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "sans-serif-condensed-light"),),centerTitle: true,backgroundColor: Colors.white,iconTheme: IconThemeData(color: Color(0xffF67952)),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<CartProduct>>(
          future: DatabaseHelper.instance.getFavorite(),
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
                  Image.asset(
                    "assets/svg_icons/emptycart.png",
                    height: 400,
                    width: 400,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "No Favorites",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: "sans-serif-condensed-light"),
                  ),
                ],
              ),
            )
                : GridView.builder(itemCount: snapshot.data?.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.7,crossAxisCount: 2),itemBuilder: (context, index) {
              return Card(shape:OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(20)),
                elevation: 10,
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Expanded(child: Image.network(snapshot.data![index].thumbnail,fit:BoxFit.fill,height: 200,)),
                      Text(snapshot.data![index].title,style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "sans-serif-condensed-light",
                          fontWeight: FontWeight.bold),
                      ),
                      Text("\$ : ${snapshot.data![index].price.toString()} /-",style: TextStyle(
                          color: Colors.black,
                          fontFamily: "sans-serif-condensed-light",
                          fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF67952),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          onPressed: () {
                            setState(() {
                              DatabaseHelper.instance.favoriteDeleteItem(snapshot.data![index].productId);
                              cart.removeFavoriteCount();
                            });
                          }, child: Icon(Icons.delete) ,),
                      )
                    ],
                  ),
                ),
              );
            },);
          },
        )
        ),
      );
  }
}
