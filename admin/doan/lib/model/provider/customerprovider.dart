import 'dart:convert';

import 'package:doan/model/models/customermodel.dart';
import 'package:flutter/services.dart';

class ReadData{
  Future<List<Customer>> loadData() async{
    var data = await rootBundle.loadString("assets/files/customerlist.json");
    var dataJson = jsonDecode(data);

    return (dataJson['data'] as List).map((e) => Customer.fromJson(e)).toList();
  }
}