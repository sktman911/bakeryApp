
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/vouchers_model.dart';
import 'package:doan/views/voucher/voucherDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../conf/const.dart';

void _navigateToProductDetail(VoucherModel voucher, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => VoucherDetail(voucher: voucher),
    ),
  );
}

Widget itemVoucherView(VoucherModel voucher, BuildContext context){
  String imgVoucher = "imgVoucher.jpg";

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate(); // Chuyển đổi Timestamp thành DateTime
    String formattedDate = ' ${dateTime.day}/${dateTime.month}/${dateTime.year}'; // Định dạng ngày/tháng/năm và thứ
    return formattedDate;
  }



  return GestureDetector(
    onTap: (){
      _navigateToProductDetail(voucher, context);
    },
  child: Card(
    child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    urlimg + imgVoucher ,
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      voucher.voucherName ?? '',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(voucher.voucherValue != null ? 'Value: ${NumberFormat("#,###.#","en_US").format(voucher.voucherValue)} VNĐ' : '???', style: TextStyle(color: Colors.red),),
                    const SizedBox(height: 4.0),
                    Text(voucher.expire != null ? 'Expire: ${_formatTimestamp(voucher.expire!)}' : '???'),
                    const SizedBox(height: 4.0),
                    Text(voucher.dateCreated != null ? 'Date created: ${_formatTimestamp(voucher.dateCreated!)}' : '???'),
                    const SizedBox(height: 4.0),
                    Text(voucher.quantity != null ? 'Quantity: ${voucher.quantity}' : '???'),
                    const SizedBox(height: 4.0),
                    Text(voucher.required != null ? 'Required: ${NumberFormat("#,###.#","en_US").format(voucher.required)} VNĐ' : '???'),
                   
                  ],
                ),
              ),
              Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.edit),
                      //   color: Colors.yellow.shade800,
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => VoucherEdit(selectedVoucher: voucher),
                      //       ),
                      //     );
                      //   },
                      // ),
                      IconButton(
                        color: Colors.red,
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm Delete"),
                                content: Text("Are you sure you want to delete this item ${voucher.voucherName }?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                       voucher.delete(voucher.id!);
                                       ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Voucher Delete successfully'),
                                          duration: Duration(seconds: 2), // Đặt thời gian hiển thị của SnackBar
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              );
                            },
                          );
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