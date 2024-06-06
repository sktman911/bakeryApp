import 'package:doan/model/models/chartmodel.dart';
import 'package:doan/model/provider/chartprovider.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

CharProvider charProvider = CharProvider();

Future<Widget> BuildChart() async {

 List<charts.Series<Order_Chart, String>> series = [
      charts.Series(
        id: 'OrderQuantity',
        data: await charProvider.getListDataMonth(),
        domainFn: (Order_Chart order, _) => order.month,
        measureFn: (Order_Chart order, _) => order.quantity,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (Order_Chart order, _) => '${order.month}: ${order.quantity}',
      ),
    ];

    return charts.BarChart(
      series,
      animate: true,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
    );
  }

  Future <Widget> BuildChart2() async {

     List<charts.Series<OrderByYear_chart, String>> series = [
      charts.Series(
        id: 'OrderQuantity',
        data: await charProvider.getListDataYear(),
        domainFn: (OrderByYear_chart OrderByYear_chart, _) => OrderByYear_chart.yearOrder,
        measureFn: (OrderByYear_chart OrderByYear_chart, _) => OrderByYear_chart.quantity,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        labelAccessorFn: (OrderByYear_chart OrderByYear_chart, _) => '${OrderByYear_chart.yearOrder}: ${OrderByYear_chart.quantity}',
      ),
    ];

    return charts.BarChart(
      series,
      animate: true,
      behaviors: [
        charts.DatumLegend(
          position: charts.BehaviorPosition.end,
          horizontalFirst: false,
          cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
          showMeasures: true,
        ),
      ],
    );
  }




 Future<Widget> BuildChart3() async{

  final List<charts.Series<Customer_chart, String>> seriesList = [
    charts.Series(
      id: 'Customer',
      data: await charProvider.getListDataCustomer(),
      domainFn: (Customer_chart Customer, _) => Customer.year,
      measureFn: (Customer_chart Customer, _) => Customer.customer,
      colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
    ),
  ];

  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: charts.BarChart(
              seriesList,
              animate: true,
              barGroupingType: charts.BarGroupingType.grouped,
              behaviors: [
                charts.SeriesLegend(),
              ],
            ),
          ),
        ],
      ),
    );

 }