

class CartItem {
  String productId;
  String productName;
  num productPrice;
  int quantity;
  String img;

  CartItem(
      {required this.productId,
      required this.productName,
      required this.productPrice,
      required this.quantity,
      required this.img});

  factory CartItem.fromJson(Map<String, dynamic> res) {
    return CartItem(
        productId: res['productId'],
        productName: res['productName'],
        productPrice: res['productPrice'],
        quantity: res['quantity'],
        img: res['img']);
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'img': img,
    };
  }
}
