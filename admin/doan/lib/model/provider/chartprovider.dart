import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/model/models/chartmodel.dart';

class CharProvider{

  var db = FirebaseFirestore.instance;

  Future<int> getNumberOrdersByYear(int currentYear) async {
  try {
    int orderCount = 0;
    var querySnapshot = await db.collection('Orders').get();
    for (var docSnapshot in querySnapshot.docs) {
      DateTime orderDate = (docSnapshot.data()['orderedDate'] as Timestamp).toDate();
      if (orderDate.year == currentYear) {
        orderCount += 1;
      }
    }
    return orderCount;
  } catch (e) {
    print('Failed to get orders for current year: $e');
    return -1;
  }
}

Future<int> getNumberOrdersByMonth(int currentMonth) async {
  try {
    int orderCount = 0;
    DateTime currentYear = DateTime.now();
    var querySnapshot = await db.collection('Orders').get();
    for (var docSnapshot in querySnapshot.docs) {
      DateTime orderDate = (docSnapshot.data()['orderedDate'] as Timestamp).toDate();
      if (orderDate.month == currentMonth && orderDate.year == currentYear.year) {
        orderCount += 1;
      }
    }
    return orderCount;
  } catch (e) {
    print('Failed to get orders for current month: $e');
    return -1;
  }
}

Future<int> getNumberCustomersByYear() async {
  try {
    int orderCount = 0;
    var querySnapshot = await db.collection('Customers').get();
    for (var docSnapshot in querySnapshot.docs) {
      if (docSnapshot.data()['CustomerUserName'] != null) {
        orderCount += 1;
      }
    }
    return orderCount;
  } catch (e) {
    print('Failed to get customer for current year: $e');
    return -1;
  }
}

  Future<List<OrderByYear_chart>> getListDataYear() async {
    return [
      OrderByYear_chart('2023', await getNumberOrdersByYear(2023)),
      OrderByYear_chart('2024', await getNumberOrdersByYear(2024)),
      OrderByYear_chart('2025', await getNumberOrdersByYear(2025)),
      OrderByYear_chart('2026', await getNumberOrdersByYear(2026)),
      OrderByYear_chart('2027', await getNumberOrdersByYear(2027)),
    ];
  }

  Future<List<Order_Chart>> getListDataMonth() async {
    return [
        Order_Chart('Jan', await getNumberOrdersByMonth(1)),
        Order_Chart('Feb', await getNumberOrdersByMonth(2)),
        Order_Chart('Mar', await getNumberOrdersByMonth(3)),
        Order_Chart('Apr', await getNumberOrdersByMonth(4)),
        Order_Chart('May', await getNumberOrdersByMonth(5)),
        Order_Chart('Jun', await getNumberOrdersByMonth(6)),
        Order_Chart('July', await getNumberOrdersByMonth(7)),
        Order_Chart('August', await getNumberOrdersByMonth(8)),
        Order_Chart('September', await getNumberOrdersByMonth(9)),
        Order_Chart('October', await getNumberOrdersByMonth(10)),
        Order_Chart('November', await getNumberOrdersByMonth(11)),
        Order_Chart('December', await getNumberOrdersByMonth(12)),
    ];
  }

  Future<List<Customer_chart>> getListDataCustomer() async {
    return [
        // Customer_chart('2023', await getNumberCustomersByYear(2023)),
        Customer_chart('Total number of customer', await getNumberCustomersByYear()),
        // Customer_chart('2025', 0),
        // Customer_chart('2026', 0),
        // Customer_chart('2027', 0),
    ];
  }
  

}