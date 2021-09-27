class FavoritesModel {
  late bool status;
   String? message;
   Data? data;



  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
   int? id;
   Product? product;

  Data({required this.id, required this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }


}

class Product {
  late int id;
  late int price;
  late int oldPrice;
  late int discount;
  late String image;

  Product({required this.id, required this.price, required this.oldPrice, required this.discount, required this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }


}