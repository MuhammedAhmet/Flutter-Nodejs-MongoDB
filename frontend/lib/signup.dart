import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'AlertBoxes/alert.dart';
import 'package:frontend/user.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String response = "";
  final _formKey = GlobalKey<FormState>();
  Future save() async {
    var res = await http.post("http://192.168.1.22:4000/usr/signup",
        headers: <String, String>{
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "username" : user.username,
          "email": user.email,
          "password": user.password
        })
    );
        /*body: <String, String>{
          //"_id":user.id,
          //"name": user.name,
          //"surname": user.surname,
          "email": user.email,
          //"username": user.username,
          "password": user.password,
          //"gender": user.gender,
          //"age": user.age,
          //"description": user.description,
          //"imageURL": user.imageURL
        });*/
    print(res.body);
    if(res.body.length != 33 && res.body.length != 36){
      successfullSignedUp(context);
    }
    response = res.body;
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: 0,
            child: SvgPicture.asset(
              'images/top.svg',
              width: 400,
              height: 150,
            )),
        Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
                ),
                Text(
                  "Activity App",
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sign up!",
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: TextEditingController(text: user.email),
                    onChanged: (value) {
                      user.username = value;
                      //value = user.email;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter something';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter the username",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: TextEditingController(text: user.email),
                    onChanged: (value) {
                      user.email = value;
                      //value = user.email;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter something';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return 'Enter valid email';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter the e-Mail",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: TextEditingController(text: user.email),
                    onChanged: (value) {
                      user.password = value;
                      //value = user.email;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter something';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter the password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      height: 50,
                      width: 400,
                      child: FlatButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              save();

                              if (response.length == 33){
                                showAlertDialogEmail(context);
                              }
                              if (response.length == 36){
                                showAlertDialogUsername(context);
                              }
                            } else {
                              print("not ok");
                            }
                          },
                          child: Text("Sign Up",
                              style: TextStyle(color: Colors.white))),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(65, 20, 0, 0),
                    child: Row(
                      children: [
                        Text("          Already have an Account ?",
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Signin()));
                          },
                          child: Text("   Sign in",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
