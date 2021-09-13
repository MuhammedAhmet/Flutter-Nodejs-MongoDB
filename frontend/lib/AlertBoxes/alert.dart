import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/addactivities.dart';
import 'package:frontend/pages/profilepage.dart';
import 'package:frontend/pages/showactivities.dart';
import 'package:frontend/signin.dart';


showAlertNullAccount(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Warning"),
    content: Text("There is no account like this!!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



showAlertDialogEmail(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Warning"),
    content: Text("Email already taken"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
showAlertDialogUsername(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Warning"),
    content: Text("Username already taken"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
successfullSignedUp(BuildContext context){
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Signin())
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Warning"),
    content: Text("Successfull Signed Up!!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}
successfullAddedActivity(BuildContext context){
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      //Navigator.of(context).pop();
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => IndexPage())
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(""),
    content: Text("Activity Added Successfully!!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
successfullJOINED(BuildContext context){
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(""),
    content: Text("Joined Successfully!!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

successfullIndivAddedActivity(BuildContext context){
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {

      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => ProfilePage())
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(""),
    content: Text("Activity Added Successfully!!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

successfullEditedProfile(BuildContext context){
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => IndexPage())
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(""),
    content: Text("Profile Edited Successfully!!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

successfullDeletedActivity(BuildContext context){
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {

      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => ProfilePage())
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(""),
    content: Text("Activity Deleted Successfully!!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

errorAddedActivity(BuildContext context){
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
      /*Navigator.push(
          context, new MaterialPageRoute(builder: (context) => AddActivities())
      );*/
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("ERROR"),
    content: Text("Problem Occurred Check Again!!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}