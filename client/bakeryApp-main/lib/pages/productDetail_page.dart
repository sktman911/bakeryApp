import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/components/ProductDetail/ProductDetailReviews.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/data/model/product.dart';
import 'package:demo_app/data/provider/cartProvider.dart';
import 'package:demo_app/firebase/model/firebase_operator.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:demo_app/firebase/model/review_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  bool isFavorite = false;
  CartProvider cartProvider = CartProvider();
  double _mark = 0;

  Future<double> getStar() async {
    DocumentReference ref =
        FirebaseFirestore.instance.doc('/Products/${widget.product.id}');
    List<ReviewModel> reviewLst = await ReviewModel().getListDataWhere(
        ReviewModel().collection,
        () => ReviewModel(),
        FirebaseCondition(
            field: 'product', operator: FirebaseCondition.equal, value: ref));
    if (reviewLst.isEmpty) {
      return _mark;
    }
    double mark = 0;
    for (var element in reviewLst) {
      mark += element.count!;
    }

    setState(() {
      _mark = mark / reviewLst.length;
    });
    return _mark;
  }

  void increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (_quantity == 1) {
        return;
      }
      _quantity--;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            AppBar(
              backgroundColor: customWhite,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Color(0xFFD36B00),
                ),
              ),
              title: const Text(
                'Detail',
                style:
                    TextStyle(color: customOrange, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            Stack(
              children: [
                // Product Detail
                Container(
                  color: customWhite,
                  child: Container(
                    margin: const EdgeInsets.only(top: 150),
                    padding: const EdgeInsets.only(
                        top: 100, left: 15, right: 15, bottom: 25),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(40, 25),
                            topRight: Radius.elliptical(40, 25)),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.product.name!,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${NumberFormat('###,###.###').format(widget.product.price)} VNĐ',
                              style: const TextStyle(
                                  color: Color(0xFFD36B00),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 26,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _mark.toString(),
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Text(
                              "Quantity: ${widget.product.quantity!.toInt()}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      decreaseQuantity();
                                    },
                                    child: const Text(
                                      '-',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Text(
                                    _quantity.toString(),
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      increaseQuantity();
                                    },
                                    child: const Text(
                                      '+',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD36B00)),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.description!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        const Divider(
                          height: 30,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reviews',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD36B00)),
                            ),
                            Icon(
                              // Icons.keyboard_arrow_down_sharp,
                              Icons.keyboard_arrow_right,
                              size: 30,
                              color: customOrange,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        productDetailReview(widget.product)
                      ],
                    ),
                  ),
                ),

                // Product Image
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        width: 300,
                        height: 200,
                        widget.product.bannerImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(width: 4, color: Colors.grey.withOpacity(.1)))),
        child: FloatingActionButton(
            backgroundColor: const Color(0xFFD36B00),
            onPressed: () {
              if (_quantity > widget.product.quantity!) {
                toastification.show(
                  context: context,
                  title: const Text('Not enough quantity!'),
                  type: ToastificationType.error,
                  style: ToastificationStyle.fillColored,
                  autoCloseDuration: const Duration(seconds: 3),
                );
                return;
              }

              cartProvider.addToCart(widget.product, _quantity).then((_) {
                toastification.show(
                  context: context,
                  title: const Text('Add successfully!'),
                  type: ToastificationType.success,
                  style: ToastificationStyle.fillColored,
                  autoCloseDuration: const Duration(seconds: 3),
                );
                Navigator.pop(context);
              });
            },
            child: const Text(
              'Add To Cart',
              style: TextStyle(fontSize: 16, color: Colors.white),
            )),
      ),
      floatingActionButton: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: Colors.black.withOpacity(.2))
              ]),
          child: InkWell(
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: isFavorite
                ? const Icon(
                    Icons.favorite,
                    size: 30,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_outline,
                    size: 30,
                  ),
          )),
    );
  }
}
