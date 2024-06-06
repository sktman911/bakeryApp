import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_app/components/Home/CarouselBanner.dart';
import 'package:demo_app/components/Home/CategoriesWidget.dart';
import 'package:demo_app/components/Home/HomeAppBar.dart';
import 'package:demo_app/components/Home/NewProductWidget.dart';
import 'package:demo_app/components/Home/PopularProductWidget.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/category_model.dart';
import 'package:demo_app/pages/category_page.dart';
import 'package:demo_app/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> imgPaths = [
  "assets/images/banner.jpg",
  "assets/images/banner2.jpg",
  "assets/images/banner3.jpg"
];

List<Widget>? _pages;

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;
  CategoryModel categoryModel = CategoryModel(id: "popular", name: "All");
  TextEditingController searchController = TextEditingController();

  final _carouselController = CarouselController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = List.generate(
        imgPaths.length,
        (index) => BannerCarousel(
              imgPath: imgPaths[index],
            ));
  }

  void _changeSlide(int index) {
    _carouselController.animateToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const HomeAppBar(),
            Container(
              color: customWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: const Text(
                      "Fresh Baked \nEveryday",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: customOrange),
                    ),
                  ),

                  // search bar and banner
                  Stack(
                    children: [
                      // banner
                      Column(
                        children: [
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 45),
                            padding: const EdgeInsets.only(top: 40, bottom: 20),
                            child: CarouselSlider.builder(
                              carouselController: _carouselController,
                              options: CarouselOptions(
                                  autoPlayInterval: const Duration(seconds: 3),
                                  initialPage: 0,
                                  height: 200,
                                  autoPlay: true,
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      activeIndex = index;
                                    });
                                  }),
                              itemCount: imgPaths.length,
                              itemBuilder: (context, index, realIndex) {
                                return _pages![index];
                              },
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedSmoothIndicator(
                                  activeIndex: activeIndex,
                                  count: imgPaths.length,
                                  onDotClicked: _changeSlide,
                                  effect: const SlideEffect(
                                      dotWidth: 12,
                                      dotHeight: 12,
                                      activeDotColor: customOrange),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                                              searchText:
                                                  searchController.text)));
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
                ],
              ),
            ),

            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: customBrown),
                    ),
                  ]),
            ),

            //cate title
            Container(color: Colors.white, child: const CategoriesWidget()),

            // new products
            Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "New Products",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: customBrown),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => CategoryPage(
                                          cate: categoryModel,
                                        ))));
                          },
                          child: const Text(
                            "View all",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        )
                      ]),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: NewProductWidget(),
            ),

            //Products title
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular Products",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: customBrown),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => CategoryPage(
                                      cate: categoryModel,
                                    ))));
                      },
                      child: const Text(
                        "View all",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ))
                ],
              ),
            ),

            Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 14, top: 0),
                child: const PopularProductWidget()),
          ],
        ),
      ),
    );
  }
}
