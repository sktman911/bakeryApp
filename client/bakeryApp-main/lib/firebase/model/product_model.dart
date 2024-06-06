import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/firebase/model/firebase_model.dart';

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
  num? price;
  num? quantity;

  ProductModel({
    this.id,  
    this.bannerImage,
    this.description,
    this.name,
    this.category,
    this.price,
    this.quantity,
  });

  @override
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      bannerImage: json['bannerImage'],
      description: json['description'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'bannerImage': bannerImage,
      'description': description,
      'name': name,
      'category': category,
      'price': price,
      'quantity': quantity,
    };
    return data;
  }

  @override
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImage = json['bannerImage'];
    description = json['description'];
    name = json['name'];
    category = json['category'];
    price = json['price'];
    quantity = json['quantity'];
  }

  //Phương thức lấy top list model
  Future<List<ProductModel>> getTopListData(
      String collection, ProductModel Function() modelContructor,
      {bool getId = false}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .where('quantity', isGreaterThan: 0)
          .limit(15)
          .get();
      List<ProductModel> items = [];
      for (var doc in querySnapshot.docs) {
        ProductModel item = modelContructor();

        item.loadDataIntoModel(doc, getId: getId);
        items.add(item);
      }
      return items;
    } catch (e) {
      // print(e);
      return [];
    }
  }

  //Phương thức lấy new list model
  Future<List<ProductModel>> getNewListData(
      String collection, ProductModel Function() modelContructor,
      {bool getId = false}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .where('quantity', isGreaterThan: 0)
          .orderBy('dateCreated', descending: true)
          .limit(3)
          .get();
      List<ProductModel> items = [];
      for (var doc in querySnapshot.docs) {
        ProductModel item = modelContructor();
        item.loadDataIntoModel(doc, getId: getId);
        items.add(item);
      }
      return items;
    } catch (e) {
      return [];
    }
  }
}
