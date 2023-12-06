

class CartProduct{
  int? primaryId;
  int productId;
  String title;
  String description;
  int price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  int? quantity;
  int? eachtotal;
  String? date;
  int? addressId;

  CartProduct({
    this.primaryId,
    required this.productId,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    this.quantity,
    this.eachtotal,
    this.date,
    this.addressId
  });

  factory CartProduct.fromMap(Map<String,dynamic> json) => CartProduct(
    primaryId: json["primaryId"],
    productId: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    discountPercentage: json["discountPercentage"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
    stock: json["stock"],
    brand: json["brand"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    quantity: json["quantity"],
    eachtotal: json["eachTotal"],
    date: json["date"],
    addressId: json["addressId"]
    );

  Map<String,dynamic> toMap() {
    return {
      "primaryId": primaryId,
      "id" : productId,
      "title": title,
      "description": description,
      "price": price,
      "discountPercentage": discountPercentage,
      "rating": rating,
      "stock": stock,
      "brand": brand,
      "category": category,
      "thumbnail": thumbnail,
      "quantity" : quantity,
      "eachTotal" : eachtotal,
      "date" : date,
      "addressId" : addressId
    };
  }

}

