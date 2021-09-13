import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/pages/showactivities.dart';
import 'package:frontend/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/user.dart';
import 'AlertBoxes/alert.dart';

String id = "";
String name = "";
String surname = "";
String email = "";
String username = "";
String password = "";
String gender = "";
String age = "";
String description = "";
String imageURL = "";

refresh() async{
  var res = await http.get("http://192.168.1.22:4000/usr/" + id,
      headers: <String, String>{
      'Content-Type': 'application/json'
      });

  print("REFRESHH : " + res.body);
  print("id : " + id);

  //////////////////////////////////////
  var data = json.decode(res.body);
  id = data["_id"];
  name = data["name"];
  surname = data["surname"];
  password = data["password"];
  email = data["email"];
  username = data["username"];
  gender = data["gender"];
  age = data["age"];
  description = data["description"];
  imageURL = data["imageURL"];

}

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String response = "";
  final _formKey = GlobalKey<FormState>();
  Future save() async {
    var res = await http.post("http://192.168.1.22:4000/usr/signin",
        headers: <String, String>{
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "email": user.email,
          "password": user.password
        })
    );
        /*body: <String, String>{
          "_id":user.id,
          "name": user.name,
          "surname": user.surname,
          "email": user.email,
          "username": user.username,
          "password": user.password,
          "gender": user.gender,
          "age": user.age,
          "description": user.description,
          "imageURL": user.imageURL
        });*/
    print(res.body);

    if(res.body == "null"){
      showAlertNullAccount(context);
    }else{
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => IndexPage())
      );
    }
    response = res.body;

    //////////////////////////////////////
    var data = json.decode(res.body);
    id = data["_id"];
    name = data["name"];
    surname = data["surname"];
    password = data["password"];
    email = data["email"];
    username = data["username"];
    gender = data["gender"];
    age = data["age"];
    description = data["description"];
    imageURL = data["imageURL"];


    /////
    if(data["name"] == null){
      name = "Null";
    }
    if(data["surname"] == null){
      surname = "Null";
    }
    if(data["gender"] == ""){
      gender = "Null";
    }
    if(data["age"] == ""){
      age = "Null";
    }
    if(data["description"] == null){
      description = "Please Edit Your Profile !!";
    }
    if(data["imageURL"] == null){
      imageURL = "https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg";
    }


    print(username);
    //////////////////////////////////////

  }

  User user = User('', '', '', '', '', '', '', '', '', '',);

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
                  height: 150,
                ),
                Text(
                  "Activity App",
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Sign in!",
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.black54),
                ),
                /*Text(
                  "Activity App",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.black12),
                ),*/
                SizedBox(
                  height: 25,
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
                    obscureText: true,
                    controller: TextEditingController(text: user.password),
                    onChanged: (value) {
                      user.password = value;
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
                              print(response);
                              //print("OOOKKKEEok");
                            } else {
                              print("not ok");
                            }
                          },
                          child: Text("Sign In",
                              style: TextStyle(color: Colors.white))),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(65, 20, 0, 0),
                    child: Row(
                      children: [
                        Text("          Not have an Account ?",
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Text("   Sign up",
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
