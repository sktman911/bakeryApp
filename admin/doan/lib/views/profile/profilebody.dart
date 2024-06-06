import 'package:doan/firebase/model/profile_model.dart';
import 'package:doan/views/profile/changepassword.dart';
import 'package:flutter/material.dart';

Widget ItemMyProfile(ProfileModel profileModel, BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.amber, Colors.orange])),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Stack(
                      alignment: const Alignment(0.2, 1.5),
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.png'),
                          radius: 100,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                              ),
                              child: Expanded(
                                child: Text(
                                  profileModel.adminName ?? '???',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Account Info",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.amber,
                ),
                const SizedBox(width: 10),
                Expanded(child: Text("Role: ${profileModel.roleName ?? ""}"))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(
                  Icons.mail,
                  color: Colors.amber,
                ),
                const SizedBox(width: 10),
                Expanded(child: Text('Email: ${profileModel.adminEmail ?? ""}')),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.amber,
                ),

                const SizedBox(width: 10),

                Expanded(child: Text('Address: ${profileModel.adminAddress ?? ""}')),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.amber,
                ),
                const SizedBox(width: 10),
                Expanded(child: Text('Phone: ${profileModel.adminPhone ?? ""}')),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),

        const SizedBox(
          height: 16,
        ),

        OutlinedButton(
          onPressed: () {
             Navigator.push(context,
              MaterialPageRoute(builder: (context) => Changepassword(selectedProfile: profileModel,)));
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
                width: 1, color: Colors.amber), // Thiết lập màu border
          ),
          child: const Text(
            "Change password",
            style: TextStyle(color: Colors.amber,fontSize: 14),
          ),
        )
      ],
    ),
  );
}
