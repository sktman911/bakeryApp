class Product {
  int productId;
  String? productName;
  int? productPrice;
  int? quantity;
  String? img;
  String? des;

  Product(
      {required this.productId,
      this.productName,
      this.productPrice,
      this.quantity,
      this.img,
      this.des});

  factory Product.fromJson(Map<String, dynamic> res) {
    return Product(
        productId: res['productId'],
        productName: res['productName'],
        productPrice: res['productPrice'],
        quantity: res['quantity'],
        img: res['img'],
        des: res['des']);
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'img': img,
      'des': des
    };
  }
}
