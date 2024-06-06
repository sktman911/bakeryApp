import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_model.dart';

class CustomerModel extends FirebaseModel {
  //
  @override
  String get collection => "Customers";
  /*
  -------------------------------------------------------------------------------
   */
  // Id get from document id
  String? id;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? customerUserName;
  String? customerPassword;
  String? facebookId;
  String? googleId;
  int? customerPoint;
  bool? customerIsActive;
  DocumentReference? roleName;

  CustomerModel({
    this.id,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.customerUserName,
    this.customerPassword,
    this.customerIsActive,
    this.customerPoint,
    this.googleId,
    this.facebookId,
    this.roleName,
  });

  @override
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['CustomerName'];
    customerPhone = json['CustomerPhone'];
    customerAddress = json['CustomerAddress'];
    customerUserName = json['CustomerUserName'];
    customerPassword = json['CustomerPassword'];
    facebookId = json['Facebook_id'];
    googleId = json['Google_id'];
    customerPoint = json['CustomerPoint'];
    customerIsActive = json['CustomerIsActive'];
    roleName = json['RoleName'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'CustomerName': customerName,
      'CustomerPhone': customerPhone,
      'CustomerAddress': customerAddress,
      'CustomerUserName': customerUserName,
      'CustomerPassword': customerPassword,
      'Facebook_id': facebookId,
      'Google_id': googleId,
      'CustomerPoint': customerPoint,
      'CustomerIsActive': customerIsActive,
      'RoleName': roleName,
    };
    return data;
  }
}
