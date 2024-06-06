import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/conf/const.dart';
import 'package:doan/firebase/model/vouchers_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VoucherDetail extends StatelessWidget {
  final VoucherModel voucher;
  final imgVoucher = 'imgVoucher.jpg';
  const VoucherDetail({Key? key, required this.voucher}) : super(key: key);

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime =
        timestamp.toDate(); // Chuyển đổi Timestamp thành DateTime
    String formattedDate =
        ' ${dateTime.day}/${dateTime.month}/${dateTime.year}'; // Định dạng ngày/tháng/năm và thứ
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Voucher detail'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(urlimg + imgVoucher),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.gif_box,color: Colors.amber, size: 32,),
                          const SizedBox(width: 16,),
                          Text(
                            "Voucher: ${voucher.voucherName}",
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 26),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.description_outlined,color: Colors.amber, size: 32,),
                          const SizedBox(width: 16,),
                          Text(
                            "Description: ${voucher.description}",
                          ),
                          const SizedBox(height: 26),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.monetization_on,color: Colors.amber, size: 32,),
                          const SizedBox(width: 16,),
                          Text(
                            "Value: ${NumberFormat("#,###.#", "en_US").format(voucher.voucherValue)} VNĐ",
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 26),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.date_range,color: Colors.amber, size: 32,),
                          const SizedBox(width: 16,),
                          Text(voucher.dateCreated != null
                              ? 'Date created: ${_formatTimestamp(voucher.dateCreated!)}'
                              : '???'),
                          const SizedBox(height: 26),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.date_range_outlined,color: Colors.amber, size: 32,),
                          const SizedBox(width: 16,),
                          Text(voucher.expire != null
                              ? 'Expire: ${_formatTimestamp(voucher.expire!)}'
                              : '???'),
                          const SizedBox(height: 26),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.numbers,color: Colors.amber, size: 32,),
                          const SizedBox(width: 16,),

                          Text(
                            "Quantity: ${voucher.quantity}",
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ])),
        ));
  }
}
