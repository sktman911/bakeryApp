import 'package:demo_app/components/Favorite/FavoriteItems.dart';
import 'package:demo_app/conf/const.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            AppBar(
              title: const Text(
                'My Favorite',
                style: TextStyle(
                    color: customOrange,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
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
            const SizedBox(
              height: 12,
            ),
            const FavoriteItems(),
          ],
        ),
      ),
    );
  }
}
