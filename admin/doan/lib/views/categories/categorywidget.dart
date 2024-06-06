
import 'package:doan/firebase/model/categories_model.dart';
import 'package:doan/firebase/model/firebase_model.dart';
import 'package:doan/model/models/categorymodel.dart';
import 'package:doan/model/provider/categoryprovider.dart';
import 'package:doan/views/categories/Categoryadd.dart';
import 'package:doan/views/categories/categorybody.dart';
import 'package:flutter/material.dart';
class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Category> lstCate = [];
  Future<String> loadCateList() async{
    lstCate = await ReadData().loadData();
    return '';
  }

  @override
  void initState(){
    super.initState();
    loadCateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Management'),
      ),
      body: FutureBuilder(
        future: loadCateList(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<CategoryModel>>(
                    stream: FirebaseModel.getStreamDataList<CategoryModel>(
                      'Categories',
                      () => CategoryModel(), 
                      true, 
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        ); 
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return itemCateView(snapshot.data![index], context);
                          },
                        );
                      }
                    }
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CategoryAdd(), // Trang mới là ProductAdd
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white,), 
        shape: CircleBorder(),
      ),
    );
  }
  
}