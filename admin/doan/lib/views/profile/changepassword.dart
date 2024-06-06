import 'package:doan/firebase/model/profile_model.dart';
import 'package:doan/model/provider/administratorprovider.dart';
import 'package:doan/model/provider/loginprovider.dart';
import 'package:doan/views/profile/login.dart';
import 'package:flutter/material.dart';

class Changepassword extends StatefulWidget {
  final ProfileModel selectedProfile;
  const Changepassword({Key? key, required this.selectedProfile})
      : super(key: key);

  @override
  _ChangepasswordState createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  late TextEditingController oldPassController;
  late TextEditingController newPassController;
  late TextEditingController reNewPassController;

  @override
  void initState() {
    super.initState();
    oldPassController = TextEditingController();
    newPassController = TextEditingController();
    reNewPassController = TextEditingController();
  }

  @override
  void dispose() {
    oldPassController.dispose();
    newPassController.dispose();
    reNewPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: oldPassController,
                decoration: InputDecoration(
                  labelText: 'Old password',
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.text,
                maxLength: 50,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(height: 16),
            Container(
              child: TextField(
                controller: newPassController,
                decoration: InputDecoration(
                    labelText: 'New password',
                    labelStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.white),
                keyboardType: TextInputType.text,
                maxLength: 50,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: TextField(
                controller: reNewPassController,
                decoration: InputDecoration(
                    labelText: 'Confirm password',
                    labelStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.white),
                keyboardType: TextInputType.text,
                maxLength: 50,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm change password"),
                        content: const Text(
                            "Are you sure you want to change password and you must login again ?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () async {
                              String oldPassword = oldPassController.text;
                              String newPassword = newPassController.text;
                              String reNewPassword = reNewPassController.text;

                              // check
                              bool checkPass = await AdministratorProvider()
                                  .checkMatchPass(
                                      widget.selectedProfile.adminId!,
                                      oldPassword,
                                      newPassword,
                                      reNewPassword);
                              // update
                              if (checkPass == true) {
                                //update pass
                                await AdministratorProvider().updatePassword(
                                    widget.selectedProfile.adminId!,
                                    newPassword);

                                // clear and navigation
                                await LoginProvider().logout();
                                Navigator.of(context).pop();
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));

                                //alert
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    'Update password successful!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  duration: Duration(seconds: 2),
                                ));
                              } else {
                                Navigator.of(context).pop();
                                //báo lỗi
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.amber,
                                  content: Text(
                                    'Can not update password!',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      );
                    });
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
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
