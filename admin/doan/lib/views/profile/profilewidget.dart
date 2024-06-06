import 'package:doan/firebase/model/profile_model.dart';
import 'package:doan/views/profile/editprofile.dart';
import 'package:doan/views/profile/profilebody.dart';
import 'package:flutter/material.dart';

class Profilewidget extends StatefulWidget {
  final ProfileModel profileModel;
  Profilewidget({Key? key, required this.profileModel}) : super(key: key);

  @override
  _ProfilewidgetState createState() => _ProfilewidgetState();
}

class _ProfilewidgetState extends State<Profilewidget> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ItemMyProfile(widget.profileModel, context)
                  ),
                ],
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Editprofile(selectedProfile: widget.profileModel,)));
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
