import 'package:flutter/material.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Expanded(
            flex: 2,
            child: Container(

              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 90),
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
