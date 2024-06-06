import 'package:doan/model/models/productmodel.dart';
import 'package:doan/model/provider/productprovider.dart';
import 'package:flutter/material.dart';

class Discountadd extends StatefulWidget {
  const Discountadd({Key? key}) : super(key: key);

  @override
  _DiscountaddState createState() => _DiscountaddState();
}

class _DiscountaddState extends State<Discountadd> {
   TextEditingController nameController = TextEditingController();
   TextEditingController discountController = TextEditingController();

  late Product _selectedProduct;

  List<Product> lstProDiscount = [];
  Future<String> loadProList() async{
    lstProDiscount = await ReadData().loadData();
    if(lstProDiscount.isEmpty){
      lstProDiscount.add(Product(Product_ID: 1, ProductName: "Cake", Price: 120000,Image: "",Quantity: 300,Category_ID: 2));
      lstProDiscount.add(Product(Product_ID: 2, ProductName: "cake2", Price: 120000,Image: "",Quantity: 300,Category_ID: 3));
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    loadProList();
    discountController = TextEditingController();
    _selectedProduct = lstProDiscount.isNotEmpty ? lstProDiscount.first : Product(Product_ID: 0, ProductName: "No Product");
  }

  @override
  void dispose() {
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add discount'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),

            DropdownButtonFormField<Product>(
              hint: Text('Select Product'),
              value: _selectedProduct,
              onChanged: (Product? newValue) {
                setState(() {
                  _selectedProduct = newValue!;
                });
              },
              items: lstProDiscount.map<DropdownMenuItem<Product>>((Product product) {
                return DropdownMenuItem<Product>(
                  value: product,
                  child: Text(product.ProductName!),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            
            Container(
              child: TextField(
                controller: discountController,
                decoration: InputDecoration(
                  labelText: 'Discount',
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
              ),
              child: const Text(
                'ADD NEW',
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
