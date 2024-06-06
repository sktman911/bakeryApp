import 'dart:ui';

import 'package:demo_app/data/model/product.dart';
import 'package:demo_app/pages/changePass_page.dart';
import 'package:demo_app/pages/favorite_page.dart';
import 'package:demo_app/pages/login_page.dart';
import 'package:demo_app/pages/profile_page.dart';
import 'package:demo_app/pages/register_page.dart';
import 'package:demo_app/pages/voucher_page.dart';
import 'package:flutter/material.dart';

const customOrange = Color(0xFFD36B00);
const customBrown = Color(0xFFA0522D);
const customWhite = Color(0xFFF7F1E5);

const googleMapAPIKey = "AIzaSyAzSSxYEnHx3TL963hnYFftU8zPcXW9x5s";
// AIzaSyBEtnfcVl8pLXIiBSkE2sJXiSzyM1fASb8

const successIcon = "assets/images/successful_payment_icon.png";

const defaultUserImage = 'assets/images/default_user.png';
const productUrl = 'assets/images/products/';

const userSettings = [
  {
    "title": "My Profile",
    "icon": Icon(
      Icons.person,
      size: 28,
      color: customBrown,
    ),
    "url": ProfilePage()
  },
  {
    "title": "My Favorite",
    "icon": Icon(
      Icons.favorite,
      size: 28,
      color: Colors.red,
    ),
    "url": FavoritePage()
  },
  // {
  //   "title": "Change Password",
  //   "icon": Icons.lock_outline_rounded,
  //   "url": ChangePassPage()
  // }
];

const userGenerals = [
  {
    "title": "Language",
    "icon": Icon(
      Icons.language,
      color: Colors.blueAccent,
      size: 28,
    ),
    "url": "/"
  },
  {
    "title": "Help",
    "icon": Icon(
      Icons.help,
      color: Colors.blueAccent,
      size: 28,
    ),
    "url": "/"
  },
  {
    "title": "Settings",
    "icon": Icon(
      Icons.settings,
      color: Colors.grey,
      size: 28,
    ),
    "url": "/"
  },
  // {"title": "Login", "icon": Icons.login, "url": LoginPage()},
  // {"title": "Sign Up", "icon": Icons.person_add, "url": RegisterPage()},
  {
    "title": "Logout",
    "icon": Icon(
      Icons.logout,
      size: 28,
      color: Colors.red,
    ),
    "url": LoginPage(),
    "button": Function
  }
];

List<Object> categoriesImg = [
  {'name': 'Bread', 'path': 'assets/icons/bread.png'},
  {'name': 'Cake', 'path': 'assets/icons/cake.png'},
  {'name': 'Cookie', 'path': 'assets/icons/cookie.png'},
  {'name': 'Cupcake', 'path': 'assets/icons/cupcake.png'},
  {'name': 'Donut', 'path': 'assets/icons/donut.png'},
];

List<Product> products = [
  Product(
      productId: 1,
      productName: "Bread 1",
      productPrice: 30000,
      quantity: 10,
      img: "${productUrl}product1.jpg",
      des:
          "This loaf of bread is a golden-brown masterpiece, freshly baked to perfection. Its crust is crisp, offering a satisfying crunch as you bite into it, while inside, the bread is soft and pillowy. With a tantalizing aroma that fills the air, it beckons you to indulge in its comforting warmth. Each slice reveals a delicate network of airy pockets, testament to the skilled craftsmanship that went into its creation. Whether toasted to a golden hue or enjoyed fresh with a smear of butter, this bread is a timeless classic that satisfies the senses with every bite."),
  Product(
      productId: 2,
      productName: "Bread 2",
      productPrice: 37000,
      quantity: 10,
      img: "${productUrl}whiteCreamBread.png",
      des: "Nod des"),
  Product(
      productId: 3,
      productName: "Bread 3",
      productPrice: 47000,
      quantity: 10,
      img: "${productUrl}croissant.jpg",
      des: "Nod des"),
];

const String googleMapApiKey = "AIzaSyBEtnfcVl8pLXIiBSkE2sJXiSzyM1fASb8";
