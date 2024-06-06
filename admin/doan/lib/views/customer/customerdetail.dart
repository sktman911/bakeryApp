
import 'package:doan/firebase/model/customer_model.dart';
import 'package:flutter/material.dart';

class CustomerDetail extends StatelessWidget {
  final CustomerModel customer;
  const CustomerDetail({Key? key, required this.customer}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer detail'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding:EdgeInsets.all(36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('assets/images/PersonCustomerImg.jpg')
                            )
                        )
                      ],
                    ),
                   const SizedBox(
                  height: 36,
                ),

                    Row(
                      children: [
                      const Icon(Icons.people,color: Colors.amber,),
                      const SizedBox(
                      width: 16,
                    ),
                    Text('Name: ${customer.CustomerName}'),
                  ],
                    ),
                    const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(Icons.phone,color: Colors.amber,),
                    const SizedBox(
                      width: 16,
                    ),
                    Text("Phone: ${customer.CustomerPhone??"Not register"}")
                  ],
                )
                  ],
                ),
            
                SizedBox(height: 26),
            
                Column(
                  children: [
                    Row(
                      children: [
                      Icon(Icons.location_city,color: Colors.amber,),
                      SizedBox(
                      width: 16,
                    ),
                    Text('Address: ${customer.CustomerAddress?? "Not register"}'),
                  ],
                    ),
                    SizedBox(
                  height: 26,
                ),
                Row(
                  children: [
                    Icon(Icons.email,color: Colors.amber,),
                    SizedBox(
                      width: 16,
                    ),
                    Text("Email: ${customer.CustomerUserName}")
                  ],
                )
                  ],
                ),
                
                SizedBox(height: 26),
            
                Column(
                  children: [
                    Row(
                      children: [
                      Icon(Icons.lightbulb,color: Colors.amber,),
                      SizedBox(
                      width: 16,
                    ),
                    Text('Status: ${customer.CustomerIsActive == true ? "Active" : "Block"}'),
                  ],
                    ),
                    SizedBox(
                  height: 16,
                ),
                  ],
                ),
                const SizedBox(height: 26,),
              ],
            ),
          ),
        ), 
      ),
    );
  }
}