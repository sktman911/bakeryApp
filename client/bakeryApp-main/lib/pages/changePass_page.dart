import 'package:demo_app/conf/const.dart';
import 'package:flutter/material.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // appbar
            AppBar(
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: customOrange,
                ),
              ),
              title: const Text(
                'Change Password',
                style: TextStyle(
                    color: customOrange,
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),

            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    TextField(
                      obscureText: true,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        label: const Text(
                          'Password',
                          style: TextStyle(color: Colors.black),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
                      obscureText: true,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        label: const Text(
                          'New Password',
                          style: TextStyle(color: Colors.black),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
                      obscureText: true,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        label: const Text(
                          'Confirm Password',
                          style: TextStyle(color: Colors.black),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 200,
                      child: FloatingActionButton(
                          backgroundColor: const Color(0xFFD36B00),
                          onPressed: () {},
                          child: const Text(
                            'Save',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
