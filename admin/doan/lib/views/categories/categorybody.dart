import 'package:doan/firebase/model/categories_model.dart';
import 'package:doan/views/categories/Categoryedit.dart';
import 'package:flutter/material.dart';

Widget itemCateView(CategoryModel itemcate, BuildContext context){
  return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              
              alignment: Alignment.center,
              child: Image.network(
                  itemcate.icon! ,
                  
              ),
              
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemcate.CategoryName ?? '',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
            ),
            Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.yellow.shade800,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryEdit(selectedCategory: itemcate),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      color: Colors.red,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm Delete"),
                              content: Text("Are you sure you want to delete this item ${itemcate.CategoryName } ?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    itemcate.delete(itemcate.id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Category Deleted successfully'),
                                        duration: Duration(seconds: 2), // Đặt thời gian hiển thị của SnackBar
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
      
          
        ),
      );
}