import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Color(0xFFD36B00),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 60, left: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(spreadRadius: 1, color: Colors.white)
                  ]),
              child: const Text(
                '4IT Bakery',
                style: TextStyle(
                    color: Color(0xFFD36B00),
                    backgroundColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
