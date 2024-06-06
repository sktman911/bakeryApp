import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/data/provider/cartProvider.dart';
import 'package:demo_app/firebase/model/firebase_operator.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:demo_app/firebase/model/voucher_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UnVoucherListWidget extends StatefulWidget {
  const UnVoucherListWidget({super.key});

  @override
  State<UnVoucherListWidget> createState() => _UnVoucherListWidgetState();
}

class _UnVoucherListWidgetState extends State<UnVoucherListWidget> {
  List<VoucherModel> lstVoucher = [];
  List<VoucherModel> tempAvailableLst = [];
  double _total = 0;

  getTotal() async {
    var total = await CartProvider().getTotalPrice();
    setState(() {
      _total = total;
    });
  }

  Future<List<VoucherModel>> loadVouchers() async {
    lstVoucher = await VoucherModel().getListDataWhereAnd(
        VoucherModel().collection,
        () => VoucherModel(),
        FirebaseCondition(
            field: 'quantity', operator: FirebaseCondition.higher, value: 0),
        FirebaseCondition(
            field: 'expire',
            operator: FirebaseCondition.higher,
            value: Timestamp.now()));

    // filter voucher can't apply

    lstVoucher.removeWhere((element) => _total >= element.required!);

    return lstVoucher;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotal();
    loadVouchers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadVouchers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return Column(
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: lstVoucher.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            child: Image.asset(
                              'assets/images/voucher.jpg',
                              width: 150,
                              height: 170,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lstVoucher[index].voucherName!,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Expire: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade700),
                                      ),
                                      Expanded(
                                        child: Text(
                                          DateFormat('dd/MM/yyyy').format(
                                              lstVoucher[index]
                                                  .expire!
                                                  .toDate()),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade700),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Require: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade700),
                                      ),
                                      Text(
                                        lstVoucher[index].description!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade700),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.grey)),
                                          onPressed: null,
                                          child: Text(
                                            'Apply',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          );
        });
  }
}
