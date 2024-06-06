import 'package:demo_app/conf/const.dart';
import 'package:demo_app/data/model/cart.dart';
import 'package:demo_app/data/provider/cartProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

Widget checkoutItems(List<CartItem> cartItems) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: FutureBuilder(
          future: CartProvider().getCart(),
          builder: (context, snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  softWrap: true,
                                  cartItems[index].productName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                    '${NumberFormat('###,###.###').format(cartItems[index].productPrice)} VNĐ')
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    color: Colors.black.withOpacity(.3))
                              ], borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  cartItems[index].img,
                                  width: 100,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ]),
                      const SizedBox(
                        height: 12,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         InkWell(
                      //           onTap: () {},
                      //           child: const Icon(
                      //             Icons.remove_circle_outline,
                      //             size: 30,
                      //             color: customOrange,
                      //           ),
                      //         ),
                      //         const SizedBox(
                      //           width: 12,
                      //         ),
                      //         Text(
                      //           cartItems[index].quantity.toString(),
                      //           style: const TextStyle(
                      //               fontSize: 16, fontWeight: FontWeight.w500),
                      //         ),
                      //         const SizedBox(
                      //           width: 12,
                      //         ),
                      //         const Icon(
                      //           Icons.add_circle_outline,
                      //           size: 30,
                      //           color: customOrange,
                      //         )
                      //       ],
                      //     )
                      //   ],
                      // ),
                      if (index != cartItems.length - 1) const Divider(),
                    ],
                  ),
                );
              },
              // children: cartItems.map((e) {

              // }).toList(),
            );
          }));
}
