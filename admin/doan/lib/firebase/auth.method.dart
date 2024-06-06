import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthMethod {
  static const FACEBOOK = 'Facebook';
  static const GOOGLE = 'Google';
  static const PH = 'Phone';
  static const EM = 'Email';

  static Future<UserCredential?> loginWithEmail(email, password) async {
    UserCredential? result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return result;
  }

  static Future<UserCredential?> loginWithSocial(String type) async {
    UserCredential? result;
    switch (type) {
      case FACEBOOK:
        final facebook = FacebookAuthProvider();
        if (kIsWeb) {
          result = await FirebaseAuth.instance.signInWithPopup(facebook);
        } else {
          result = await FirebaseAuth.instance.signInWithProvider(facebook);
        }
        break;
      case GOOGLE:
        final google = GoogleAuthProvider();
        if (kIsWeb) {
          result = await FirebaseAuth.instance.signInWithPopup(google);
        } else {
          result = await FirebaseAuth.instance.signInWithProvider(google);
        }
        break;
    }
    return result;
  }

  static Future<String?> linkFacebookToAccount() async {
    UserCredential result;
    final facebook = FacebookAuthProvider();
    if (kIsWeb) {
      result = await FirebaseAuth.instance.signInWithPopup(facebook);
    } else {
      result = await FirebaseAuth.instance.signInWithProvider(facebook);
    }
    final credential =
        FacebookAuthProvider.credential(result.credential!.accessToken!);
    try {
      final user = await FirebaseAuth.instance.currentUser!
          .linkWithCredential(credential);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          return "Tài khoản Facebook đã được liên kết với người dùng hiện tại.";
        case "invalid-credential":
          return "Tài khoản Facebook không hợp lệ.";
        case "credential-already-in-use":
          return "Tài khoản Facebook đã được liên kết với một người dùng khác trên hệ thống.";
        default:
          return "Lỗi không xác định.";
      }
    }
  }

  static Future<String?> linkGoogleToAccount() async {
    UserCredential result;
    final google = GoogleAuthProvider();
    if (kIsWeb) {
      result = await FirebaseAuth.instance.signInWithPopup(google);
    } else {
      result = await FirebaseAuth.instance.signInWithProvider(google);
    }
    final credential = GoogleAuthProvider.credential(
        accessToken: result.credential!.accessToken);
    try {
      final user = await FirebaseAuth.instance.currentUser!
          .linkWithCredential(credential);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          return "Tài khoản Google đã được liên kết với người dùng hiện tại.";
        case "invalid-credential":
          return "Tài khoản Google không hợp lệ.";
        case "credential-already-in-use":
          return "Tài khoản Google đã được liên kết với một người dùng khác trên hệ thống.";
        default:
          return "Lỗi không xác định.";
      }
    }
  }

  static Future<String?> linkPhoneToAccount(String phoneNumber) async {
    UserCredential result;
    final facebook = FacebookAuthProvider();
    if (kIsWeb) {
      result = await FirebaseAuth.instance.signInWithPopup(facebook);
    } else {
      result = await FirebaseAuth.instance.signInWithProvider(facebook);
    }
    final credential =
        FacebookAuthProvider.credential(result.credential!.accessToken!);
    try {
      final user = await FirebaseAuth.instance.currentUser!
          .linkWithCredential(credential);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          return "Tài khoản Facebook đã được liên kết với người dùng hiện tại.";
        case "invalid-credential":
          return "Tài khoản Facebook không hợp lệ.";
        case "credential-already-in-use":
          return "Tài khoản Facebook đã được liên kết với một người dùng khác trên hệ thống.";
        default:
          return "Lỗi không xác định.";
      }
    }
  }
}
