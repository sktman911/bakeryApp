import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/conf/const.dart';
import 'package:demo_app/firebase/model/customer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEdited = false;
  File? _selectedImage;
  CustomerModel? _customerModel;

  String? email, imageURL;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  setEdit() {
    setState(() {
      isEdited = !isEdited;
    });
  }

  // Future<void> _openFilePicker() async {
  //   final result = await ImagePicker.platform
  //       .getImageFromSource(source: ImageSource.gallery);
  //   if (result == null) {
  //     return;
  //   }

  //   setState(() {
  //     _selectedImage = File(result.path);
  //   });
  // }

  Future<CustomerModel> loadProfile() async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    _customerModel = await CustomerModel()
        .getDataById<CustomerModel>(() => CustomerModel(), id);

    // set profile
    nameController.text = _customerModel!.customerName ?? '';
    addressController.text = _customerModel!.customerAddress ?? '';
    phoneNumController.text = _customerModel!.customerPhone ?? '';

    return _customerModel!;
  }

  void updateProfile() async {
    User user = FirebaseAuth.instance.currentUser!;
    final id = user.uid;

    await CustomerModel(
      customerAddress: addressController.text,
      customerName: nameController.text,
      customerPhone: phoneNumController.text,
    ).update(id).then((value) => loadProfile());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProfile();
    email = FirebaseAuth.instance.currentUser!.email;
    imageURL = FirebaseAuth.instance.currentUser!.photoURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: customOrange,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            children: [
              // profile avatar
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: InkWell(
                      onTap: () {
                        // if (isEdited == true) {
                        //   _openFilePicker();
                        // }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          image: imageURL != null
                              ? DecorationImage(
                                  image: NetworkImage(imageURL!),
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  image: AssetImage(defaultUserImage),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //     bottom: 0,
                  //     right: 0,
                  //     child: Container(
                  //       width: 35,
                  //       height: 35,
                  //       decoration: BoxDecoration(
                  //           boxShadow: [
                  //             BoxShadow(
                  //                 spreadRadius: 2,
                  //                 blurRadius: 2,
                  //                 color: Colors.black.withOpacity(.5))
                  //           ],
                  //           borderRadius: BorderRadius.circular(100),
                  //           color: customWhite),
                  //       child: InkWell(
                  //         onTap: () {},
                  //         child: const Icon(
                  //           Icons.camera_alt_outlined,
                  //           size: 24,
                  //         ),
                  //       ),
                  //     ))
                ],
              ),

              const SizedBox(
                height: 50,
              ),

              // profile form
              Form(
                  child: Column(
                children: [
                  // fullname field
                  TextFormField(
                    controller: nameController,
                    enabled: isEdited,
                    decoration: InputDecoration(
                        label: const Text('Full Name'),
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        labelStyle: const TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // email field
                  TextFormField(
                    initialValue: email,
                    enabled: false,
                    decoration: InputDecoration(
                        label: const Text('Email'),
                        prefixIcon: const Icon(Icons.mail_outline),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        labelStyle: const TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // phone number field
                  TextFormField(
                    controller: phoneNumController,
                    enabled: isEdited,
                    maxLength: 10,
                    decoration: InputDecoration(
                        label: const Text('Phone Number'),
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        labelStyle: const TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // address field
                  TextFormField(
                      enabled: isEdited,
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        prefixIcon: const Icon(Icons.location_city),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        labelStyle: const TextStyle(color: Colors.black),
                      )),
                  const SizedBox(
                    height: 20,
                  ),

                  // edit profile button
                  ElevatedButton(
                    onPressed: () {
                      if (isEdited == false) {
                        setEdit();
                      } else {
                        // update func
                        updateProfile();
                        setEdit();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: customOrange,
                        foregroundColor: Colors.white),
                    child: Text(isEdited == false ? 'Edit' : 'Save'),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
