import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:demo_app/firebase/model/review_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  final Map<String, dynamic> productModel;
  const ReviewPage({super.key, required this.productModel});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<bool> selectedStar = List.filled(5, false);
  TextEditingController reviewController = TextEditingController();
  int count = 0;

  void addReview(product, context) async {
    if (selectedStar.every((element) => element == false) ||
        reviewController.text.isEmpty) {
      return;
    }

    int count = getCount();

    final cusId = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference cusRef =
        FirebaseFirestore.instance.doc('/Customers/$cusId');

    DocumentReference productRef =
        FirebaseFirestore.instance.doc('/Products/${product['id']}');
    ReviewModel review = ReviewModel(
        description: reviewController.text,
        customer: cusRef,
        product: productRef,
        reviewDate: Timestamp.now(),
        count: count);

    await review.add(review.collection);
    Navigator.of(context).pop();
  }

  int getCount() {
    for (var element in selectedStar) {
      if (element == true) count++;
    }
    return count;
  }

  // review star
  void reviewStar(index) async {
    setState(() {
      if (selectedStar.any((element) => element != false)) {
        var lastIndex = selectedStar.lastIndexOf(true);
        if (lastIndex < index) {
          for (int i = index; i > lastIndex; i--) {
            selectedStar[i] = true;
          }
        } else if (lastIndex == index) {
          for (int i = index; i >= 0; i--) {
            selectedStar[i] = !selectedStar[i];
          }
        } else if (lastIndex > index) {
          for (int i = lastIndex; i > index; i--) {
            selectedStar[i] = !selectedStar[i];
          }
        }
      } else {
        for (int i = index; i >= 0; i--) {
          selectedStar[i] = !selectedStar[i];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: customOrange,
          ),
        ),
        title: Text(
          widget.productModel['name']!.length > 6
              ? 'Review ${widget.productModel['name'].replaceRange(6, null, '...')}'
              : 'Review ${widget.productModel['name']}',
          style: const TextStyle(
              color: customOrange, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (int i = 0; i < 5; i++)
                InkWell(
                  onTap: () {
                    reviewStar(i);
                  },
                  child: selectedStar[i] == false
                      ? const Icon(
                          Icons.star_outline,
                          size: 30,
                        )
                      : const Icon(
                          Icons.star,
                          size: 30,
                          color: Colors.yellow,
                        ),
                ),
            ]),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.25,
                child: TextFormField(
                  maxLines: 10,
                  maxLength: 150,
                  keyboardType: TextInputType.multiline,
                  controller: reviewController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(customOrange)),
                    onPressed: () {
                      addReview(widget.productModel, context);
                    },
                    child: const Text('Send',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
