import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/category_model.dart';
import 'package:demo_app/pages/category_page.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // create scale for each screen
    double scale = 1;
    List<CategoryModel> lstCate = [];

    Future<List<CategoryModel>> getCategories() async {
      return lstCate = await CategoryModel()
          .getListData(CategoryModel().collection, () => CategoryModel());
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder(
            future: getCategories(),
            builder: (context, snapshot) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50 * scale,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: lstCate.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryPage(cate: lstCate[index])));
                        },
                        child: Container(
                          margin: index == 0
                              ? const EdgeInsets.only(
                                  right: 10, top: 10, bottom: 10)
                              : const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: const Color(0xFFA0522D)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                lstCate[index].icon!,
                                width: 20,
                                height: 20,
                                color: const Color(0xFFA0522D),
                                filterQuality: FilterQuality.medium,
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2)),
                              Text(
                                lstCate[index].name!,
                                style: const TextStyle(
                                    color: Color(0xFFA0522D), fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              );
            })
        );
  }
}
