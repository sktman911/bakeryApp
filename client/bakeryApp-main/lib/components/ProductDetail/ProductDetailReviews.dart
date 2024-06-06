import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/firebase/model/firebase_operator.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:demo_app/firebase/model/review_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

Widget productDetailReview(ProductModel product) {
  List<ReviewModel> reviewLst = [];
  Future<List<ReviewModel>> loadReview() async {
    DocumentReference ref =
        FirebaseFirestore.instance.doc('Products/${product.id}');

    reviewLst = await ReviewModel().getListDataWhere(
        ReviewModel().collection,
        () => ReviewModel(),
        FirebaseCondition(
            field: 'product', operator: FirebaseCondition.equal, value: ref));

    return reviewLst;
  }

  return FutureBuilder(
      future: loadReview(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const CircularProgressIndicator();
        // }

        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviewLst.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd/MM/yyyy')
                        .format(reviewLst[index].reviewDate!.toDate()),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  FutureBuilder(
                    future: reviewLst[index].customer!.get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      Map<String, dynamic> customer =
                          snapshot.data!.data() as Map<String, dynamic>;

                      return Row(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'assets/images/default_user.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              customer['CustomerName'].toString().length > 10
                                  ? Text(
                                      customer['CustomerName']
                                          .toString()
                                          .replaceRange(10, null, '...'),
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  : Text(
                                      customer['CustomerName'],
                                      style: const TextStyle(fontSize: 12),
                                    ),
                            ],
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Text(reviewLst[index].description ?? ''),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            });
      });
}
