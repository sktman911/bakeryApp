
import 'package:doan/firebase/model/product_model.dart';
import 'package:doan/views/product/productdetail.dart';
import 'package:doan/views/product/productedit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void _navigateToProductDetail(ProductModel product, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetail(product: product), // Trang chi tiết là ProductDetail
    ),
  );
}

Widget itemProView(ProductModel itemcate, BuildContext context){
  return GestureDetector(
      onTap: () {
        _navigateToProductDetail(itemcate, context);
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
                child: Image.network(
                  itemcate.bannerImage!,
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemcate.name ?? '',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(itemcate.price != null ? 'Price: ${NumberFormat("#,###.#", "en_US").format(itemcate.price)} VNĐ' : '' , style: const TextStyle(color: Colors.red),),
                    const SizedBox(height: 4.0),
                    Text(itemcate.quantity != null ? 'Quantity: ${itemcate.quantity}' : '???'),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
              Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.yellow.shade800,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductEdit(selectedProduct: itemcate),
                            ),
                          );
                        },
                      ),
                      // IconButton(
                      //   color: Colors.red,
                      //   icon: const Icon(Icons.delete),
                      //   onPressed: () {
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return AlertDialog(
                      //           title: const Text("Confirm Delete"),
                      //           content: Text("Are you sure you want to delete this item ${itemcate.name } ?"),
                      //           actions: [
                      //             TextButton(
                      //               onPressed: () {
                      //                 Navigator.of(context).pop();
                      //               },
                      //               child: const Text("No"),
                      //             ),
                      //             TextButton(
                      //               onPressed: () {
                      //                 itemcate.delete(itemcate.id!);
                      //                 ScaffoldMessenger.of(context).showSnackBar(
                      //                   SnackBar(
                      //                     content: Text('Product Delete successfully'),
                      //                     duration: Duration(seconds: 2), // Đặt thời gian hiển thị của SnackBar
                      //                   ),
                      //                 );    
                      //                 Navigator.of(context).pop();
                      //               },
                      //               child: const Text("Yes"),
                      //             ),
                      //           ],
                      //         );
                      //       },
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ],
              ),
        
            
          ),
      ),
      );
}