import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/order_model.dart';
import 'package:doan/model/provider/orderprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderDetail extends StatelessWidget {
  final OrderModel order;
  const OrderDetail({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FutureBuilder<DocumentSnapshot>(
                          future: order.username!.get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('Loading...');
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return const Text('Customer name not found');
                            }
                            var data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            var customerName = data[
                                'CustomerName']; // Thay 'CustomerName' bằng tên trường chứa tên khách hàng
                            return Expanded(
                                child: Text(
                              "Customer: $customerName",
                            ));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.production_quantity_limits,
                            color: Colors.amber),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Total quantity: ${order.totalQuantity}")
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.price_change,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Total price: ${order.totalPrice} VNĐ'),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Date: ${order.orderdate?.toDate().toString()}")
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Icon(
                    Icons.fire_truck,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Product: "),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: order.items!.map((OrderDetailModel e) {
                        return FutureBuilder<DocumentSnapshot>(
                          future: e.product
                              .get(), // Sử dụng e.product.get() thay vì e.get()
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('Loading...');
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return const Text('Product not found');
                            }
                            var data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            var productName = data[
                                'name']; // Thay 'CustomerName' bằng tên trường chứa tên khách hàng
                            var quantity = e.quantity;
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "$productName x$quantity ",
                                      softWrap: true,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ), // Thêm khoảng cách giữa các sản phẩm
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.numbers,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: order.paymentMethod!.get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Loading...');
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const Text('not found');
                        }
                        var data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        var customerName = data[
                            'MethodName']; // Thay 'CustomerName' bằng tên trường chứa tên khách hàng
                        return Text("Payment: $customerName");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.line_axis,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FutureBuilder<DocumentSnapshot>(
                          future: order.purchaseStatus!.get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('Loading...');
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return const Text(' not found');
                            }
                            var data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            var customerName = data[
                                'StatusName']; // Thay 'CustomerName' bằng tên trường chứa tên khách hàng
                            return Text("Status: $customerName");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // OutlinedButton(
                    //   onPressed: () async {
                    //     if (order.purchaseStatus ==
                    //         FirebaseFirestore.instance
                    //             .doc("/PaymentStatus/G06OcF3ToNDIkNKDycUq")) {
                    //       var purchaseStatus = FirebaseFirestore.instance
                    //           .doc("/PaymentStatus/d7v4D2rGIbXf0hyLpiaF");
                    //       await OrderProvider()
                    //           .updateOrder(order.id!, purchaseStatus);

                    //       //chuyển trang
                    //       Navigator.pop(context);
                    //       //hiện thông báo
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         const SnackBar(
                    //           backgroundColor: Colors.green,
                    //           content: Text(
                    //             'Payment status changed successfully ',
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //           duration: Duration(seconds: 2),
                    //         ),
                    //       );
                    //     } else {
                    //       //báo lỗi
                    //       ScaffoldMessenger.of(context)
                    //           .showSnackBar(const SnackBar(
                    //         backgroundColor: Colors.amber,
                    //         content: Text(
                    //           'Can not update status order!',
                    //           style: TextStyle(color: Colors.red),
                    //         ),
                    //         duration: Duration(seconds: 2),
                    //       ));
                    //     }
                    //   },
                    //   style: OutlinedButton.styleFrom(
                    //     side: const BorderSide(
                    //         width: 1,
                    //         color: Colors.red), // Thiết lập màu border
                    //   ),
                    //   child: const Text(
                    //     'Cancel',
                    //     style: TextStyle(fontSize: 16, color: Colors.red),
                    //   ),
                    // ),

                    ElevatedButton(
                        onPressed: () async {
                          if (order.purchaseStatus ==
                              FirebaseFirestore.instance
                                  .doc("/PaymentStatus/G06OcF3ToNDIkNKDycUq")) {
                            var purchaseStatus = FirebaseFirestore.instance
                                .doc("/PaymentStatus/yG3QiDibAl1plTAKMNfh");
                            await OrderProvider()
                                .updateOrder(order.id!, purchaseStatus);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'Payment status changed successfully ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else if (order.purchaseStatus ==
                              FirebaseFirestore.instance
                                  .doc("/PaymentStatus/yG3QiDibAl1plTAKMNfh")) {
                            var purchaseStatus = FirebaseFirestore.instance
                                .doc("/PaymentStatus/Wb89eWbgsYDelKUyJulH");
                            await OrderProvider()
                                .updateOrder(order.id!, purchaseStatus);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'Payment status changed successfully ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else if (order.purchaseStatus ==
                              FirebaseFirestore.instance
                                  .doc("/PaymentStatus/Wb89eWbgsYDelKUyJulH")) {
                            var purchaseStatus = FirebaseFirestore.instance
                                .doc("/PaymentStatus/mmEEHTMbB3TutWLB2J7N");
                            await OrderProvider()
                                .updateOrder(order.id!, purchaseStatus);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'Payment status changed successfully ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            //báo lỗi
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.amber,
                              content: Text(
                                'Can not update status order!',
                                style: TextStyle(color: Colors.red),
                              ),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        },
                        child: Text(
                          "${order.purchaseStatus == FirebaseFirestore.instance.doc("/PaymentStatus/G06OcF3ToNDIkNKDycUq") ? "Confirm" : order.purchaseStatus == FirebaseFirestore.instance.doc("/PaymentStatus/yG3QiDibAl1plTAKMNfh") ? "Delivery" : "Delivery successful"}",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
