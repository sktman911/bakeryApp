import 'package:demo_app/components/Auth/AuthAppBar.dart';
import 'package:demo_app/components/Auth/AuthTextField.dart';
import 'package:demo_app/components/Auth/AuthTitle.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/customer_model.dart';
import 'package:demo_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isVisibled = false;

  final GlobalKey<StateAuthTextField> email = GlobalKey();
  final GlobalKey<StateAuthTextField> phone = GlobalKey();
  final GlobalKey<StateAuthTextField> password = GlobalKey();
  final GlobalKey<StateAuthTextField> repass = GlobalKey();
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
        child: ListView(children: [
          // register appbar
          const AuthAppBar(),

          // register title
          const AuthTitle(title: 'Welcome!', subTitle: 'Register to continue'),

          const SizedBox(
            height: 15,
          ),

          // email text field
          AuthTextField(key: email, label: 'Email', icon: Icons.email_outlined),

          const SizedBox(
            height: 15,
          ),

          AuthTextField(
              key: phone,
              label: 'Phone Number',
              icon: Icons.phone_android_outlined),

          const SizedBox(
            height: 15,
          ),

          AuthTextField.password(
            key: password,
            label: 'Password',
            icon: Icons.password,
            setVisible: setVisible,
            visible: _isVisibled,
          ),

          const SizedBox(
            height: 15,
          ),

          AuthTextField.password(
            key: repass,
            label: 'Confirm Password',
            icon: Icons.password,
            setVisible: setVisible,
            visible: _isVisibled,
          ),

          const SizedBox(
            height: 20,
          ),

          // agreement text
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: RichText(
                  text: TextSpan(
                      text: 'By continuing, you agree to our ',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                    agreeTextSpan('Terms of Privacy '),
                    const TextSpan(
                        text: 'and ', style: TextStyle(color: Colors.black)),
                    agreeTextSpan('Privacy Policy '),
                  ])),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // register button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: ElevatedButton(
              onPressed: () async {
                String e = email.currentState!.getText();
                String p = password.currentState!.getText();
                String r = repass.currentState!.getText();
                String ph = phone.currentState!.getText();
                if (p == r) {
                  final user = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(email: e, password: p);
                  final customer = CustomerModel(
                    id: user.user!.uid,
                    customerPhone: ph,
                    customerIsActive: true,
                    customerPoint: 0,
                    customerUserName: e,
                  );
                  await customer.add(customer.collection, customer.id);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
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
                'Register',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          // navigate login page
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already a member?"),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    }));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ]),
      )),
    );
  }
}

TextSpan agreeTextSpan(String text) {
  return TextSpan(
    text: text,
    style: const TextStyle(
        color: customOrange,
        decoration: TextDecoration.underline,
        decorationColor: customOrange),
  );
}
