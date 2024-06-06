
import 'dart:io';

import 'package:doan/firebase/model/categories_model.dart';
import 'package:doan/firebase/model/firebase_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoryEdit extends StatefulWidget {
  final CategoryModel? selectedCategory; 

  const CategoryEdit({Key? key, this.selectedCategory}) : super(key: key);

  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  late TextEditingController nameController;
  late TextEditingController imgController;

  File? image;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text:  widget.selectedCategory!.CategoryName , 
    );
    imgController = TextEditingController(text:  widget.selectedCategory!.icon ,);
    
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi không sử dụng nữa
    nameController.dispose();
    imgController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
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
        title: const Text('Edit'),
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
                  labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Đặt kích thước và độ đậm của labelText
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
                  // Chọn hình ảnh khi người dùng nhấn vào trường nhập liệu
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
                      title: const Text('Confirmation'),
                      content: Text('Are you sure you want to edit this item ${widget.selectedCategory!.CategoryName }?'),
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
                  
                  // String link = await FirebaseModel.uploadImageAndGetLink('Products', image!);
                  String link = '';
                  if (image != null) {
                    link = await CategoryModel.uploadImageAndGetLink('Categories', image!);
                  } else if (imgController.text.isNotEmpty) {
                    link = imgController.text;
                  }
                    widget.selectedCategory!.CategoryName= nameController.text;
                    widget.selectedCategory!.icon = link;
                    await widget.selectedCategory!.update(widget.selectedCategory!.id!);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Category Edit successfully'),
                          duration: Duration(seconds: 2), // Đặt thời gian hiển thị của SnackBar
                        ),
                      );
                  Navigator.pop(context);
                };
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent), // Đặt màu nền của nút ở đây
              ),
              child: const Text(
                'SAVE',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white // Màu chữ của nút
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}