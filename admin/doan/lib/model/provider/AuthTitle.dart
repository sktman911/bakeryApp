import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  final String title, subTitle;
  const AuthTitle({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Text(
            subTitle,
            style: TextStyle(fontSize: 15, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }
}
