import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/firebase_model.dart';

class VoucherModel extends FirebaseModel {
  //
  @override
  String get collection => "Vouchers";
  /*
  -------------------------------------------------------------------------------
   */
  // Id get from document id
  String? id;
  String? description, voucherName;
  int? quantity, voucherValue,required;
  Timestamp? dateCreated, expire;

  VoucherModel({
    this.id,
    this.description,
    this.voucherName,
    this.quantity,
    this.voucherValue,
    this.dateCreated,
    this.expire,
    this.required,
  });

  @override
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    voucherName = json['voucherName'];
    quantity = json['quantity'];
    voucherValue = json['voucherValue'];
    dateCreated = json['dateCreated'];
    expire = json['expire'];
    required = json['required'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'description': description,
      'voucherName': voucherName,
      'quantity': quantity,
      'voucherValue': voucherValue,
      'dateCreated': dateCreated,
      'expire': expire,
      'required': required,
    };
    return data;
  }

  
}
