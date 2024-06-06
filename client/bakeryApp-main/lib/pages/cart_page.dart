import 'package:demo_app/components/Cart/CartAppBar.dart';
import 'package:demo_app/components/Cart/CartItemWidget.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/data/provider/cartProvider.dart';
import 'package:demo_app/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartProvider cartProvider = CartProvider();
  double totalPrice = 0;

  void loadTotalPrice() async {
    final total = await cartProvider.getTotalPrice();
    setState(() {
      totalPrice = total;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(children: [
        Column(
          children: [
            const CartAppBar(),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: CartItemWidget(
                  loadTotalPrice: loadTotalPrice,
                )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 1,
              ))),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Total price: ${NumberFormat('###,###.###').format(totalPrice)} VNĐ',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 260,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (totalPrice == 0) {
                    return;
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CheckoutPage();
                  }));
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(customOrange)),
                child: const Text(
                  'Go to Checkout',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
