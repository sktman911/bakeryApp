import 'package:demo_app/firebase/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../pages/productDetail_page.dart';

Widget popularProductItems(BuildContext context, ProductModel productModel) {

  String shortName(String text) {
    return text.replaceRange(12, null, '...');
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        blurRadius: 3,
        spreadRadius: 3,
        color: Colors.black.withOpacity(.1),
      )
    ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(product: productModel)));
          },
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.network(
              productModel.bannerImage!,
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: 100,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.name!.length > 12
                      ? shortName(productModel.name!)
                      : productModel.name!,
                  style: const TextStyle(
                      color: Color(0xFFA0522D),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${NumberFormat('###,###.###').format(productModel.price)} VNĐ",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 25,
                    color: Color(0xFFA0522D),
                  ),
                )
              ],
            )
          ]),
        )
      ],
    ),
  );
}
