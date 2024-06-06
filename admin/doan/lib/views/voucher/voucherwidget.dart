import 'package:doan/firebase/model/firebase_model.dart';
import 'package:doan/firebase/model/vouchers_model.dart';
import 'package:doan/model/models/vouchermodel.dart';
import 'package:doan/model/provider/voucherprovider.dart';
import 'package:doan/views/voucher/voucherAdd.dart';
import 'package:doan/views/voucher/voucherbody.dart';
import 'package:flutter/material.dart';

class Voucherwidget extends StatefulWidget {
  const Voucherwidget({Key? key}) : super(key: key);

  @override
  State<Voucherwidget> createState() => _VoucherwidgetState();
}

class _VoucherwidgetState extends State<Voucherwidget> {
  List<Voucher> lstVoucher = [];
  Future<String> loadVoucherList() async{
    // lstVoucher = await ReadData().loadData();
    return '';
  }
  
  @override
  void initState(){
    super.initState();
    loadVoucherList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voucher Management"),
      ),
      body: FutureBuilder(
        future: loadVoucherList(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot ){
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<VoucherModel>>(
                    stream: FirebaseModel.getStreamDataList<VoucherModel>(
                      'Vouchers',
                      () => VoucherModel(), 
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
                            return itemVoucherView(snapshot.data![index], context);
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
              builder: (context) => const VoucherAdd(),
            ),
          );
        },
        child: const Icon(Icons.add,color: Colors.white,), 
        shape: CircleBorder(),
      ),
    );
  }
}
