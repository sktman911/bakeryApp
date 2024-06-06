
import 'package:doan/firebase/model/customer_model.dart';
import 'package:flutter/material.dart';

class CustomerEdit extends StatefulWidget {
  final CustomerModel? selectedCustomer; 
  const CustomerEdit({Key? key, this.selectedCustomer}) : super(key: key);

  @override
  State<CustomerEdit> createState() => _CustomerEditState();
}

class _CustomerEditState extends State<CustomerEdit> {
  late bool isActiveController;



  @override
  void initState() {
    super.initState();
    isActiveController = widget.selectedCustomer!.CustomerIsActive ?? false; // Sử dụng giá trị mặc định là false nếu không có dữ liệu
  }

  

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer edit'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Is Active: ',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isActiveController ? Icons.toggle_on : Icons.toggle_off,
                    color: isActiveController ? Colors.green : Colors.grey,
                    
                  ),
                  iconSize: 40,
                  onPressed: () {
                    setState(() {
                      isActiveController = !isActiveController;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm block"),
                              content: Text("Are you sure you want to edit this user ${widget.selectedCustomer!.CustomerName} ?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    widget.selectedCustomer!.CustomerIsActive = isActiveController;
                                    await widget.selectedCustomer!.update(widget.selectedCustomer!.id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Customer Edit successfully'),
                                        duration: Duration(seconds: 2), // Đặt thời gian hiển thị của SnackBar
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            );
                          },
                        );
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