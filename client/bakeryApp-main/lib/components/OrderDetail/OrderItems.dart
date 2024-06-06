import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/data/model/product.dart';
import 'package:demo_app/firebase/model/order_model.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:demo_app/firebase/model/review_model.dart';
import 'package:demo_app/pages/review_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItems extends StatefulWidget {
  final OrderModel orderModel;
  const OrderItems({super.key, required this.orderModel});

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    Duration timeLimit =
        currentTime.difference(widget.orderModel.orderedDate!.toDate());

    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.orderModel.items!.length,
        itemBuilder: (context, index) {
          var item = widget.orderModel.items![index];
          DocumentReference ref = item['product'];

          return FutureBuilder(
              future: ref.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                Map<String, dynamic> productItem =
                    snapshot.data!.data() as Map<String, dynamic>;
                productItem['id'] = ref.id;
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Image.network(
                                  productItem['bannerImage'],
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.fill,
                                ),
                                if (timeLimit.inHours <= 24)
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewPage(
                                                        productModel:
                                                            productItem)));
                                      },
                                      child: const Text('Review',
                                          style:
                                              TextStyle(color: customOrange)))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      productItem['name'] + " x ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    Text(item['quantity'].toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                  ],
                                ),
                                Text(
                                  "${NumberFormat('###,###.###').format(item['quantity'] * productItem['price'])} đ",
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ));
              });
        });
  }
}
