
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/firebase/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderAdd extends StatefulWidget {
  const OrderAdd({Key? key}) : super(key: key);

  @override
  State<OrderAdd> createState() => _OrderAddState();
}

class OrderItem {
    final String productId;
    final int quantity;

    OrderItem({required this.productId, required this.quantity});
  }

class _OrderAddState extends State<OrderAdd> {
  late TextEditingController totalQuantityController;

  String? selectedVoucher;
  String? selectedCustomer;
  String? selectedPayment;
  String? selectedPurchase;
  List<OrderItem> selectedProducts = [];
   // Biến để lưu trữ hình ảnh được chọn

  @override
  void initState() {
    super.initState();
    totalQuantityController = TextEditingController();
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi không sử dụng nữa
    totalQuantityController.dispose();
    super.dispose();
  }

  

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('Products').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Column(
                  children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                    final String productId = doc.id;
                    final String productName = doc['name'];
                    return CheckboxListTile(
                      title: Text(productName),
                      value: selectedProducts.any((item) => item.productId == productId),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value!) {
                            selectedProducts.add(OrderItem(productId: productId, quantity: 1));
                          } else {
                            selectedProducts.removeWhere((item) => item.productId == productId);
                          }
                        });
                      },
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 16),
            Container(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('Customers').get(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Hiển thị tiến trình khi dữ liệu đang được tải
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final List<DropdownMenuItem<String>> items = [];
                  for (DocumentSnapshot doc in snapshot.data!.docs) {
                    final String customerId = doc.id; // Lấy ID của tài liệu
                    final String customerName = doc['CustomerName']; // Thay 'categoryName' bằng tên trường chứa tên danh mục
                    items.add(
                      DropdownMenuItem(
                        value: customerId,
                        child: Text(customerName),
                      ),
                    );
                  }
                  return DropdownButtonFormField<String>(
                    items: items,
                    value: selectedCustomer,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCustomer = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: 'Customer',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('PaymentMethods').get(),
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
                    final String categoryName = doc['MethodName']; // Thay 'categoryName' bằng tên trường chứa tên danh mục
                    items.add(
                      DropdownMenuItem(
                        value: categoryId,
                        child: Text(categoryName),
                      ),
                    );
                  }
                  return DropdownButtonFormField<String>(
                    items: items,
                    value: selectedPayment,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPayment = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: 'PaymentMethods',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('PaymentStatus').get(),
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
                    final String categoryName = doc['StatusName']; // Thay 'categoryName' bằng tên trường chứa tên danh mục
                    items.add(
                      DropdownMenuItem(
                        value: categoryId,
                        child: Text(categoryName),
                      ),
                    );
                  }
                  return DropdownButtonFormField<String>(
                    items: items,
                    value: selectedPurchase,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPurchase = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: 'PaymentStatus',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('Vouchers').get(),
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
                    final String categoryName = doc['voucherName']; // Thay 'categoryName' bằng tên trường chứa tên danh mục
                    items.add(
                      DropdownMenuItem(
                        value: categoryId,
                        child: Text(categoryName),
                      ),
                    );
                  }
                  return DropdownButtonFormField<String>(
                    items: items,
                    value: selectedVoucher,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedVoucher = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: 'Vouchers',
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
                  Map<String, int> totalQuantityMap = {};

                  // Tính tổng số lượng và tổng giá của từng sản phẩm
                  for (OrderItem item in selectedProducts) {
                    if (totalQuantityMap.containsKey(item.productId)) {
                      totalQuantityMap.update(item.productId, (value) => value + item.quantity);
                    } else {
                      totalQuantityMap[item.productId] = item.quantity;
                    }

                    
                  }

                  // Tổng số lượng của toàn bộ đơn hàng
                  int totalQuantity = totalQuantityMap.values.fold(0, (prev, quantity) => prev + quantity);


                  // Tạo một danh sách chuỗi để lưu trữ ID sản phẩm
                  List<String> selectedProductIds = selectedProducts.map((product) => product.productId).toList();


                  
                  DocumentReference<Object?>? cusRef = FirebaseFirestore.instance.collection('Customers').doc(selectedCustomer);
                  DocumentReference<Object?>? paymentRef = FirebaseFirestore.instance.collection('PaymentMethods').doc(selectedPayment);
                  DocumentReference<Object?>? purchaseRef = FirebaseFirestore.instance.collection('PaymentStatus').doc(selectedPurchase);
                  DocumentReference<Object?>? voucherRef = FirebaseFirestore.instance.collection('Vouchers').doc(selectedVoucher);
                  OrderModel orderAdd = OrderModel(
                    username: cusRef,
                    paymentMethod: paymentRef,
                    purchaseStatus: purchaseRef,
                    voucher: voucherRef,
                    orderdate: Timestamp.now(),
                    // items: selectedProductIds,
                    totalQuantity: totalQuantity,
                    totalPrice: totalQuantity,
                  );

                  await orderAdd.add(orderAdd.collection);
                  ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Product Added successfully'),
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

