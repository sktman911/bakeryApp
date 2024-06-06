import 'package:demo_app/components/Order/OrderList.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/paymentStatus_model.dart';
import 'package:demo_app/pages/orderDetail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String initValue = 'Status';
  List<PaymentStatus> methods = [];

  Future<List<PaymentStatus>> loadMethod() async {
    methods = await PaymentStatus()
        .getListData(PaymentStatus().collection, () => PaymentStatus());
    return methods;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
          // physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                AppBar(
                  title: const Text(
                    'Order',
                    style: TextStyle(
                        color: customOrange,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                ),

                const Divider(),

                // dropdown button status
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      FutureBuilder(
                        future: loadMethod(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center();
                          }
                          var initDropdown = const DropdownMenuItem(
                              value: 'Status', child: Text('Status'));
                          List<DropdownMenuItem<String>> dropdownItems = [];
                          // dropdownItems.add(initDropdown);
                          dropdownItems = snapshot.data!
                              .map((method) => DropdownMenuItem(
                                    value: method.id,
                                    child: Text(method.statusName!),
                                  ))
                              .toList();
                          dropdownItems.add(initDropdown);
                          return Container(
                            padding: const EdgeInsets.only(left: 10, right: 5),
                            decoration: BoxDecoration(
                                color: customWhite,
                                border:
                                    Border.all(width: 1.5, color: Colors.grey),
                                borderRadius: BorderRadius.circular(100)),
                            child: DropdownButton<String>(
                                value: initValue,
                                onChanged: (value) {
                                  setState(() {
                                    initValue = value!;
                                  });
                                },
                                underline: Container(
                                  color: Colors.transparent,
                                ),
                                items: dropdownItems),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                OrderList(),
              ],
            ),
          ]),
    );
  }
}
