

import 'package:doan/firebase/model/firebase_model.dart';
import 'package:doan/firebase/model/product_model.dart';
import 'package:doan/model/models/productmodel.dart';
import 'package:doan/model/provider/productprovider.dart';
import 'package:doan/views/product/productadd.dart';
import 'package:doan/views/product/productbody.dart';
import 'package:flutter/material.dart';
class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  
  List<Product> lstPro = [];
  Future<String> loadProList() async{
    lstPro = await ReadData().loadData();
    return '';
  }

  @override
  void initState(){
    super.initState();
    // loadProList();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Management'),
      ),
      
      body: FutureBuilder(
        
        future: loadProList(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<ProductModel>>(
                    stream: FirebaseModel.getStreamDataList<ProductModel>(
                      'Products',
                      () => ProductModel(), 
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
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return itemProView(snapshot.data![index], context);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductAdd(), // Trang mới là ProductAdd
            ),
          );
        },
        child: const Icon(Icons.add,color: Colors.white, ), 
        shape: CircleBorder(),
      ),
    );
  }
  
}