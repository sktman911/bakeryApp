import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserListTile extends StatelessWidget {
  final Icon icon;
  final String title;
  final dynamic url;

  const UserListTile(
      {Key? key, required this.icon, required this.title, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (title == 'Logout') {
              FirebaseAuth.instance.signOut();
              GoogleSignIn().signOut();
            }
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return url;
            }));
          },
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 25,
            leading: icon,
            title: Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        if (title != "My Favorite" && title != "Logout") const Divider()
      ],
    );
  }
}
