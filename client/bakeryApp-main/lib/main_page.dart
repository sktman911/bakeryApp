import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/pages/cart_page.dart';
import 'package:demo_app/pages/home_page.dart';
import 'package:demo_app/pages/login_page.dart';
import 'package:demo_app/pages/order_page.dart';
import 'package:demo_app/pages/user_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  static const pages = [HomePage(), OrderPage(), CartPage(), UserPage()];

  static const items = <Widget>[
    Icon(
      Icons.home_outlined,
      size: 30,
      color: customOrange,
    ),
    Icon(
      Icons.receipt_outlined,
      size: 30,
      color: customOrange,
    ),
    Icon(
      Icons.shopping_cart_outlined,
      size: 30,
      color: customOrange,
    ),
    Icon(
      Icons.person_outline,
      size: 30,
      color: customOrange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        backgroundColor: customWhite,
        body: Container(
          child: pages[currentIndex],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: customWhite,
          index: currentIndex,
          onTap: (index) {
            setState(() => currentIndex = index);
          },
          height: 60,
          color: customWhite,
          items: items,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
