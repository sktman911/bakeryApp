import 'package:demo_app/components/Home/PopularProductItems.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:demo_app/pages/productDetail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewProductWidget extends StatefulWidget {
  const NewProductWidget({super.key});

  @override
  State<NewProductWidget> createState() => _NewProductWidgetState();
}

class _NewProductWidgetState extends State<NewProductWidget> {
  List<ProductModel> lstProduct = [];

  Future<List> loadProducts() async {
    lstProduct = await ProductModel()
        .getNewListData("Products", () => ProductModel(), getId: true);
    return lstProduct;
  }

  String shortName(String text) {
    return text.replaceRange(12, null, '...');
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

          return ListView.builder(
            itemCount: lstProduct.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: lstProduct[index])));
                },
                child: Card(
                  color: customWhite,
                  child: Row(children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.black.withOpacity(.1))
                              ]),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            child: Image.network(
                              lstProduct[index].bannerImage!,
                              fit: BoxFit.cover,
                              width: 160,
                              height: 120,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // detail
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text(
                                  lstProduct[index].name!.length > 12
                                      ? shortName(lstProduct[index].name!)
                                      : lstProduct[index].name!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: customBrown),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${NumberFormat('###,###.###').format(lstProduct[index].price)} VNĐ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () {},
                                  child: const Icon(Icons.shopping_bag_outlined,
                                      size: 30, color: customBrown),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
                ),
              );
            },
          );
        });
  }
}
