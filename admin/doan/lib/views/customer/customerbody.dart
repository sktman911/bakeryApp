
import 'package:doan/firebase/model/customer_model.dart';
import 'package:doan/views/customer/customerdetail.dart';
import 'package:doan/views/customer/customeredit.dart';
import 'package:flutter/material.dart';

void _navigateToCustomerDetail(CustomerModel customer, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CustomerDetail(customer: customer),
    ),
  );
}

Widget itemCusView(CustomerModel customer, BuildContext context){
  return GestureDetector(
      onTap: () {
        _navigateToCustomerDetail(customer, context);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 50.0,
                width: 50.0,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.person, 
                  color: Colors.amber,
                  size: 40.0, 
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customer:  ${customer.CustomerName ?? "Not register" }",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    
                    Text('UserName: ${customer.CustomerUserName}' ),
                    const SizedBox(height: 4.0),
                    Text('Is active: ${customer.CustomerIsActive == true ? 'Active' : 'Block'  } '),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
              // Row(
              //       mainAxisSize: MainAxisSize.min,
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         IconButton(
              //           icon: const Icon(Icons.edit),
              //           color: Colors.yellow.shade800,
              //           onPressed: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => CustomerEdit(selectedCustomer: customer),
              //               ),
              //             );
              //           },
              //         ),
              //       ],
              //     ),
                ],
              ),
        
            
          ),
      ),
        
      );
}