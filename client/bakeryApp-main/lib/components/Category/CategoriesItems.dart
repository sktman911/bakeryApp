import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/firebase/model/category_model.dart';
import 'package:demo_app/firebase/model/firebase_operator.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:demo_app/pages/productDetail_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoriesItems extends StatelessWidget {
  final CategoryModel cate;
  const CategoriesItems({super.key, required this.cate});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> lstProduct = [];

    Future<List<ProductModel>> loadProducts() async {
      if (cate.id != "popular") {
       
        DocumentReference ref =
            FirebaseFirestore.instance.doc("/Categories/${cate.id}");
        lstProduct = await ProductModel().getListDataWhere(
            ProductModel().collection,
            () => ProductModel(),
            FirebaseCondition(
                field: 'category',
                operator: FirebaseCondition.equal,
                value: ref));
      } else {
        lstProduct = await ProductModel()
            .getListData(ProductModel().collection, () => ProductModel());
      }

      return lstProduct;
    }

    return FutureBuilder(
        future: loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return GridView.builder(
            itemCount: lstProduct.length,
            padding: const EdgeInsets.only(bottom: 60),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 3,
                        color: Colors.black.withOpacity(.1),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                    product: lstProduct[index])));
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.network(
                          lstProduct[index].bannerImage!,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                          height: 90,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: Column(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lstProduct[index].name!,
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
                              "${NumberFormat('###,###.###').format(lstProduct[index].price!)} VNĐ",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.shopping_bag_outlined,
                                size: 26,
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
            },
          );
        });
  }
}
