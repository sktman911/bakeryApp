import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/firebase_operator.dart';
import 'package:demo_app/firebase/model/product_model.dart';
import 'package:demo_app/pages/productDetail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatelessWidget {
  final String searchText;
  const SearchPage({super.key, required this.searchText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
              color: customOrange, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Result for $searchText',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            searchBody(),
          ],
        ),
      ),
    );
  }

  Widget searchBody() {
    String shortName(String text) {
      return text.replaceRange(12, null, '...');
    }

    List<ProductModel> lstProduct = [];
    String text = '';
    Future<List<ProductModel>> loadProducts() async {
      lstProduct = await ProductModel().getListDataWhere(
        ProductModel().collection,
        () => ProductModel(),
        FirebaseCondition(
            field: 'quantity', operator: FirebaseCondition.higher, value: 0),
      );

      lstProduct.removeWhere((e) => !e.name!.contains(searchText));

      return lstProduct;
    }

    return FutureBuilder(
        future: loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
              shrinkWrap: true,
              itemCount: lstProduct.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1),
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                          clipBehavior: Clip.antiAlias,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.network(
                            lstProduct[index].bannerImage!,
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                            height: 100,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 5, right: 5),
                        child: Column(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lstProduct[index].name!.length > 12
                                    ? shortName(lstProduct[index].name!)
                                    : lstProduct[index].name!,
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
                                "${NumberFormat('###,###.###').format(lstProduct[index].price)} VNĐ",
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
              });
        });
  }
}
