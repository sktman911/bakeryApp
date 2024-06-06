import 'dart:convert';

import 'package:doan/customeThemes.dart';
import 'package:doan/defaultwidget.dart';
import 'package:doan/firebase/model/profile_model.dart';
import 'package:doan/model/provider/loginprovider.dart';
import 'package:doan/model/provider/themeNotifier.dart';
import 'package:doan/views/categories/categorywidget.dart';
import 'package:doan/views/customer/customerwidget.dart';
import 'package:doan/views/dashboard/dashboardwidget.dart';
import 'package:doan/views/order/orderwidget.dart';
import 'package:doan/views/product/productwidget.dart';
import 'package:doan/views/profile/login.dart';
import 'package:doan/views/profile/profilewidget.dart';
import 'package:doan/views/voucher/voucherwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;
  ProfileModel user = ProfileModel();
getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('user') != null && pref.getString('user') != '')
    {
      String strUser = pref.getString('user')!;
      user =  ProfileModel.fromJsonReturn(jsonDecode(strUser));
    }
    if(pref.getString('user') == null || pref.getString('user') == '')
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage() ));
    }
    
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _loadWidget(int index) {
    var nameWidgets = "Home";
    switch (index) {
      case 0:
        return const Dashboardwidget();
      case 1:
        {
          return const CustomerWidget();
        }
      case 2:
        {
          return const CategoryWidget();
        }
      case 3:
        {
          return const ProductWidget();
        }
      case 4:
        {
          return const OrderWidget();
        }
      // case 5:
        
      //   return const Discountwidget();
      case 6:
        return const Voucherwidget();
      case 7:
        {
          // return const Register();
          return  Profilewidget( profileModel: user,);
        }
      default:
        nameWidgets = "None";
        break;
    }
    return DefaulWidget(title: nameWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Administrator',
          style: TextStyle(fontSize: 20), // Cỡ chữ của tiêu đề
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 205, 66),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:BorderRadius.circular(100),
                      child: Container(color: Colors.white,child: Image.asset('assets/images/logo.png',width: 110,)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "AVLC",
                    style: TextStyle(
                      fontSize:
                          20, // Đặt kích thước phù hợp với nội dung của bạn
                      fontWeight: FontWeight
                          .bold, // Đặt kiểu chữ phù hợp với nội dung của bạn
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text('Customer'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 1;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 2;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.cookie_outlined),
              title: const Text('Product'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 3;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Order'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 4;
                setState(() {});
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.percent_outlined),
            //   title: const Text('Discount'),
            //   onTap: () {
            //     Navigator.pop(context);
            //     _selectedIndex = 5;
            //     setState(() {});
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.discount_outlined),
              title: const Text('Voucher'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 6;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 7;
                setState(() {});
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                // clear cache
                  LoginProvider().logout();
                // Chuyển đến trang đăng nhập
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            ListTile(
              trailing: Switch(
                value: Provider.of<ThemeNotifier>(context).currentTheme ==
                    CustomThemes.darkTheme,
                onChanged: (value) {
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .toggleTheme();
                },
              ),
              title: Text(
                Provider.of<ThemeNotifier>(context).currentTheme ==
                        CustomThemes.darkTheme
                    ? 'Dark Mode'
                    : 'Light Mode',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      body: _loadWidget(_selectedIndex),
    );
  }
}
