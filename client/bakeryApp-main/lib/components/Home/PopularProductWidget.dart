import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/components/Home/PopularProductItems.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/firebase_model.dart';

import 'package:demo_app/firebase/model/product_model.dart';
import 'package:demo_app/pages/productDetail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PopularProductWidget extends StatefulWidget {
  const PopularProductWidget({super.key});
  @override
  State<PopularProductWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends State<PopularProductWidget> {
  List<ProductModel> lstProduct = [];

  Future<List> loadProducts() async {
    lstProduct = await ProductModel()
        .getTopListData("Products", () => ProductModel(), getId: true);
    return lstProduct;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: lstProduct.map((e) {
                return popularProductItems(context, e);
              }).toList());
        });
  }
}
