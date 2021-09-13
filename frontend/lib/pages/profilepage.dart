import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/AlertBoxes/alert.dart';
import 'package:frontend/pages/editprofilepage.dart';
import 'package:frontend/pages/showactivities.dart';
import 'package:frontend/signin.dart';
import "package:frontend/user.dart";
import 'package:frontend/widget/appbar_widget.dart';
import 'package:frontend/widget/button_widget.dart';
import 'package:frontend/widget/numbers_widget.dart';
import 'package:frontend/widget/profile_widget.dart';
import 'package:http/http.dart' as http;

import 'individualactivities.dart';
//import 'package:user_profile_example/utils/user_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

/*
  String imageURL = "";
  String name = "";
  String surname = "";
  //String email = "";
  String description = "";

  Future save() async {
    var res = await http.post("http://192.168.1.22:4000/usr/signin",
        headers: <String, String>{
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "email": email,
          "password": password
        })
    );
    print(res.body);

    //////////////////////////////////////
    var data = json.decode(res.body);
    name = data["name"];
    surname = data["surname"];
    email = data["email"];
    //username = data["username"];
    //gender = data["gender"];
    //age = data["age"];
    description = data["description"];
    imageURL = data["imageURL"];

    //////////////////////////////////////

  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: buildAppBar(context),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => IndexPage())
            );
          }
        ),
        title: Text("Profile Page                   " + username),
        automaticallyImplyLeading: false,
        actions: <Widget>[
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: imageURL,
            onClicked: () async {
              print("Tapped!!");
              refresh();
              Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => EditProfilePage())
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(),
        ],
      ),
    );
  }

  Widget buildName() => Column(
    children: [
      Text(
        name + " " + surname,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'See Your Activities!',
    onClicked: () {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => IndividualIndexPage())
      );
    },
  );

  Widget buildAbout() => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}