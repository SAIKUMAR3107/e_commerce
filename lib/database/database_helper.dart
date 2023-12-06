
import 'dart:io';

import 'package:e_commerce/model/address_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/all_products_model.dart';
import '../model/cart_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "cart.db");
    return await openDatabase(path,version: 1,onCreate: _onCreate);
  }

  Future _onCreate(Database db,int version) async {
    await db.execute('''
    CREATE TABLE cartproduct(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    primaryId INTEGER,
    title TEXT,
    description TEXT,
    price INTEGER,
    discountPercentage INTEGER,
    rating INTEGER,
    stock INTEGER,
    brand TEXT,
    category TEXT,
    thumbnail TEXT,
    quantity INTEGER,
    eachTotal INTEGER,
    date TEXT,
    addressId INTEGER
        )
    ''');

    await db.execute('''
    CREATE TABLE favoriteproduct(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    primaryId INTEGER,
    title TEXT,
    description TEXT,
    price INTEGER,
    discountPercentage INTEGER,
    rating INTEGER,
    stock INTEGER,
    brand TEXT,
    category TEXT,
    thumbnail TEXT,
    quantity INTEGER,
    eachTotal INTEGER,
    date TEXT,
    addressId INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE checkoutTable(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    primaryId INTEGER,
    title TEXT,
    description TEXT,
    price INTEGER,
    discountPercentage INTEGER,
    rating INTEGER,
    stock INTEGER,
    brand TEXT,
    category TEXT,
    thumbnail TEXT,
    quantity INTEGER,
    eachTotal INTEGER,
    date TEXT,
    addressId INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE myOrdersTable(
    id INTEGER,
    primaryId INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    price INTEGER,
    discountPercentage INTEGER,
    rating INTEGER,
    stock INTEGER,
    brand TEXT,
    category TEXT,
    thumbnail TEXT,
    quantity INTEGER,
    eachTotal INTEGER,
    date TEXT,
    addressId INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE addressTable(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fullName TEXT,
    mobileNumber TEXT,
    buildingName TEXT,
    street TEXT,
    state TEXT,
    pinCode INTEGER,
    city TEXT,
    addressType INTEGER
    )
    ''');

  }

  // CART TABLE QUERIES
  Future<List<CartProduct>> getCart() async {
    Database db = await instance.database;
    var cartProductItem = await db.query("cartproduct",orderBy: 'id');
    List<CartProduct> cartProductList = cartProductItem.isNotEmpty ? cartProductItem.map((e) => CartProduct.fromMap(e)).toList() : [] ;
    return cartProductList;
  }

  Future<int> addCartItem(CartProduct cart) async {
    Database db = await instance.database;
    return await db.insert("cartproduct", cart.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteCartItem(int id) async {
    Database db = await instance.database;
    return await db.delete('cartproduct',where: 'id = ?',whereArgs: [id]);
  }

  Future<int> updateCart(CartProduct cartProduct) async {
    Database db = await instance.database;
    return await db.update("cartproduct", cartProduct.toMap(),where: "id = ?",whereArgs: [cartProduct.productId]);
  }

  Future<Object?> cartTotal() async {
    Database db = await instance.database;
    var priceList = await db.rawQuery("SELECT SUM(eachTotal) AS TOTAL FROM cartproduct");
    priceList = priceList.toList();
    return priceList[0]['TOTAL'];
  }

  Future<void> deleteCartTable() async{
    Database db = await instance.database;
    await db.rawDelete("DELETE FROM cartproduct");
  }

  // FAVORITE TABLE QUERIES
  Future<List<CartProduct>> getFavorite() async {
    Database db = await instance.database;
    var cartProductItem = await db.query("favoriteproduct",orderBy: 'id');
    List<CartProduct> cartProductList = cartProductItem.isNotEmpty ? cartProductItem.map((e) => CartProduct.fromMap(e)).toList() : [] ;
    return cartProductList;
  }


  Future<int> addFavoriteItem(CartProduct cart) async {
    Database db = await instance.database;
    return await db.insert("favoriteproduct", cart.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> favoriteDeleteItem(int id) async {
    Database db = await instance.database;
    return await db.delete('favoriteproduct',where: 'id = ?',whereArgs: [id]);
  }

  //CHECKOUT TABLE QUERIES
  Future<List<CartProduct>> getCheckoutItems() async {
    Database db = await instance.database;
    var cartProductItem = await db.query("checkoutTable",orderBy: 'id');
    List<CartProduct> cartProductList = cartProductItem.isNotEmpty ? cartProductItem.map((e) => CartProduct.fromMap(e)).toList() : [] ;
    return cartProductList;
  }

  Future<int> addCheckoutItem(CartProduct cart) async {
    Database db = await instance.database;
    return await db.insert("checkoutTable", cart.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Object?> checkOutTotal() async {
    Database db = await instance.database;
    var priceList = await db.rawQuery("SELECT SUM(eachTotal) AS TOTAL FROM checkoutTable");
    priceList = priceList.toList();
    return priceList[0]['TOTAL'];
  }

  Future<void> deleteCheckOutTable() async{
    Database db = await instance.database;
    db.rawDelete("DELETE FROM checkoutTable");
  }

  //ADDRESS TABLE QUERIES
  Future<int> addAddress(Address address) async {
    Database db = await instance.database;
    return await db.insert("addressTable", address.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Address>> getAddress() async {
    Database db = await instance.database;
    var addressItem =await db.query("addressTable",orderBy: 'id');
    List<Address> addressList = addressItem.isNotEmpty ? addressItem.map((e) => Address.fromMap(e)).toList() : [];
    return addressList;
  }

  Future<List<Map<String, Object?>>> getEachAddress(int id) async{
    Database db = await instance.database;
    return await db.query("addressTable",where: 'id = ?',whereArgs: [id]);
  }

  //MY ORDER TABLE QUERIES
  Future<int> addMyOrderItem(CartProduct myOrder) async {
    Database db = await instance.database;
    return await db.insert("myOrdersTable", myOrder.toMap());
  }

  Future<List<CartProduct>> getMyOrderItems() async {
    Database db = await instance.database;
    var myOrderItem = await db.query("myOrdersTable");
    List<CartProduct> myOrdersList = myOrderItem.isNotEmpty ? myOrderItem.map((e) => CartProduct.fromMap(e)).toList() : [] ;
    return myOrdersList;
  }


}