import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/vouchers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class VoucherAdd extends StatefulWidget {
  const VoucherAdd({ Key? key }) : super(key: key);

  @override
  _VoucherAddState createState() => _VoucherAddState();
}

class _VoucherAddState extends State<VoucherAdd> {
  late TextEditingController nameController;
  late TextEditingController desController;
  late TextEditingController quantityController;
  late TextEditingController valueController;
  late TextEditingController expireController;
  late TextEditingController createController;
  late TextEditingController requiredController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    desController = TextEditingController();
    quantityController = TextEditingController();
    valueController = TextEditingController();
    createController = TextEditingController();
    expireController = TextEditingController();
    requiredController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    desController.dispose();
    quantityController.dispose();
    valueController.dispose();
    expireController.dispose();
    createController.dispose();
    requiredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Voucher name',
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
              child: TextField(
                controller: expireController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Expire',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    expireController.text = formattedDate;
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
            Container(
              child: TextField(
                controller: valueController,
                decoration: InputDecoration(
                  labelText: 'Value',
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
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                   labelText: 'Quantity',
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
                controller: requiredController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                   labelText: 'Required',
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
            ElevatedButton(
              onPressed: () async {

                bool confirmed = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content: Text('Are you sure you want to add this Voucher?'),
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

                  int vcvalue= int.parse(valueController.text);
                  int quantity = int.parse(quantityController.text);
                  DateTime expireDateTime = DateTime.parse(expireController.text);
                  int requiredVoucher = int.parse(requiredController.text);
                  // Lấy tham chiếu tới tài liệu Category trong Firestore
                  VoucherModel vouAdd = VoucherModel(
                      description : desController.text,
                      voucherName: nameController.text,
                      quantity: quantity,
                      voucherValue: vcvalue,
                      dateCreated: Timestamp.now(),
                      expire: Timestamp.fromDate(expireDateTime),
                      required: requiredVoucher,
                    );
                    await vouAdd.add(vouAdd.collection);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Voucher Added successfully'),
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