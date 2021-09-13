import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/showactivities.dart';
import 'package:frontend/widget/numberswidget2.dart';
import 'package:frontend/widget/profilewidget2.dart';
import 'package:frontend/widget/appbar_widget.dart';
import 'package:frontend/widget/button_widget.dart';
import 'detailpage.dart';
import 'otheruserindividualactivities.dart';







class OtherProfilePage extends StatefulWidget {
  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}


class _OtherProfilePageState extends State<OtherProfilePage> {

  @override
  void initState() {
    print("Creator Name : " + getname);
    super.initState();
  }


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
        title: Text("Profile Page                   " + getusername),
        automaticallyImplyLeading: false,
        actions: <Widget>[
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget2(
            imagePath: getimageURL,
            onClicked: () async {
            },
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget2(),
          const SizedBox(height: 48),
          buildAbout(),
        ],
      ),
    );
  }

  Widget buildName() => Column(
    children: [
      Text(
        getname + " " + getsurname,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        getemail,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: "See Profile's Activities!",
    onClicked: () {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => OtherUsrIndividualIndexPage())
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
          getdescription,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}