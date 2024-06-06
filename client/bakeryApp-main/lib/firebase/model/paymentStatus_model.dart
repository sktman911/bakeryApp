import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/firebase/model/firebase_model.dart';

class PaymentStatus extends FirebaseModel {
  //
  @override
  String get collection => "PaymentStatus";
  /*
  -------------------------------------------------------------------------------
   */
  // Id get from document id
  String? id;
  String? statusName;

  PaymentStatus({this.id, this.statusName});

  @override
  void fromJson(Map<String, dynamic> json) {
    id = json['id'];

    statusName = json['StatusName'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'id': id, 'StatusName': statusName};
    return data;
  }
}
