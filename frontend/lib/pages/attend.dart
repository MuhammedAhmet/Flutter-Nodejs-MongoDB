import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detailpage.dart';
import 'dart:convert';



class Attendees extends StatefulWidget {

  @override
  _AttendeesState createState() => _AttendeesState();
}

class _AttendeesState extends State<Attendees> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendees'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
            itemCount: attendees.length,
            // The list items
            itemBuilder: (context, index) {
              return Text(
                attendees[index],
                style: TextStyle(fontSize: 24),
              );
            },
            // The separators
            separatorBuilder: (context, index) {
              return Divider(
                color: Theme.of(context).primaryColor,
              );
            }),
      ),
    );
  }


}
