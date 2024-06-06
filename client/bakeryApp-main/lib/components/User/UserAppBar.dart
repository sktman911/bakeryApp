import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/conf/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: customWhite,
      padding: const EdgeInsets.only(bottom: 30, top: 60, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FirebaseAuth.instance.currentUser!.photoURL != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    FirebaseAuth.instance.currentUser!.photoURL!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  defaultUserImage,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
