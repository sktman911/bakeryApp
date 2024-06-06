import 'package:demo_app/components/User/UserListTile.dart';
import 'package:demo_app/conf/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserBody extends StatelessWidget {
  const UserBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: userSettings
                  .map((e) => UserListTile(
                      icon: e['icon'] as Icon,
                      title: e['title'] as String,
                      url: e['url']))
                  .toList(),
            ),
          ),
          const Text(
            'General',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: userGenerals
                  .map((e) => UserListTile(
                      icon: e['icon'] as Icon,
                      title: e['title'] as String,
                      url: e['url']))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
