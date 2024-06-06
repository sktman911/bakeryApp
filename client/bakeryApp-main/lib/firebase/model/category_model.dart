import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/firebase/model/firebase_model.dart';

class CategoryModel extends FirebaseModel {
  //
  @override
  String get collection => "Categories";
  /*
  -------------------------------------------------------------------------------
   */
  // Id get from document id
  String? id;
  String? name, icon;

  CategoryModel({this.id, this.name, this.icon});

  @override
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'id': id, 'name': name, 'icon': icon};
    return data;
  }
}
