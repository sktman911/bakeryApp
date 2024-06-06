

import 'package:doan/firebase/model/customer_model.dart';
import 'package:doan/firebase/model/firebase_model.dart';
import 'package:doan/model/models/customermodel.dart';
import 'package:doan/model/provider/customerprovider.dart';
import 'package:doan/views/customer/customeradd.dart';
import 'package:doan/views/customer/customerbody.dart';
import 'package:flutter/material.dart';
class CustomerWidget extends StatefulWidget {
  const CustomerWidget({super.key});

  @override
  State<CustomerWidget> createState() => _CustomerWidgetState();
}

class _CustomerWidgetState extends State<CustomerWidget> {
  List<Customer> lstPro = [];
  Future<String> loadProList() async{
    lstPro = await ReadData().loadData();
    return '';
  }

  @override
  void initState(){
    super.initState();
    loadProList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Management'),
      ),
      
      body: FutureBuilder(
        
        future: loadProList(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<CustomerModel>>(
                    stream: FirebaseModel.getStreamDataList<CustomerModel>(
                      'Customers',
                      () => CustomerModel(), 
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
                            return itemCusView(snapshot.data![index], context);
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const CustomerAdd(), // Trang mới là ProductAdd
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.add, color: Colors.white, ), 
      //   shape: CircleBorder(),
      // ),
    );
  }
  
}