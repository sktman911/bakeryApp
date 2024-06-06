import 'package:doan/firebase/model/profile_model.dart';
import 'package:doan/model/provider/administratorprovider.dart';
import 'package:doan/model/provider/loginprovider.dart';
import 'package:doan/views/profile/login.dart';
import 'package:flutter/material.dart';

class Editprofile extends StatefulWidget {
  final ProfileModel selectedProfile; 
  const Editprofile({Key? key, required this.selectedProfile}) : super(key: key);


  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  late TextEditingController nameUser;
  late TextEditingController phoneUser;
  late TextEditingController addressUser;

  @override
  void initState() {
    super.initState();
    nameUser = TextEditingController(text: widget.selectedProfile.adminName);
    phoneUser = TextEditingController(text: widget.selectedProfile.adminPhone);
    addressUser = TextEditingController(text: widget.selectedProfile.adminAddress);
  }

  @override
  void dispose() {
    nameUser.dispose();
    phoneUser.dispose();
    addressUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit my profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
        children: [
          const SizedBox(height: 16),
            Container(
              child: TextField(
                controller: nameUser,
                decoration: InputDecoration(
                  labelText: 'Your name',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),fillColor: Colors.white,
                ),
                keyboardType: TextInputType.text,
                maxLength: 50,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: TextField(
                controller: phoneUser,
                decoration: InputDecoration(
                  labelText: 'Your number phone',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),fillColor: Colors.white
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: TextField(
                controller: addressUser,
                decoration: InputDecoration(
                  labelText: 'Your address',
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),fillColor: Colors.white
                ),
                keyboardType: TextInputType.streetAddress,
                maxLength: 100,
              ),
            ),
            const SizedBox(height: 16),
             ElevatedButton(
              onPressed: () {
                showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm save profile"),
                          content: const Text(
                              "Are you sure you want to save profile and you must login again ?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () async {
                                String adminName= nameUser.text;
                                String adminPhone= phoneUser.text;
                                String adminAddress= addressUser.text;
                                await AdministratorProvider().updateInfo(widget.selectedProfile.adminId!, adminName, adminPhone, adminAddress);
                  
                                LoginProvider().logout();
                                Navigator.of(context).pop();
                                Navigator.pop(context);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage() ));
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
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