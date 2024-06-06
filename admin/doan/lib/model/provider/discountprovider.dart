import 'dart:convert';

import 'package:doan/model/models/productmodel.dart';
import 'package:flutter/services.dart';

class ReadData{
  Future<List<Product>> loadData() async{
    var data = await rootBundle.loadString("assets/files/productlist.json");
    var dataJson = jsonDecode(data);

    return (dataJson['data'] as List).map((e) => Product.fromJson(e)).where((element) => element.Discount! > 0).toList();
  }

  Future<Iterable<Product>> loadDataByCate(int cateId) async{
    var data = await rootBundle.loadString("assets/files/productlist.json");
    var dataJson = jsonDecode(data);

    return (dataJson['data'] as List).map((e) => Product.fromJson(e)).where((e) => e.Category_ID == cateId).toList();
  }
}