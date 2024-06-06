import 'package:doan/firebase/model/firebase_model.dart';
import 'package:doan/firebase/model/order_model.dart';
import 'package:doan/model/models/ordermodel.dart';
import 'package:doan/model/provider/orderprovider.dart';
import 'package:doan/views/order/orderadd.dart';
import 'package:doan/views/order/orderbody.dart';
import 'package:flutter/material.dart';
class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  List<Order> lstOrder = [];
  Future<String> loadOrderList() async{
    // lstOrder = await ReadData().loadData();
    return '';
  }

  @override
  void initState(){
    super.initState();
    loadOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order management'),
      ),
      
      body: FutureBuilder(
        
        future: loadOrderList(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<OrderModel>>(
                    stream: FirebaseModel.getStreamDataList<OrderModel>(
                      'Orders',
                      () => OrderModel(),
                      true, 
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        ); 
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return itemOrderView(snapshot.data![index], context);
                          },
                        );
                      }
                    }
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
}