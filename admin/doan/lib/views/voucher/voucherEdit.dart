import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/vouchers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class VoucherEdit extends StatefulWidget {
  final VoucherModel? selectedVoucher; 
  const VoucherEdit({ Key? key,this.selectedVoucher }) : super(key: key);

  @override
  _VoucherEditState createState() => _VoucherEditState();
}

class _VoucherEditState extends State<VoucherEdit> {
  late TextEditingController voucherNameController;
  late TextEditingController voucherExpireController;
  late TextEditingController voucherDescController;
  late TextEditingController voucherValueController;
  late TextEditingController voucherQuantityController;

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate(); // Chuyển đổi Timestamp thành DateTime
    String formattedDate = '${dateTime.year}-${_addLeadingZero(dateTime.month)}-${_addLeadingZero(dateTime.day)}'; // Định dạng ngày/tháng/năm và thứ
    return formattedDate;
  }
  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0'); // Thêm số 0 ở trước nếu cần
  }
  
  @override
  void initState() {
    super.initState();
    voucherNameController = TextEditingController(text:  widget.selectedVoucher!.voucherName , );
    voucherExpireController = TextEditingController(text:  _formatTimestamp(widget.selectedVoucher!.expire! ,));
    voucherDescController = TextEditingController(text:  widget.selectedVoucher!.description?.toString() ,);
    voucherValueController = TextEditingController(text:  widget.selectedVoucher!.voucherValue?.toString() ,);
    voucherQuantityController = TextEditingController(text:  widget.selectedVoucher!.quantity?.toString() ,);
  }

  @override
  void dispose() {
    voucherNameController.dispose();
    voucherExpireController.dispose();
    voucherDescController.dispose();
    voucherValueController.dispose();
    voucherQuantityController.dispose();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Voucher'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: voucherNameController,
                decoration: InputDecoration(
                  labelText: 'Voucher Name',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
                maxLength: 50,
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: voucherDescController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
                maxLength: 150,
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: voucherExpireController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Expire',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    voucherExpireController.text = formattedDate;
                  }
                },
              ),
            ),
            
            SizedBox(height: 32),
            Container(
              child: TextField(
                controller: voucherValueController,
                decoration: InputDecoration(
                  labelText: 'Value',
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                controller: voucherQuantityController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  labelText: 'Quantity',
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
            ElevatedButton(
              onPressed: () async {

                bool confirmed = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content: Text('Are you sure you want to edit this item ${widget.selectedVoucher!.voucherName }?'),
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

                  int vcvalue= int.parse(voucherValueController.text);
                  int quantity = int.parse(voucherQuantityController.text);
                  DateTime expireDateTime = DateTime.parse(voucherExpireController.text);
                  // Lấy tham chiếu tới tài liệu Category trong Firestore
                      widget.selectedVoucher!.description = voucherDescController.text;
                      widget.selectedVoucher!.voucherName= voucherNameController.text;
                      widget.selectedVoucher!.quantity= quantity;
                      widget.selectedVoucher!.voucherValue= vcvalue;
                      widget.selectedVoucher!.expire= Timestamp.fromDate(expireDateTime);
                    
                    await widget.selectedVoucher!.update(widget.selectedVoucher!.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Voucher Edit successfully'),
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