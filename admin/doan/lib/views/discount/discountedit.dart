import 'package:flutter/material.dart';
import 'package:doan/model/models/productmodel.dart';

class Discountedit extends StatefulWidget {
  final Product? selectedProduct; 
  const Discountedit({ Key? key, this.selectedProduct }) : super(key: key);

  @override
  _DiscounteditState createState() => _DiscounteditState();
}

class _DiscounteditState extends State<Discountedit> {
  late TextEditingController discountController;


  @override
  void initState() {
    super.initState();
    discountController = TextEditingController(text:  widget.selectedProduct!.Discount?.toString() ,);
  }

@override
  void dispose() {
    // Giải phóng bộ nhớ khi không sử dụng nữa
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit discount'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: discountController,
                decoration: InputDecoration(
                  labelText: 'Discount',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 16),
           
            ElevatedButton(
              onPressed: () {
                showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm save"),
                              content: Text("Are you sure you want to save this item ?"),
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
                'SAVE',
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