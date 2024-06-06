import 'package:doan/conf/const.dart';
import 'package:doan/model/models/productmodel.dart';
import 'package:doan/views/discount/discountedit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget itemDiscountView(Product product, BuildContext context) {
  return GestureDetector(
    onTap: null,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              alignment: Alignment.center,
              child: Image.asset(
                urlimg + product.Image!,
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.ProductName ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                      product.Price != null
                          ? 'Price: ${NumberFormat("#,###.#", "en_US").format(product.Price)} VNĐ'
                          : '???',
                      style: TextStyle(color: Colors.red)),
                  const SizedBox(height: 4.0),
                  Text(product.Discount != null
                      ? 'Discount: ${product.Discount} VNĐ'
                      : ''),
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
                              builder: (context) => Discountedit(
                                    selectedProduct: product,
                                  )));
                    }),
                IconButton(
                  color: Colors.red,
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Delete"),
                            content: Text(
                                "Are you sure you want to delete discount this item? ${product.ProductName}"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        });
                  },
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
