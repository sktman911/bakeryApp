import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/model/provider/loginprovider.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';

class AdministratorProvider {
  var db = FirebaseFirestore.instance;

  Future<void> updateInfo(String adminId, String adminName, String adminPhone,
      String adminAddress) async {
    try {
      var querySnapshot = await db.collection('Administrator').doc(adminId);
      querySnapshot.update({
        'AdminName': adminName,
        'AdminAddress': adminAddress,
        'AdminPhone': adminPhone
      }).then((value) => print("DocumentSnapshot successfully updated!"),
          onError: (e) => print("Error updating document $e"));
    } catch (e) {
      print('Failed to update admin: $e');
    }
  }

  Future<String> getAdminPassword(String userId) async {
    try {
      var adminPassword;
      var querySnapshot =
          await db.collection('Administrator').doc(userId).get();
      adminPassword = querySnapshot.data()!['AdminPassword'];
      return adminPassword;
    } catch (e) {
      print('Failed to get password: $e');
      return '';
    }
  }

  Future<bool> checkMatchPass(
      String userId, String oldPass, String newPass, String reNewPass) async {
    bool flag = false;
    String oldPassAdmin = await getAdminPassword(userId);
    if (oldPass.isEmpty || newPass.isEmpty || reNewPass.isEmpty) {
      flag = false;
    }
    bool checkHashpass = await FlutterBcrypt.verify(password: oldPass, hash: oldPassAdmin);
    if (newPass == reNewPass && checkHashpass == true) {
      flag = true;
    }
    return flag;
  }

  Future<void> updatePassword(String userId, String newPassword) async {
    try {
      var encryptedPass = await LoginProvider().encryptedPassword(newPassword);
      var querySnapshot = await db.collection('Administrator').doc(userId);
      querySnapshot.update({
        'AdminPassword': encryptedPass,
      }).then((value) => print("DocumentSnapshot successfully updated!"),
          onError: (e) => print("Error updating document $e"));
    } catch (e) {
      print('Failed to update admin: $e');
    }
  }
}