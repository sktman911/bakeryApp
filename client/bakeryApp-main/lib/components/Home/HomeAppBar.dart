import 'package:demo_app/conf/const.dart';
import 'package:demo_app/data/provider/cartProvider.dart';
import "package:flutter/material.dart";
import 'package:badges/badges.dart' as badges;

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  CartProvider cartProvider = CartProvider();

  int _quantity = 0;

  Future<void> loadQuantity() async {
    final quantity = await cartProvider.getQuantity();
    setState(() {
      _quantity = quantity;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadQuantity();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: customWhite,
      leading: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              size: 25,
              color: customBrown,
            ),
            Text(
              "HCM City, Vietnam",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: customOrange),
            ),
          ],
        ),
      ),
      leadingWidth: double.maxFinite,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: badges.Badge(
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(5),
            ),
            badgeContent: FutureBuilder(
              future: loadQuantity(),
              builder: (context, snapshot) {
                return Text(
                  _quantity.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                );
              },
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: customBrown,
              size: 25,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: badges.Badge(
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(7),
            ),
            badgeContent: const Text(
              "0",
              style: TextStyle(color: Colors.white),
            ),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.notifications_none_outlined,
                color: customBrown,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
