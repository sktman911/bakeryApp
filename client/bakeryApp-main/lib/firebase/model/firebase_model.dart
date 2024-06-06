import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/firebase/model/firebase_operator.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseModel {
  String get collection;
  Map<String, dynamic> toJson();
  void fromJson(Map<String, dynamic> json);

  //Thêm
  Future<void> add(String collection, [String? doc = null]) async {
    try {
      if (doc == null) {
        await FirebaseFirestore.instance.collection(collection).add(toJson());
      } else {
        await FirebaseFirestore.instance
            .collection(collection)
            .doc(doc)
            .set(toJson());
      }
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
      print(e);
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
  Future<String?> uploadImageAndGetLink(File file) async {
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

  //Phương thức lấy list model của ModelContructor tương ứng
  Future<List<Model>> getListData<Model extends FirebaseModel>(
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

  //Lấy data theo id trả về Model theo ModelContructor tương ứng
  Future<Model> getDataById<Model extends FirebaseModel>(
      FirebaseModel Function() modelContructor, String id,
      {bool getId = false}) async {
    try {
      Model item = modelContructor() as Model;
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(item.collection)
          .doc(id)
          .get();

      // Model item = modelContructor() as Model;

      item.loadDataIntoModel(doc, getId: getId);
      return item;
    } catch (e) {
      return modelContructor() as Model;
    }
  }

  //Lấy list data model với điều kiện hoặc
  Future<List<Model>> getListDataWhereOr<Model extends FirebaseModel>(
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
  Future<List<Model>> getListDataWhereAnd<Model extends FirebaseModel>(
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
}
