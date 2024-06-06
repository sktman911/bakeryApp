import 'package:demo_app/conf/const.dart';
import 'package:demo_app/data/model/cart.dart';
import 'package:demo_app/data/provider/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartItemWidget extends StatefulWidget {
  final Function loadTotalPrice;
  const CartItemWidget({super.key, required this.loadTotalPrice});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  CartProvider cartProvider = CartProvider();
  List<CartItem> cartList = [];

  void loadCartItems() async {
    final cart = await cartProvider.getCart();
    setState(() {
      cartList = cart;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: cartList.map((e) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: customBrown),
            borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: Row(children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: Colors.black.withOpacity(.1))
                    ]),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: Image.network(
                    e.img,
                    fit: BoxFit.fill,
                    width: 160,
                    height: 120,
                  ),
                ),
              ),
            ],
          ),

          // detail
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        e.productName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${NumberFormat('###,###.###').format(e.productPrice)} VNĐ",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          cartProvider.removeCartItem(e);
                          widget.loadTotalPrice();
                          loadCartItems();
                        },
                        child: Icon(Icons.remove_circle,
                            size: 30, color: Colors.black.withOpacity(.7)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Text(
                            e.quantity.toString(),
                            style: const TextStyle(fontSize: 16),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          cartProvider.updateCartItems(e, e.quantity);
                          loadCartItems();
                          widget.loadTotalPrice();
                        },
                        child: Icon(
                          Icons.add_circle,
                          size: 30,
                          color: Colors.black.withOpacity(.7),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      );
    }).toList());
  }
}
