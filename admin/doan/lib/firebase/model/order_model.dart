import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/firebase_model.dart';// Import model ProductModel

class OrderDetailModel {
  DocumentReference product;
  int quantity;

  OrderDetailModel({required this.product,required this.quantity});

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      product: json['product'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product'] = product;
    data['quantity'] = quantity;
    return data;
  }
}

class OrderModel extends FirebaseModel {
  //
  @override
  String get collection => "Orders";
  /*
  -------------------------------------------------------------------------------
   */
  // Id get from document id
  String? id;
  Timestamp? orderdate;
  List<OrderDetailModel>? items;
  int? totalQuantity,totalPrice;

  DocumentReference? username;
  DocumentReference? paymentMethod;
  DocumentReference? purchaseStatus;
  DocumentReference? voucher;

  OrderModel({
    this.id,
    this.orderdate,
    this.items,
    this.username,
    this.paymentMethod,
    this.purchaseStatus,
    this.voucher,
    this.totalQuantity,
    this.totalPrice,
  });



  @override
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderdate = json['orderedDate'];
    if (json['items'] != null) {
      items = (json['items'] as List<dynamic>).map<OrderDetailModel>((item) {
        return OrderDetailModel.fromJson(item as Map<String, dynamic>);
      }).toList();
    }
    username = json['username'];
    paymentMethod = json['purchase_method'];
    purchaseStatus = json['purchase_status'];
    voucher = json['voucher'];
    totalQuantity = json['totalQuantity'];
    totalPrice = json['totalPrice'];
  }
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'orderedDate': orderdate,
      'items': items,
      'username': username,
      'purchase_method': paymentMethod,
      'purchase_status': purchaseStatus,
      'voucher': voucher,
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
    };
    return data;
  }
}