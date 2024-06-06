import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/category_model.dart';
import 'package:demo_app/pages/category_page.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  final CategoryModel? cate;
  final Function setCategory;
  const CategoryList({super.key, this.cate, required this.setCategory});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late CategoryModel _categoryModel;
  List<CategoryModel> lstCate = [];

  Future<List<CategoryModel>> getCategories() async {
    lstCate = await CategoryModel().getListData(
        CategoryModel().collection, () => CategoryModel(),
        getId: true);

    return lstCate;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryModel = widget.cate!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder(
            future: getCategories(),
            builder: (context, snapshot) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: lstCate.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _categoryModel = lstCate[index];
                          widget.setCategory(_categoryModel);
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          margin: index == 0
                              ? const EdgeInsets.only(
                                  right: 10, top: 10, bottom: 10)
                              : const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: _categoryModel.id == lstCate[index].id
                                ? customWhite
                                : Colors.white,
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
            }));
  }
}
