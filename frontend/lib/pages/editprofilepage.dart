import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/AlertBoxes/alert.dart';
import 'package:frontend/pages/profilepage.dart';
import 'package:frontend/pages/showactivities.dart';
import 'package:frontend/widget/editprofile_widget.dart';
import 'package:path/path.dart';
import 'package:frontend/signin.dart';
import 'package:frontend/widget/appbar_widget.dart';
import 'package:frontend/widget/textfield_widget.dart';
import 'package:frontend/widget/button_widget.dart';
import 'package:frontend/widget/profile_widget.dart';
import 'package:http/http.dart' as http;
import '../user.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  String gender = "";
  String _dropDownValue = "";

  Future save() async {

    if(user.name == ""){
      user.name = name;
    }
    if(user.surname == ""){
      user.surname = surname;
    }
    if(user.password == ""){
      user.password = password;
    }
    if(user.email == ""){
      user.email = email;
    }
    if(user.description == ""){
      user.description = description;
    }

    var res = await http.put("http://192.168.1.22:4000/usr/" + id,
        headers: <String, String>{
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "username" : username,
          "gender" : user.gender,
          "age" : user.age,
          "imageURL" : imageURL,
          "name" : user.name,
          "surname": user.surname,
          "password": user.password,
          "email": user.email,
          "description": user.description,
        })
    );
    print(res.body);

    /*if(res.body.length != 33 && res.body.length != 36){
      successfullSignedUp(context);
    }*/
  }

  User user = User(
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  );


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: buildAppBar(context),
    body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      physics: BouncingScrollPhysics(),
      children: [
        EditProfileWidget(
          imagePath: imageURL,
          //isEdit: true,
          onClicked: () async {
            save();
            refresh();
            successfullEditedProfile(context);
          },
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: name),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value){
                user.name = value;
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Surname",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: surname),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value){
                user.surname = value;
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Password",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              controller: TextEditingController(text: password),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value){
                user.password = value;
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: email),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value){
                user.email = value;
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Text(
              "Gender",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: gender),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value){
                user.gender = value;
              },
            ),*/
            /*DropdownButton<String>(
              hint : Text("Gender"),
              items: <String>['Male', 'Female', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            )*/
            Text(
              "Gender",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButton(
              hint: _dropDownValue == null?
              Text('Dropdown') :
              Text(
                _dropDownValue,
                style: TextStyle(color: Colors.black),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['Male', 'Female', 'Other'].map(
              (val) {
              return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
              );
              },
              ).toList(),
              onChanged: (val) {
              setState(
              () {
              _dropDownValue = val.toString();
              },
              );
              user.gender = val.toString();
              },
              ),
          ],
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Age",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: age),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value){
                user.age = value;
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: description),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value){
                user.description = value;
              },
            ),
          ],
        ),
      ],
    ),
  );
}