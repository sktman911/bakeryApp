import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/firebase_operator.dart';
import 'package:doan/firebase/model/profile_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseModel {
  String get collection;
  Map<String, dynamic> toJson();
  void fromJson(Map<String, dynamic> json);

  //Thêm
  Future<void> add(String collection) async {
    try {
      await FirebaseFirestore.instance.collection(collection).add(toJson());
    } catch (e) {
      rethrow;
    }
  }

  //Xóa
  Future<void> delete(String id) async {
    try {
      await FirebaseFirestore.instance.collection(collection).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  //Sửa
  Future<void> update(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(id)
          .update(toJson());
    } catch (e) {
      rethrow;
    }
  }

  //Phương thức load 1 record vào model (nếu model có id thì để getId = true)
  FirebaseModel loadDataIntoModel(DocumentSnapshot doc, {bool getId = false}) {
    final data = doc.data() as Map<String, dynamic>;
    if (getId) {
      data.addAll({'id': doc.id});
    }
    fromJson(data);
    return this;
  }

  //Phương thức tải file lên Firebase trả về link tới file đó (String)
  // static Future<String> uploadImageAndGetLink(
  //     String collection, File file) async {
  //   try {
  //     //Lấy thời gian làm tên
  //     String imageName = DateTime.now().microsecondsSinceEpoch.toString();
  //     //Khởi tạo
  //     FirebaseStorage storage = FirebaseStorage.instance;
  //     Reference ref = storage.ref().child('images/$collection/$imageName');
  //     //Upload file
  //     UploadTask uploadTask = ref.putFile(file);
  //     TaskSnapshot snapshot = await uploadTask;
  //     //Lấy URL của file vừa up
  //     String downloadUrl = await snapshot.ref.getDownloadURL();

  //     return downloadUrl;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //Phương thức lấy list model của ModelContructor tương ứng
  static Future<List<Model>> getListData<Model extends FirebaseModel>(
      String collection, FirebaseModel Function() modelContructor,
      {bool getId = false}) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collection).get();
      List<Model> items = [];
      for (var doc in querySnapshot.docs) {
        Model item = modelContructor() as Model;
        item.loadDataIntoModel(doc, getId: getId);
        items.add(item);
      }
      return items;
    } catch (e) {
      return [];
    }
  }

  static Stream<Model> getStreamData<Model extends FirebaseModel>(
      String collection, FirebaseModel Function() modelContructor,
      [bool getId = false]) async* {
    var stream = FirebaseFirestore.instance.collection(collection).snapshots();
    await for (var snapshot in stream) {
      for (var doc in snapshot.docs) {
        Model model = modelContructor() as Model;
        model.loadDataIntoModel(doc, getId: getId);
        yield model;
      }
    }
  }

  
  //Lấy data theo id trả về Model theo ModelContructor tương ứng
  static Future<Model> getDataById<Model extends FirebaseModel>(
    FirebaseModel Function() modelContructor, String docId,
    {bool getId = false}) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection((modelContructor() as FirebaseModel).collection)
        .doc(docId) // Sử dụng Document ID
        .get();

      Model item = modelContructor() as Model;
      item.loadDataIntoModel(doc, getId: getId);
      return item;
    } catch (e) {
      return modelContructor() as Model;
    }
  }

  static Future<ProfileModel?> getDataByEmail(String email) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Administrator')
        .where('AdminEmail', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Lấy thông tin đầu tiên (ví dụ: nếu có nhiều tài khoản có cùng email)
      var doc = querySnapshot.docs[0];
      ProfileModel userProfile = ProfileModel();
      userProfile.fromJson(doc.data() as Map<String, dynamic>);
      return userProfile;
    } else {
      // Không tìm thấy người dùng với email tương ứng
      return null;
    }
  } catch (e) {
    // Xử lý lỗi
    print("Error: $e");
    return null;
  }
}

  //Lấy list data model với điều kiện hoặc
  static Future<List<Model>> getListDataWhereOr<Model extends FirebaseModel>(
      String collection,
      FirebaseModel Function() modelContructor,
      FirebaseCondition condition1,
      FirebaseCondition condition2,
      [FirebaseCondition? condition3,
      FirebaseCondition? condition4,
      FirebaseCondition? condition5,
      bool getId = false]) async {
    try {
      condition3 = condition3 ?? FirebaseCondition();
      condition4 = condition4 ?? FirebaseCondition();
      condition5 = condition5 ?? FirebaseCondition();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .where(
            Filter.or(
              condition1.convertToCondition()!,
              condition2.convertToCondition()!,
              condition3.convertToCondition(),
              condition4.convertToCondition(),
              condition5.convertToCondition(),
            ),
          )
          .get();
      List<Model> items = [];
      for (var doc in querySnapshot.docs) {
        Model item = modelContructor() as Model;
        item.loadDataIntoModel(doc, getId: getId);
        items.add(item);
      }
      return items;
    } catch (e) {
      return [];
    }
  }

  //Lấy list data model với điều kiện và
  static Future<List<Model>> getListDataWhereAnd<Model extends FirebaseModel>(
      String collection,
      FirebaseModel Function() modelContructor,
      FirebaseCondition condition1,
      FirebaseCondition condition2,
      [FirebaseCondition? condition3,
      FirebaseCondition? condition4,
      FirebaseCondition? condition5,
      bool getId = false]) async {
    try {
      condition3 = condition3 ?? FirebaseCondition();
      condition4 = condition4 ?? FirebaseCondition();
      condition5 = condition5 ?? FirebaseCondition();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .where(
            Filter.and(
              condition1.convertToCondition()!,
              condition2.convertToCondition()!,
              condition3.convertToCondition(),
              condition4.convertToCondition(),
              condition5.convertToCondition(),
            ),
          )
          .get();
      List<Model> items = [];
      for (var doc in querySnapshot.docs) {
        Model item = modelContructor() as Model;
        item.loadDataIntoModel(doc, getId: getId);
        items.add(item);
      }
      return items;
    } catch (e) {
      return [];
    }
  }

//Lấy list data model với 1 điều kiện
  Future<List<Model>> getListDataWhere<Model extends FirebaseModel>(
      String collection,
      FirebaseModel Function() modelContructor,
      FirebaseCondition condition,
      {bool getId = false}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .where(condition.convertToCondition()!)
          .get();
      List<Model> items = [];
      for (var doc in querySnapshot.docs) {
        Model item = modelContructor() as Model;
        item.loadDataIntoModel(doc, getId: getId);
        items.add(item);
      }
      return items;
    } catch (e) {
      return [];
    }
  }

  static Stream<List<Model>> getStreamDataList<Model extends FirebaseModel>(
      String collection, FirebaseModel Function() modelConstructor,
      [bool getId = false]) async* {
    var stream = FirebaseFirestore.instance.collection(collection).snapshots();

    await for (var snapshot in stream) {
      List<Model> dataList = [];
      for (var doc in snapshot.docs) {
        Model model = modelConstructor() as Model;
        await model.loadDataIntoModel(doc, getId: getId);
        dataList.add(model);
      }
       yield dataList;
    }

    
    
  }
}
