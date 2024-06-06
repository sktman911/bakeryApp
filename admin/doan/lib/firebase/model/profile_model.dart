
import 'package:doan/firebase/model/firebase_model.dart';

class ProfileModel extends FirebaseModel {
  //
  @override
  String get collection => "Administrator";
  /*
  -------------------------------------------------------------------------------
   */
  // Id get from document id
  String? adminId, adminAddress, adminEmail,adminName,adminPassword,adminPhone,roleName;

  ProfileModel({
    this.adminId,
    this.adminAddress,
    this.adminEmail,
    this.adminName,
    this.adminPassword,
    this.adminPhone,
    this.roleName,
  });
  

  @override
  void fromJson(Map<String, dynamic> json) {
    adminId = json['AdminId'];
    adminAddress = json['AdminAddress'];
    adminEmail = json['AdminEmail'];
    adminName = json['AdminName'];
    adminPassword = json['AdminPassword'];
    adminPhone = json['AdminPhone'];
    roleName = json['RoleName'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'AdminId' : adminId,
      'AdminAddress': adminAddress,
      'AdminEmail': adminEmail,
      'AdminName': adminName,
      'AdminPassword': adminPassword,
      'AdminPhone': adminPhone,
      'RoleName': roleName,
    };
    return data;
  }

  factory ProfileModel.fromJsonReturn(Map<String, dynamic> json) {
    return ProfileModel(
      adminId: json['AdminId'],
      adminAddress: json['AdminAddress'],
      adminEmail: json['AdminEmail'],
      adminName: json['AdminName'],
      adminPassword: json['AdminPassword'],
      adminPhone: json['AdminPhone'],
      roleName: json['RoleName'],
    );
  }

  
}
