
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/firebase_model.dart';

class CustomerModel extends FirebaseModel {
  //
  @override
  String get collection => "Customers";
  /*
  -------------------------------------------------------------------------------
   */
  // Id get from document id
  String? id;
  String? CustomerName;
  String? CustomerPhone;
  String? CustomerAddress;
  String? CustomerUserName;
  String? CustomerPasswork;
  String? Facebook_id;
  String? Google_id;
  int? CustomerPoint;
  bool? CustomerIsActive;
  DocumentReference? RoleName;

  CustomerModel({
    this.id,
    this.CustomerName,
    this.CustomerPhone,
    this.CustomerAddress,
    this.CustomerUserName,
    this.CustomerPasswork,
    this.Facebook_id,
    this.Google_id,
    this.CustomerPoint,
    this.CustomerIsActive,
    this.RoleName,
  });

  @override
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    CustomerName = json['CustomerName'];
    CustomerPhone = json['CustomerPhone'];
    CustomerAddress = json['CustomerAddress'];
    CustomerUserName = json['CustomerUserName'];
    CustomerPasswork = json['CustomerPasswork'];
    Facebook_id = json['Facebook_id'];
    Google_id = json['Google_id'];
    CustomerPoint = json['CustomerPoint'];
    CustomerIsActive = json['CustomerIsActive'];
    RoleName = json['RoleName'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'CustomerName': CustomerName,
      'CustomerPhone': CustomerPhone,
      'CustomerAddress': CustomerAddress,
      'CustomerUserName': CustomerUserName,
      'CustomerPasswork': CustomerPasswork,
      'Facebook_id': Facebook_id,
      'Google_id': Google_id,
      'CustomerPoint': CustomerPoint,
      'CustomerIsActive': CustomerIsActive,
      'RoleName': RoleName,
    };
    return data;
  }

  
}