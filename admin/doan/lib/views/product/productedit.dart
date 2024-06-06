import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/firebase_model.dart';
import 'package:doan/firebase/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProductEdit extends StatefulWidget {
  final ProductModel? selectedProduct; 
  const ProductEdit({Key? key, this.selectedProduct}) : super(key: key);

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController imgController;
  late TextEditingController catIDController;
  late TextEditingController desController;

  String? selectedCategory ;

  File? image; // Biến để lưu trữ hình ảnh được chọn

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text:  widget.selectedProduct!.name , );
    priceController = TextEditingController(text:  widget.selectedProduct!.price?.toString() ,);
    quantityController = TextEditingController(text:  widget.selectedProduct!.quantity?.toString() ,);
    imgController = TextEditingController(text:  widget.selectedProduct!.bannerImage ,);
    catIDController = TextEditingController(text:  widget.selectedProduct!.category?.toString() ,);
    desController = TextEditingController(text:  widget.selectedProduct!.description?.toString() ,);
    selectedCategory =  widget.selectedProduct!.category!.id;
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
            image == null
              ? FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('Products').doc(widget.selectedProduct?.id).get(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Hiển thị tiến trình khi dữ liệu đang được tải
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Text('No image selected.');
                    }
                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    var imageURL = data['bannerImage']; // Thay 'image_url' bằng tên trường chứa đường dẫn ảnh trong Firestore
                    return Image.network(imageURL);
                  },
                )
              : Image.file(image!),
            const SizedBox(height: 16),
            Container(
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Product name',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                maxLength: 50,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                controller: quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Chỉ cho phép nhập số
                ],
                maxLength: 5,
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
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                maxLength: 150,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('Categories').get(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    final List<DropdownMenuItem<String>> items = [];
                    for (DocumentSnapshot doc in snapshot.data!.docs) {
                      final String categoryId = doc.id;
                      final String categoryName = doc['name'];
                      items.add(
                        DropdownMenuItem(
                          value: categoryId,
                          child: Text(categoryName),
                        ),
                      );
                    }

                    String? initialValue = selectedCategory; // Giá trị ban đầu sẽ là giá trị đã chọn từ trước (nếu có)

                    // Kiểm tra nếu sản phẩm đã có một danh mục được chọn từ trước
                    if (initialValue == null && widget.selectedProduct != null) {
                      initialValue = widget.selectedProduct!.category?.id;
                    }

                    return DropdownButtonFormField<String>(
                      items: items,
                      value: initialValue,
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

                bool confirmed = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content: Text('Are you sure you want to edit this item ${widget.selectedProduct!.name }?'),
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

                  String link = '';
                  if (image != null) {
                    link = await ProductModel.uploadImageAndGetLink('Products', image!);
                  } else if (imgController.text.isNotEmpty) {
                    link = imgController.text;
                  }
                  int price = int.parse(priceController.text);
                  int quantity = int.parse(quantityController.text);
                  // Lấy tham chiếu tới tài liệu Category trong Firestore
                  DocumentReference<Object?>? categoryRef = FirebaseFirestore.instance.collection('Categories').doc(selectedCategory);

                  widget.selectedProduct!.bannerImage = link;
                  widget.selectedProduct!.name= nameController.text;
                  widget.selectedProduct!.price= price ;
                  widget.selectedProduct!.quantity= quantity;
                  widget.selectedProduct!.description= desController.text;
                  widget.selectedProduct!.category=categoryRef;
                    
                    await widget.selectedProduct!.update(widget.selectedProduct!.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Product Edit successfully'),
                          duration: Duration(seconds: 2), // Đặt thời gian hiển thị của SnackBar
                        ),
                      );
                  Navigator.pop(context);
                };
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
              ),
              child: const Text(
                'SAVE',
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