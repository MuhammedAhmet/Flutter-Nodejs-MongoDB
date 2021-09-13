// @dart=2.9

import 'package:flutter/material.dart';
import 'package:frontend/signin.dart';
import 'package:frontend/pages/showactivities.dart';
import 'package:frontend/themes/color.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Signin(),
  ));
}

/*
void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primary
      ),
      home: IndexPage(),
    )
);*/

/*void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primary
      ),
      home: Fetch(),
    )
);*/