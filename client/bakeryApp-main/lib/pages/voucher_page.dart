import 'package:demo_app/components/Voucher/UnVoucherList.dart';
import 'package:demo_app/components/Voucher/VoucherList.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/firebase_operator.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:demo_app/firebase/model/voucher_model.dart';
import 'package:flutter/material.dart';

class VoucherPage extends StatefulWidget {
  VoucherModel voucherModel;
  int voucherPrice;
  final Function setNewVoucher;
  VoucherPage(
      {super.key,
      required this.voucherModel,
      required this.setNewVoucher,
      required this.voucherPrice});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  bool _enabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // voucher appbar
            AppBar(
              title: const Text(
                'Voucher',
                style: TextStyle(
                    color: customOrange,
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: customOrange,
                ),
              ),
            ),

            const SizedBox(
              height: 12,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 6),
              child: Row(
                children: [
                  Text(
                    'Available',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            // voucher list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: VoucherListWidget(
                voucherModel: widget.voucherModel,
                setNewVoucher: widget.setNewVoucher,
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 6, top: 12),
              child: Row(
                children: [
                  Text(
                    'Unavailable',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            // unavailable voucher list
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: UnVoucherListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
