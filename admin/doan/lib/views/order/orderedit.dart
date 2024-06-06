

import 'package:doan/model/models/ordermodel.dart';
import 'package:flutter/material.dart';

class OrderEdit extends StatefulWidget {
  final Order? selectedOrder; 
  const OrderEdit({Key? key, this.selectedOrder}) : super(key: key);

  @override
  State<OrderEdit> createState() => _OrderEditState();
}

class _OrderEditState extends State<OrderEdit> {
  late TextEditingController totalQuantityController;
  late TextEditingController totalPriceController;
  late TextEditingController dateController;
  late TextEditingController customerIDController;
  late TextEditingController methodIDController;
  late TextEditingController statusIDController;



  @override
  void initState() {
    super.initState();
    totalQuantityController = TextEditingController(text:  widget.selectedOrder!.TotalQuantity?.toString() , );
    totalPriceController = TextEditingController(text:  widget.selectedOrder!.TotalPrice?.toString() ,);
    dateController = TextEditingController(text:  widget.selectedOrder!.Date,);
    customerIDController = TextEditingController(text:  widget.selectedOrder!.CustomerID ?.toString(),);
    methodIDController = TextEditingController(text:  widget.selectedOrder!.MethodID?.toString() ,);
    statusIDController = TextEditingController(text:  widget.selectedOrder!.StatusID?.toString() ,);
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi không sử dụng nữa
    totalQuantityController.dispose();
    totalPriceController.dispose();
    dateController.dispose();
    customerIDController.dispose();
    methodIDController.dispose();
    statusIDController.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextField(
                enabled: false,
                controller: totalQuantityController,
                decoration: InputDecoration(
                  labelText: 'TotalQuantity',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

                ),
                keyboardType: TextInputType.none,
                
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: TextField(
                enabled: false,
                controller: totalPriceController,
                decoration: InputDecoration(
                  labelText: 'TotalPrice',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.none,
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: TextField(
                enabled: false,
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.none,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: TextField(
                enabled: false,
                controller: customerIDController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  labelText: 'CustomerID',
                ),
                keyboardType: TextInputType.none,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: TextField(
                enabled: false,
                controller: methodIDController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  labelText: 'MethodID',
                ),
                keyboardType: TextInputType.none,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: TextField(
                enabled: false,
                controller: statusIDController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  labelText: 'StatusID',
                ),
                keyboardType: TextInputType.none,
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm order"),
                              content: Text("Are you sure you want to confirm this order ?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            );
                          },
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
              ),
              child: const Text(
                'CONFIRM',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}