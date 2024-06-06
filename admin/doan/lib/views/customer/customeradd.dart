
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerAdd extends StatefulWidget {
  const CustomerAdd({Key? key}) : super(key: key);

  @override
  State<CustomerAdd> createState() => _CustomerAddState();
}

class _CustomerAddState extends State<CustomerAdd> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController usernameController;
  late TextEditingController passController;
  late TextEditingController pointController;
  late TextEditingController isActiveController;
  late TextEditingController roleController;

  String? selectedRole;
  bool? isActive = false;

   // Biến để lưu trữ hình ảnh được chọn

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    usernameController = TextEditingController();
    passController = TextEditingController();
    pointController = TextEditingController();
    isActiveController = TextEditingController();
    roleController = TextEditingController();
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi không sử dụng nữa
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    usernameController.dispose();
    passController.dispose();
    pointController.dispose();
    isActiveController.dispose();
    roleController.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customer'),
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
                  labelText: 'name',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                maxLength: 50,
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'PhoneNumber',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Chỉ cho phép nhập số
                ],
                maxLength: 10,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                maxLength: 150,
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                maxLength: 50,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: TextField(
                controller: passController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  labelText: 'Passwork',
                ),
                // inputFormatters: [
                  
                //   FilteringTextInputFormatter.allow(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|<>?])')), // Chỉ cho phép nhập chữ cái, số và các ký tự đặc biệt
                // ],
                maxLength: 50,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: TextField(
                controller: pointController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  labelText: 'Point',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Chỉ cho phép nhập số
                ],
                maxLength: 10,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: Row(
                children: [
                  Checkbox(
                    value: isActive,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isActive = newValue!;
                      });
                    },
                  ),
                  Text(
                    'Is Active',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('Roles').get(),
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
                    final String categoryName = doc['RoleName']; // Thay 'categoryName' bằng tên trường chứa tên danh mục
                    items.add(
                      DropdownMenuItem(
                        value: categoryId,
                        child: Text(categoryName),
                      ),
                    );
                  }
                  return DropdownButtonFormField<String>(
                    items: items,
                    value: selectedRole,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRole = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: 'Role',
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
                      content: Text('Are you sure you want to add this customer?'),
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
                  int point = int.parse(pointController.text);
                  // Lấy tham chiếu tới tài liệu Category trong Firestore
                  DocumentReference<Object?>? role = FirebaseFirestore.instance.collection('Roles').doc(selectedRole);
                  CustomerModel cusAdd = CustomerModel(
                      CustomerName : nameController.text,
                      CustomerPhone: phoneController.text,
                      CustomerAddress: addressController.text ,
                      CustomerUserName: usernameController.text,
                      CustomerPasswork: passController.text,
                      CustomerPoint: point,
                      CustomerIsActive: isActive,
                      RoleName: role,
                    );

                    // Hiển thị thông báo thêm thành công
                    try {
                      await cusAdd.add(cusAdd.collection);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Customer Added successfully'),
                          duration: Duration(seconds: 2), // Đặt thời gian hiển thị của SnackBar
                        ),
                      );
                      Navigator.pop(context); 
                    } catch (error) {
                        // Nếu có lỗi, hiển thị thông báo lỗi
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $error'),
                            duration: Duration(seconds: 2), // Đặt thời gian hiển thị của SnackBar
                          ),
                        );
                      }
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