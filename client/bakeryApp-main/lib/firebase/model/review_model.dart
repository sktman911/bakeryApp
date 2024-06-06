import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/firebase/model/firebase_model.dart';

class ReviewModel extends FirebaseModel {
  //
  @override
  String get collection => "Reviews";
  /*
  -------------------------------------------------------------------------------
   */
  // Id get from document id
  String? id;
  String? description;
  DocumentReference? customer, product;
  Timestamp? reviewDate;
  int? count;

  ReviewModel(
      {this.description,
      this.customer,
      this.product,
      this.reviewDate,
      this.count});

  @override
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['Description'];
    customer = json['customer'];
    product = json['product'];
    reviewDate = json['reviewDate'];
    count = json['count'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      // 'id': id,
      'Description': description,
      'customer': customer,
      'product': product,
      'reviewDate': reviewDate,
      'count': count,
    };
    return data;
  }
}
