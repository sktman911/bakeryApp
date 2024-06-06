
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/firebase_model.dart';
import 'package:doan/firebase/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController imgController;
  late TextEditingController catIDController;
  late TextEditingController desController;
  String? selectedCategory; // Biến để lưu trữ danh mục được chọn

  File? _image; // Biến để lưu trữ hình ảnh được chọn

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    imgController = TextEditingController();
    catIDController = TextEditingController();
    desController = TextEditingController();
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi không sử dụng nữa
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    imgController.dispose();
    catIDController.dispose();
    desController.dispose();
    super.dispose();
  }

  // Hàm để chọn hình ảnh từ thư viện
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imgController.text = pickedFile.path; // Lưu đường dẫn của hình ảnh vào controller
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Text('No image selected.')
                : Image.file(_image!), // Hiển thị hình ảnh đã chọn
            const SizedBox(height: 16),
            Container(
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Product name',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
                maxLength: 50,
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Chỉ cho phép nhập số
                ],
                maxLength: 10,
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Chỉ cho phép nhập số
                ],
                maxLength: 10,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: TextField(
                readOnly: true,
                controller: imgController,
                onTap: () {
                  // Chọn hình ảnh khi người dùng nhấn vào trường nhập liệu
                  _pickImage();
                },
                decoration: InputDecoration(
                  labelText: 'Image',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      _pickImage();
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              child: TextField(
                controller: desController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
                maxLength: 150,
              ),
            ),
            const SizedBox(height: 16),
            

            Container(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('Categories').get(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Hiển thị tiến trình khi dữ liệu đang được tải
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final List<DropdownMenuItem<String>> items = [];
                  for (DocumentSnapshot doc in snapshot.data!.docs) {
                    final String categoryId = doc.id; // Lấy ID của tài liệu
                    final String categoryName = doc['name']; // Thay 'categoryName' bằng tên trường chứa tên danh mục
                    items.add(
                      DropdownMenuItem(
                        value: categoryId,
                        child: Text(categoryName),
                      ),
                    );
                  }
                  return DropdownButtonFormField<String>(
                    items: items,
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: 'Category',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Hiển thị hộp thoại cảnh báo và xác nhận trước khi thêm sản phẩm
                bool confirmed = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content: Text('Are you sure you want to add this product?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false); // Không thêm sản phẩm
                          },
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true); // Xác nhận thêm sản phẩm
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  },
                );

                // Nếu người dùng đã xác nhận, thực hiện thêm sản phẩm
                if (confirmed == true) {
                  String link = await ProductModel.uploadImageAndGetLink('product', _image!);
                  int price = int.parse(priceController.text);
                  int quantity = int.parse(quantityController.text);
                  
                  DocumentReference<Object?>? categoryRef = FirebaseFirestore.instance.collection('Categories').doc(selectedCategory);
                  ProductModel proAdd = ProductModel(
                    bannerImage: link,
                    name: nameController.text,
                    price: price,
                    quantity: quantity,
                    description: desController.text,
                    category: categoryRef,
                    dateCreated: Timestamp.now(),
                  );

                  await proAdd.add(proAdd.collection);
                  ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Product Added successfully'),
                          duration: Duration(seconds: 2), // Đặt thời gian hiển thị của SnackBar
                        ),
                      );
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
              ),
              child: const Text(
                'ADD NEW',
                style: TextStyle(
                  fontSize: 18,
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