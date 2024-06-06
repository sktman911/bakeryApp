import 'package:demo_app/components/Auth/AuthAppBar.dart';
import 'package:demo_app/components/Auth/AuthTextField.dart';
import 'package:demo_app/components/Auth/AuthTitle.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/auth.method.dart';
import 'package:demo_app/main_page.dart';
import 'package:demo_app/pages/home_page.dart';
import 'package:demo_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isRemember = false;
  bool _isVisibled = false;
  final GlobalKey<StateAuthTextField> username = GlobalKey();
  final GlobalKey<StateAuthTextField> password = GlobalKey();
  bool setVisible() {
    setState(() {
      _isVisibled = !_isVisibled;
    });

    return _isVisibled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              // Welcome back text
              const AuthTitle(
                  title: 'Welcome back!', subTitle: 'Login to continue'),

              const SizedBox(
                height: 20,
              ),

              // email textfield
              AuthTextField(
                key: username,
                label: 'Email',
                icon: Icons.email_outlined,
              ),

              const SizedBox(
                height: 20,
              ),

              // password textfield
              AuthTextField.password(
                key: password,
                label: 'Password',
                icon: Icons.password_outlined,
                setVisible: setVisible,
                visible: _isVisibled,
              ),

              // remember me checkbox
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isRemember,
                      activeColor: customOrange,
                      onChanged: (value) {
                        setState(() {
                          _isRemember = value!;
                        });
                      },
                    ),
                    Text(
                      'Remember me',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 15),
                    )
                  ],
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
                  onPressed: () async {
                    final result = await AuthMethod.loginWithEmail(
                        username.currentState!.getText(),
                        password.currentState!.getText());
                    if (result == null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: customOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              // forgot password
              Center(
                child: InkWell(
                    onTap: () {},
                    child: Text(
                      'Forgot Password?',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    )),
              ),

              const SizedBox(
                height: 30,
              ),

              // other login title
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      height: 10,
                      color: Colors.black,
                      thickness: 1,
                      indent: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Or login with',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15 // Màu chữ của văn bản giữa
                          ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      height: 10,
                      color: Colors.black,
                      thickness: 1,
                      endIndent: 50,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              // Others login buttons
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: customWhite),
                child: InkWell(
                  onTap: () async {
                    final user =
                        await AuthMethod.loginWithSocial(AuthMethod.GOOGLE);
                    if (user.user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/google.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Continue with Google',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Navigate to signup page
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const RegisterPage();
                        }));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
