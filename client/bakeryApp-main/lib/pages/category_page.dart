import 'package:demo_app/components/Category/CategoriesItems.dart';
import 'package:demo_app/components/Category/CategoriesList.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/category_model.dart';
import 'package:demo_app/pages/search_page.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final CategoryModel cate;
  const CategoryPage({super.key, required this.cate});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<CategoryModel> lstCate = [];
  late CategoryModel _categoryModel;
  TextEditingController searchController = TextEditingController();

  // Future<List<CategoryModel>> getCategories() async {
  //   lstCate = await CategoryModel().getListData(
  //       CategoryModel().collection, () => CategoryModel(),
  //       getId: true);

  //   return lstCate;
  // }

  void setCategory(CategoryModel newCategoryModel) {
    setState(() {
      _categoryModel = newCategoryModel;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryModel = widget.cate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: customWhite,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: customOrange,
                ),
              ),
            ),
            Container(
              color: customWhite,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _categoryModel.name!,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: customOrange),
                  ),
                ],
              ),
            ),
            // search bar
            Stack(
              children: [
                Container(
                  color: customWhite,
                  margin: const EdgeInsets.only(top: 0),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),

                // search input
                Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              spreadRadius: 3,
                              blurRadius: 3)
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (searchController.text.isEmpty) return;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage(
                                        searchText: searchController.text)));
                          },
                          child: const Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    )),
              ],
            ),

            // Categories title
            Column(
              children: [
                // categories list
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: customBrown),
                        ),
                      ]),
                ),
                CategoryList(
                  cate: _categoryModel,
                  setCategory: setCategory,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: CategoriesItems(
                    cate: _categoryModel,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
