import 'package:doan/model/models/productmodel.dart';
import 'package:doan/model/provider/discountprovider.dart';
import 'package:doan/views/discount/discountadd.dart';
import 'package:doan/views/discount/discountbody.dart';
import 'package:flutter/material.dart';

class Discountwidget extends StatefulWidget {
  const Discountwidget({ Key? key }) : super(key: key);

  @override
  _DiscountwidgetState createState() => _DiscountwidgetState();
}

class _DiscountwidgetState extends State<Discountwidget> {
  List<Product> lstProDiscount = [];
  Future<String> loadProDiscountList() async{
    lstProDiscount = await ReadData().loadData();
    return '';
  }
  
  @override
  void initState(){
    super.initState();
    loadProDiscountList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discount management'),
      ),
      body: FutureBuilder(
        future: loadProDiscountList(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: lstProDiscount.length,
                    itemBuilder: (context,index) {
                      return itemDiscountView(lstProDiscount[index],context);
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Discountadd(),
            ),
          );
        },
        child: const Icon(Icons.add,color: Colors.white,),
        shape: CircleBorder(),
      ),
    );
  }
}