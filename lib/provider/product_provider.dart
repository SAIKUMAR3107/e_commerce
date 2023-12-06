
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider with ChangeNotifier{
  var quantity=0;
  var favoriteQuantity =0;
  int get _quantity => quantity;
  void setPreference() async{
    var setquan=await SharedPreferences.getInstance();
    setquan.setInt("quantity", quantity);
    setquan.setInt("favorite", favoriteQuantity);
  }
  void getPreference() async{
    var setquan=await SharedPreferences.getInstance();
    quantity=setquan.getInt("quantity") ?? 0;
    favoriteQuantity = setquan.getInt("favorite") ?? 0;
  }
  void addCount(){
    quantity++;
    setPreference();
  }
  void removeCount(){
    if(quantity > 0){
      quantity--;
      setPreference();
    }
  }

  void addFavoriteCount(){
    favoriteQuantity++;
    setPreference();
  }
  void removeFavoriteCount(){
    if(favoriteQuantity > 0){
      favoriteQuantity--;
      setPreference();
    }
  }

  int gettotalCount(){
    getPreference();
    return quantity;
  }
  int getFavoriteCount() {
    getPreference();
    return favoriteQuantity;
  }
}