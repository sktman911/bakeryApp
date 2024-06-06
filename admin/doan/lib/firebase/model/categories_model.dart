
import 'dart:io';

import 'package:doan/firebase/model/firebase_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryModel extends FirebaseModel {
  //
  @override
  String get collection => "Categories";
  /*
  -------------------------------------------------------------------------------
   */
  // Id get from document id
  String? id;
  String? CategoryName,icon;

  CategoryModel({
    this.id,
    this.CategoryName,
    this.icon
  });

  @override
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    CategoryName = json['name'];
    icon = json['icon'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': CategoryName,
      'icon': icon,
    };
    return data;
  }

  //Phương thức tải file lên Firebase trả về link tới file đó (String)
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
