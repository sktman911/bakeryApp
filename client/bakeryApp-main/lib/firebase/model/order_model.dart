import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/firebase/model/firebase_model.dart';

class OrderModel extends FirebaseModel {
  //
  @override
  String get collection => "Orders";
  /*
  -------------------------------------------------------------------------------
   */
  // Id get from document id
  String? id;
  int? totalPrice;
  List? items;
  int? totalQuantity;
  String? orderAddress;
  Timestamp? orderedDate;
  DocumentReference? username, voucher, purchaseMethod, purchaseStatus;

  OrderModel(
      {this.id,
      this.orderedDate,
      this.purchaseMethod,
      this.purchaseStatus,
      this.totalPrice,
      this.totalQuantity,
      this.username,
      this.voucher,
      this.items,
      this.orderAddress});

  @override
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderedDate = json['orderedDate'];
    purchaseMethod = json['purchase_method'];
    purchaseStatus = json['purchase_status'];
    totalPrice = json['totalPrice'];
    totalQuantity = json['totalQuantity'];
    username = json['username'];
    voucher = json['voucher'];
    items = json['items'];
    orderAddress = json['orderAddress'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'orderedDate': orderedDate,
      'purchase_method': purchaseMethod,
      'purchase_status': purchaseStatus,
      'totalPrice': totalPrice,
      'totalQuantity': totalQuantity,
      'username': username,
      'voucher': voucher,
      'items': items,
      'orderAddress': orderAddress
    };
    return data;
  }
}
