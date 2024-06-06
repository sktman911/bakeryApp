
import 'dart:io';

import 'package:doan/firebase/model/categories_model.dart';
import 'package:doan/firebase/model/firebase_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoryAdd extends StatefulWidget {
  const CategoryAdd({Key? key}) : super(key: key);

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  late TextEditingController nameController;
  late TextEditingController imgController;

  File? _image;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    imgController = TextEditingController();
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi không sử dụng nữa
    nameController.dispose();
    imgController.dispose();
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
            Container(
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
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
                readOnly: true,
                controller: imgController,
                onTap: () {
                  _pickImage();
                },
                decoration: InputDecoration(
                  labelText: 'Icon',
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {

                bool confirmed = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content: Text('Are you sure you want to add this Category?'),
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
                  String link = await CategoryModel.uploadImageAndGetLink('product', _image!);

                  CategoryModel cateAdd = CategoryModel(
                      CategoryName: nameController.text,
                      icon: link,
                    );
                    await cateAdd.add(cateAdd.collection);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Category Added successfully'),
                          duration: Duration(seconds: 2), // Đặt thời gian hiển thị của SnackBar
                        ),
                      );
                  Navigator.pop(context);
                };
              },
              
              child: const Text(
                'ADD NEW',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}