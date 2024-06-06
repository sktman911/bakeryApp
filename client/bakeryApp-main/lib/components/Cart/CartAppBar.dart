import 'package:demo_app/conf/const.dart';
import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 20, top: 30, left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Shopping Cart",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: customOrange,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
