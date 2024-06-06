import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/order_model.dart';
import 'package:doan/views/order/orderdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void _navigateToOrderDetail(OrderModel order, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          OrderDetail(order: order), // Trang chi tiết là ProductDetail
    ),
  );
}

Widget itemOrderView(OrderModel itemoder, BuildContext context) {
  return GestureDetector(
    onTap: () {
      _navigateToOrderDetail(itemoder, context);
    },
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            const SizedBox(width: 20.0),
            Expanded(
              child: Row(children: [
                const Column(
                  children: [
                    Icon(Icons.fire_truck,color: Colors.amber,size: 34,),
                  ],
                ),
                SizedBox(
                  width: 26,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<DocumentSnapshot>(
                      future: itemoder.username!.get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading...');
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return Text('Category not found');
                        }
                        var data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        var customerName = data[
                            'CustomerName']; // Thay 'CustomerName' bằng tên trường chứa tên khách hàng
                        return Text("Customer: ${customerName ?? "???"}");
                      },
                    ),
                    const SizedBox(height: 4.0),
                    Text('Total quantity: ${itemoder.totalQuantity} '),
                    const SizedBox(height: 4.0),
                    Text('Total price: ${itemoder.totalPrice} VNĐ',
                        style: TextStyle(color: Colors.red)),
                    const SizedBox(height: 4.0),
                    // Text('DateOder: ${DateTime.fromMillisecondsSinceEpoch(itemoder.orderdate!.millisecondsSinceEpoch)}'), // Chuyển đổi timestamp sang DateTime và hiển thị
                    const SizedBox(height: 4.0),

                    const SizedBox(height: 4.0),
                  ],
                ),
              ]),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.update),
                  color: Colors.yellow.shade800,
                  onPressed: () async {
                    _navigateToOrderDetail(itemoder, context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
