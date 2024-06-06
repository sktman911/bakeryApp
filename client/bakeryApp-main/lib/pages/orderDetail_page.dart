import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/components/OrderDetail/OrderItems.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/order_model.dart';
import 'package:demo_app/pages/checkout_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderModel orderModel;
  const OrderDetailPage({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(children: [
            // order detail appbar
            AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: customOrange,
                ),
              ),
              title: const Text(
                'Order Detail',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Delivered',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('EEE, dd/MM/yyyy hh:mm:ss a')
                                .format(orderModel.orderedDate!.toDate()),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(orderModel.id!)
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Divider(),

                // delivery detail
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Delivery detail',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.store_mall_directory_outlined,
                            color: customOrange,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Store address',
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                const Text(
                                  '828 Sư Vạn Hạnh Q.10 ',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                      // dots icon
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                        child: Row(
                          children: [
                            Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),

                      // client address
                      Row(
                        children: [
                          const Icon(
                            Icons.my_location,
                            size: 30,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivery address',
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                Text(
                                  orderModel.orderAddress!,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                // end delivery detail
                const Divider(),

                // order products
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Dishes',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      OrderItems(
                        orderModel: orderModel,
                      ),
                    ],
                  ),
                ),
                const Divider(),

                //payment detail
                FutureBuilder(
                    future: orderModel.voucher?.get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      Map<String, dynamic> voucherRef;
                      if (snapshot.data != null) {
                        voucherRef =
                            snapshot.data!.data() as Map<String, dynamic>;
                      } else {
                        voucherRef = {};
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Payment detail',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade900,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 12,
                            ),

                            // subtotal
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'SubTotal',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                      snapshot.data != null
                                          ? NumberFormat("###,###.###").format(
                                              orderModel.totalPrice! +
                                                  voucherRef['voucherValue'])
                                          : NumberFormat("###,###.###").format(
                                              orderModel.totalPrice! + 0),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),

                            // delivery fee
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery fee',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text('30.000 đ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),

                            // discount fee
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Discount',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                      snapshot.data != null
                                          ? "- ${NumberFormat('###,###.###').format(voucherRef['voucherValue'])} đ"
                                          : "- ${NumberFormat('###,###.###').format(0)} đ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),

                            const Divider(),

                            // order total
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                      "${NumberFormat("###,###.###").format(orderModel.totalPrice)} đ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })
              ],
            ),
          ]),
        ),
        // bottomNavigationBar: Container(
        //   padding: const EdgeInsets.all(20),
        //   decoration: BoxDecoration(
        //       border: Border(
        //           top: BorderSide(width: 4, color: Colors.grey.withOpacity(.1)))),
        //   child: FloatingActionButton(
        //       backgroundColor: const Color(0xFFD36B00),
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => const CheckoutPage()));
        //       },
        //       child: const Text(
        //         'Order',
        //         style: TextStyle(fontSize: 16, color: Colors.white),
        //       )),
        // ),
      ),
    );
  }

  Widget paymentDetail(OrderModel orderModel) {
    return FutureBuilder(
        future: orderModel.voucher!.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, dynamic> voucherRef =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Payment detail',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 12,
                ),

                // subtotal
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SubTotal',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                          NumberFormat("###,###.###").format(
                              orderModel.totalPrice! +
                                  voucherRef['voucherValue']!),
                          style: const TextStyle(fontWeight: FontWeight.w500))
                    ],
                  ),
                ),

                // delivery fee
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery fee',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text('0 đ', style: TextStyle(fontWeight: FontWeight.w500))
                    ],
                  ),
                ),

                // discount fee
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Discount',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                          "- ${NumberFormat('###,###.###').format(voucherRef['voucherValue'])} đ",
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),

                const Divider(),

                // order total
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                          "${NumberFormat("###,###.###").format(orderModel.totalPrice)} đ",
                          style: const TextStyle(fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
