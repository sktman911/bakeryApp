import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';

class LoginProvider {
  var db = FirebaseFirestore.instance;

  Future<ProfileModel?> loginAdmin(String email, String password) async {
    try {
      var querySnapshot = await db.collection('Administrator').get();
      for (var docSnapshot in querySnapshot.docs) {
        String adminEmail = docSnapshot.data()['AdminEmail'];
        String adminPassword = docSnapshot.data()['AdminPassword'];
        var checkEncryptedPass = await FlutterBcrypt.verify(password: password, hash: adminPassword);
        if (email == adminEmail && checkEncryptedPass == true) {
          String adminId = docSnapshot.data()['AdminId'];
          String adminAddress = docSnapshot.data()['AdminAddress'];
          String adminPhone = docSnapshot.data()['AdminPhone'];
          String adminName = docSnapshot.data()['AdminName'];
          String adminRoleName = docSnapshot.data()['RoleName'];
          ProfileModel userAdmin = ProfileModel(
              adminId: adminId,
              adminAddress: adminAddress,
              adminEmail: adminEmail,
              adminName: adminName,
              adminPhone: adminPhone,
              roleName: adminRoleName);
          return userAdmin;
        }
        return null;
      }
    } catch (e) {
      print('Failed to login admin: $e');
      return null;
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  Future<void> saveUser(ProfileModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    prefs.setString('user', userJson);
  }

  Future<ProfileModel?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return ProfileModel.fromJsonReturn(userMap);
    }
    return null;
  }

  Future<String?> encryptedPassword(String password) async {
    try {
      // Tạo mật khẩu salt
      String salt = await FlutterBcrypt.salt();
      // Mã hóa mật khẩu với salt
      String hashedPassword =
          await FlutterBcrypt.hashPw(password: password, salt: salt);
      return hashedPassword;
    } catch (e) {
      print("Error encrypted passowrd: $e");
      return null;
    }
  }
}
