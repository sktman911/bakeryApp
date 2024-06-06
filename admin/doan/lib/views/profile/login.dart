import 'package:doan/mainpage.dart';
import 'package:doan/model/provider/AuthTitle.dart';
import 'package:doan/model/provider/loginprovider.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isVisibled = false;

  bool setVisible() {
    setState(() {
      _isVisibled = !_isVisibled;
    });

    return _isVisibled;
  }

  void login() async {
    LoginProvider loginProvider = LoginProvider();

    String email = emailController.text;
    String password = passwordController.text;

    var user = await loginProvider.loginAdmin(email, password);
    if (user != null) {
      // lưu
      loginProvider.saveUser(user);
      //chuyển trang
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Mainpage()),
      );
      // báo thành công
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Login successful',
            style: TextStyle(color: Colors.green),
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromARGB(255, 169, 233, 171),
        ),
      );
    } else {
      // báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Incorrect email or password!',
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.amber,
        ),
      );
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              AppBar(
                title: const Text('AVLC',
                    style: TextStyle(
                        color: Color(0xFFD36B00),
                        backgroundColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
                centerTitle: true,
              ),
              // Welcome back text
              const AuthTitle(
                  title: 'Welcome back!', subTitle: 'Login to continue'),

              const SizedBox(
                height: 20,
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.white),
                      keyboardType:TextInputType.emailAddress,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: passwordController,
                  obscureText: !_isVisibled, // Ẩn mật khẩu
                  decoration: InputDecoration(
                      labelText: "PassWord",
                      prefixIcon: Icon(Icons.password_outlined),
                      suffixIcon: IconButton(
                        // IconButton để chuyển đổi trạng thái của biến _isPasswordVisible khi nhấn vào
                        icon: Icon(_isVisibled
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isVisibled =
                                !_isVisibled; // Đảo ngược trạng thái hiện tại của mật khẩu
                          });
                        },
                      ),
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.white),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // login button
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: Color(0xFFD36B00),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              // other login title
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
