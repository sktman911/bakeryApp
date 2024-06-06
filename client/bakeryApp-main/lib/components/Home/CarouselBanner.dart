import 'package:flutter/material.dart';

class BannerCarousel extends StatelessWidget {
  final String? imgPath;
  const BannerCarousel({super.key, this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          image:
              DecorationImage(fit: BoxFit.fill, image: AssetImage(imgPath!))),
    );
  }
}
