
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatelessWidget {
  final ProductModel product;
  const ProductDetail({Key? key, required this.product}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  product.bannerImage!,
                  width: 300, 
                  height: 300, 
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
                ),
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              iconColor: Colors.amber,
              leading: Icon(Icons.pie_chart_sharp), 
              title: Text("Product: ${product.name}", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
            ),
            ListTile(
              iconColor: Colors.amber,
              leading: Icon(Icons.monetization_on), 
              title: Text("Price: ${NumberFormat("#,###.#", "en_US").format(product.price)} VNĐ",),
            ),
           
            ListTile(
              iconColor: Colors.amber,
              leading: Icon(Icons.numbers_outlined), 
              title: Text("Quantity: ${product.quantity!.toInt()}"),
            ),
            ListTile(
              iconColor: Colors.amber,
              leading: Icon(Icons.description), 
              title: Text("Description: ${product.description}"),
            ),
            ListTile(
              iconColor: Colors.amber,
              leading: Icon(Icons.category), 
              title: FutureBuilder<DocumentSnapshot>(
                future: product.category!.get(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading...');
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text('Category not found');
                  }
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  var categoryName = data['name']; // Thay 'CategoryName' bằng tên trường chứa tên danh mục
                  return Text("Category: $categoryName");
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      
    );
  }
}