import 'dart:convert';

import 'package:demo_app/data/model/cart.dart';
import 'package:demo_app/data/model/product.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  Future<void> addToCart(ProductModel product, int quantity) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> storage = pref.getStringList('cart') ?? [];
    List<CartItem> cartItems =
        storage.map((e) => CartItem.fromJson(jsonDecode(e))).toList();

    // check exits in cart
    int index = cartItems.indexWhere((e) => e.productId == product.id);

    if (index != -1) {
      cartItems[index].quantity += quantity;
    } else {
      cartItems.add(CartItem(
          productId: product.id!,
          quantity: quantity,
          productName: product.name!,
          productPrice: product.price!,
          img: product.bannerImage!));
    }

    await pref.setStringList(
        'cart', cartItems.map((e) => jsonEncode(e.toJson())).toList());
  }

  Future<void> removeCartItem(CartItem product) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> storage = pref.getStringList('cart') ?? [];
    List<CartItem> cartItems =
        storage.map((e) => CartItem.fromJson(jsonDecode(e))).toList();

    int index = cartItems.indexWhere((e) => e.productId == product.productId);

    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else if (cartItems[index].quantity == 1) {
      cartItems.removeAt(index);
    }

    await pref.setStringList(
        'cart', cartItems.map((e) => jsonEncode(e.toJson())).toList());
  }

  Future<void> updateCartItems(CartItem product, int quantity) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> storage = pref.getStringList('cart') ?? [];
    List<CartItem> cartItems =
        storage.map((e) => CartItem.fromJson(jsonDecode(e))).toList();

    int index = cartItems.indexWhere((e) => e.productId == product.productId);
    cartItems[index].quantity++;

    await pref.setStringList(
        'cart', cartItems.map((e) => jsonEncode(e.toJson())).toList());
  }

  Future<List<CartItem>> getCart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> storage = pref.getStringList('cart') ?? [];
    List<CartItem> cartItems =
        storage.map((e) => CartItem.fromJson(jsonDecode(e))).toList();
    return cartItems;
  }

  Future<double> getTotalPrice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> storage = pref.getStringList('cart') ?? [];
    List<CartItem> cartItems =
        storage.map((e) => CartItem.fromJson(jsonDecode(e))).toList();

    double totalPrice = 0.0;

    for (var item in cartItems) {
      totalPrice += item.quantity * item.productPrice;
    }

    return totalPrice;
  }

  Future<int> getQuantity() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> storage = pref.getStringList('cart') ?? [];
    List<CartItem> cartItems =
        storage.map((e) => CartItem.fromJson(jsonDecode(e))).toList();

    int quantity = 0;

    for (var item in cartItems) {
      quantity += item.quantity;
    }

    return quantity;
  }

  Future<void> clearCart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> storage = pref.getStringList('cart') ?? [];
    List<CartItem> cartItems =
        storage.map((e) => CartItem.fromJson(jsonDecode(e))).toList();
    await pref.setStringList('cart', []);
  }
}
