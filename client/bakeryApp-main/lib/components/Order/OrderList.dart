import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/firebase_operator.dart';
import 'package:demo_app/firebase/model/order_model.dart';
import 'package:demo_app/pages/orderDetail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pagination_flutter/pagination.dart';


Widget OrderList() {
  List<OrderModel> orderLst = [];

  Future<List<OrderModel>> loadOrders() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference ref =
        FirebaseFirestore.instance.doc("/Customers/$userId");

    orderLst = await OrderModel().getListDataWhere(
        OrderModel().collection,
        () => OrderModel(),
        FirebaseCondition(
            field: 'username', operator: FirebaseCondition.equal, value: ref),
        getId: true);

    return orderLst;
  }

  return FutureBuilder(
      future: loadOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderLst.length,
            itemBuilder: (context, index) {
              var status = orderLst[index].purchaseStatus;

              return FutureBuilder(
                  future: status!.get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center();
                    }

                    Map<String, dynamic> item =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderDetailPage(
                                      orderModel: orderLst[index],
                                    )));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Row(
                              children: [
                                Text(
                                  DateFormat('EEE, dd/MM/yyyy hh:mm:ss a')
                                      .format(orderLst[index]
                                          .orderedDate!
                                          .toDate()),
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 5),
                            elevation: 0,
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/orderImg.jpg',
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                orderLst[index]
                                                    .id!
                                                    .replaceRange(
                                                        8, null, '...'),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Text(
                                                "${NumberFormat('###,###.###').format(orderLst[index].totalPrice)} đ")
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green.shade800,
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  item['StatusName'],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            // ElevatedButton(
                                            //   onPressed: () {},
                                            //   style: ElevatedButton.styleFrom(
                                            //       backgroundColor:
                                            //           customOrange),
                                            //   child: const Text(
                                            //     'Order',
                                            //     style: TextStyle(
                                            //         color: Colors.white),
                                            //   ),
                                            // )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider()
                        ],
                      ),
                    );
                  });
            });
      });
}
