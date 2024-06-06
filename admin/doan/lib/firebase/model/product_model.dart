import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/firebase_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductModel extends FirebaseModel {
  //
  @override
  String get collection => "Products";
  /*
  -------------------------------------------------------------------------------
   */
  // Id get from document id
  String? id;
  String? bannerImage, description, name;
  DocumentReference? category;
  int? price, quantity;
  Timestamp? dateCreated;

  ProductModel({
    this.id,
    this.bannerImage,
    this.description,
    this.name,
    this.category,
    // this.cost,
    this.price,
    // this.discount,
    this.quantity,
    this.dateCreated
  });

  @override
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImage = json['bannerImage'];
    description = json['description'];
    name = json['name'];
    category = json['category'];
    // cost = (json['cost']as num).toInt();
    price = (json['price']as num).toInt();
    // discount = (json['discount'] as num).toInt();
    quantity = (json['quantity']as num).toInt();
    dateCreated = json['dateCreated'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'bannerImage': bannerImage,
      'description': description,
      'name': name,
      'category': category,
      // 'cost': cost,
      'price': price,
      // 'discount': discount,
      'quantity': quantity,
      'dateCreated': dateCreated
    };
    return data;
  }

  static Future<String> uploadImageAndGetLink(
      String collection, File file) async {
    try {
      //Lấy thời gian làm tên
      String imageName = DateTime.now().microsecondsSinceEpoch.toString();
      //Khởi tạo
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('images/$collection/$imageName');
      //Upload file
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      //Lấy URL của file vừa up
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }
}
