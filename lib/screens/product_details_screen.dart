import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/database/database_helper.dart';
import 'package:e_commerce/model/all_products_model.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';
import 'cart_screen.dart';
import 'favorite_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  Product product;


  ProductDetailsScreen(
      {required this.product,super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int position = 0;
  bool click = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favorite();
  }

  Future<void> favorite() async{
      List<CartProduct> m = [];
      await DatabaseHelper.instance.getFavorite().then((value) {
        setState(() {
          m = value;
        });
      });
      List<String> favList = [];
      for(int i = 0;i<=m.length-1;i++){
        favList.add(m[i].title);
      }
      if(favList.contains(widget.product.title)){
        click = true;
      }
      else{
        click = false;
      }
  }



  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<ProductProvider>(context);
    final List<Widget> imageSliders = widget.product.images
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item,height: 500, width: double.infinity,),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        iconTheme: IconThemeData(color: Color(0xffF67952)),
        actions: [
          badge.Badge(
            position: badge.BadgePosition.topStart(top: -1, start: 25),
            badgeContent: Consumer<ProductProvider>(
              builder: (context, value, valid) {
                return Text(
                  value.gettotalCount().toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cary is Empty")));
              },
              icon: Center(child: Icon(Icons.shopping_cart)),
            ),
          ),
          badge.Badge(
            position: badge.BadgePosition.topStart(top: -1, start: 25),
            badgeContent: Consumer<ProductProvider>(
              builder: (context, value, valid) {
                return Text(
                  value.getFavoriteCount().toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteScreen(),
                    ));
                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cary is Empty")));
              },
              icon: Center(child: Icon(Icons.favorite)),
            ),
          ),
        ],
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey.shade200,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(20),
                      color: Colors.grey.shade200,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(alignment: Alignment.topRight,
                            child: IconButton(onPressed: () async{
                              if(click){
                                click = false;
                                DatabaseHelper.instance.favoriteDeleteItem(widget.product.id);
                                cart.removeFavoriteCount();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item removed from Favorites")));
                              }
                              else{
                                click = true;
                                List<CartProduct> m = [];
                                await DatabaseHelper.instance.getFavorite().then((value) {
                                  setState(() {
                                    m = value;
                                  });
                                });
                                List<String> titleList = [];
                                for(int i = 0;i<=m.length-1;i++){
                                  titleList.add(m[i].title);
                                }
                                if(m.isEmpty){
                                  await DatabaseHelper.instance.addFavoriteItem(CartProduct(primaryId: 0,productId: widget.product.id, title: widget.product.title, description: widget.product.description, price: widget.product.price, discountPercentage: widget.product.discountPercentage, rating: widget.product.rating, stock: widget.product.stock, brand: widget.product.brand, category: widget.product.category, thumbnail: widget.product.thumbnail,quantity: 0,eachtotal: 0,date: DateTime.now().toString().substring(0,10)));
                                  cart.addFavoriteCount();
                                  click = true;
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added to Favorite")));
                                }
                                else{
                                  if(titleList.contains(widget.product.title)){
                                    setState(() {
                                      DatabaseHelper.instance.favoriteDeleteItem(widget.product.id);
                                      cart.removeFavoriteCount();
                                      click = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Removed from Favorite")));
                                  }
                                  else{
                                    click = true;
                                    await DatabaseHelper.instance.addFavoriteItem(CartProduct(productId: widget.product.id, title: widget.product.title, description: widget.product.description, price: widget.product.price, discountPercentage: widget.product.discountPercentage, rating: widget.product.rating, stock: widget.product.stock, brand: widget.product.brand, category: widget.product.category, thumbnail: widget.product.thumbnail,quantity: 0,eachtotal: 0,date: DateTime.now().toString().substring(0,10)));
                                    cart.addFavoriteCount();
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added to Favorite")));
                                  }
                                }
                                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item added to Favorites")));
                              }
                            }, icon: click ? Icon(Icons.favorite,color: Color(0xffF67952),) : Icon(Icons.favorite_border,color: Color(0xffF67952),),)
                          ),
                          CarouselSlider(
                              items: imageSliders,
                              options: CarouselOptions(
                                onPageChanged: (index,reason) {
                                  setState(() {
                                    position = index;
                                  });
                                },
                                aspectRatio: 2.0,
                                viewportFraction: 0.9,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: false,
                                height: 200,
                                initialPage: 2,
                                autoPlay: true,
                              )),
                          CarouselIndicator(index: position,count: imageSliders.length,color: Color(0xffF67952).withOpacity(0.5),activeColor: Color(0xffF67952)),
                        ],
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 40),
                      width: double.infinity,
                      decoration: BoxDecoration(

                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(flex: 3,child: Text(
                                widget.product.title,
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "sans-serif-condensed-light"),
                              )),
                              Expanded(flex:2,child:Container(alignment: Alignment.topRight,
                                child: Text(
                                  "\$ ${widget.product.price.toString()} /-",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sans-serif-condensed-light"),
                                ),
                              ))
                            ],
                          ),
                          SizedBox(height: 20,),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Description",
                              style: TextStyle(
                                color: Color(0xffF67952).withOpacity(0.7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "sans-serif-condensed-light"),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              widget.product.description+"The iPhone is a smartphone made by Apple that combines a computer, iPod, digital camera and cellular phone into one device with a touchscreen interface. The iPhone runs the iOS operating system, and in 2021 when the iPhone 13 was introduced, it offered up to 1 TB of storage and a 12-megapixel camera.",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "sans-serif-condensed-light"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                height: 50,
                                width: 200,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xffF67952),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40))),
                                  onPressed: () async {
                                    List<CartProduct> m = [];
                                    await DatabaseHelper.instance.getCart().then((value) {
                                      setState(() {
                                        m = value;
                                      });
                                    });
                                    print(DateTime.now().toString().substring(0,16));
                                    List<String> titleList = [];
                                    for(int i = 0;i<=m.length-1;i++){
                                      titleList.add(m[i].title);
                                    }
                                    if(m.isEmpty){
                                      await DatabaseHelper.instance.addCartItem(CartProduct(primaryId: 0,productId: widget.product.id, title: widget.product.title, description: widget.product.description, price: widget.product.price, discountPercentage: widget.product.discountPercentage, rating: widget.product.rating, stock: widget.product.stock, brand: widget.product.brand, category: widget.product.category, thumbnail: widget.product.thumbnail,quantity: 1,eachtotal: widget.product.price));
                                      cart.addCount();
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added to cart")));
                                    }
                                    else{
                                      if(titleList.contains(widget.product.title)){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item already in cart")));
                                      }
                                      else{
                                        await DatabaseHelper.instance.addCartItem(CartProduct(productId: widget.product.id, title: widget.product.title, description: widget.product.description, price: widget.product.price, discountPercentage: widget.product.discountPercentage, rating: widget.product.rating, stock: widget.product.stock, brand: widget.product.brand, category: widget.product.category, thumbnail: widget.product.thumbnail,quantity: 1,eachtotal: widget.product.price));
                                        cart.addCount();
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added to cart")));
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "sans-serif-condensed-light"),
                                  )
                                ),
                                ),
                              ),
                            ),
                        ],
                      )))
            ],
          )),
    );
  }
}
