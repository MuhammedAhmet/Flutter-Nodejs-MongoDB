import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/AlertBoxes/alert.dart';
import 'package:frontend/pages/otheruserprofilepage.dart';
import '../signin.dart';
import 'attend.dart';
import 'showactivities.dart';
import 'package:http/http.dart' as http;

List attendees = [];


class DetailPage extends StatelessWidget {

  Future JOIN() async {
    var res = await http.put("http://192.168.1.22:4000/act/" + activityId,
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        "attendees" : username,
      })
    );

    print(res.body);

  }

  Future getAct() async {

    print("Activity id :  "+ activityId);

    var res = await http.get("http://192.168.1.22:4000/act/" + activityId,
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
    );

    var data = json.decode(res.body);
    attendees = data["attendees"];


    print(attendees[0]);

  }

  @override
  Widget build(BuildContext context) {

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 25.0),
        Icon(
          Icons.info,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 5.0),
        Text(
          activityName,
          style: TextStyle(color: Colors.white, fontSize: 35.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Text("Creator : ",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                        InkWell(
                          onTap: () {
                            //getUsr();
                            print("Tapped CreatorUserName : " + activityCreatorUsername);
                            Navigator.push(
                                context, new MaterialPageRoute(builder: (context) => OtherProfilePage())
                            );
                          },
                          child: Text(activityCreatorUsername,
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                              )),
                        ),
                      ],
                    )
                    /*child: Text(
                      "Creator : " + activityCreatorUsername,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    )*/)),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Place : " + activityPlace,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ))),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Date : " + activityDate,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ))),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Hour : " + activityHour,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ))),
          ],
        ),

      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.59,
          padding: EdgeInsets.all(50.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.blue),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 40.0,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => IndexPage())
              );
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    
    final bottomContentText = Container(
        alignment: Alignment.topLeft,
        child: Text(
          activityInformation,
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20.0,
              color: Colors.white60
          ),
        )
    );
    
    final bottomContent = Container(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      height: MediaQuery.of(context).size.height * 0.185,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText],

        ),
      ),
    );

    final joinButton = Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 50,
          width: 400,
          child: FlatButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              onPressed: () {
                JOIN();
                successfullJOINED(context);
              },
              child: Text("Join",
                  style: TextStyle(color: Colors.white))),
        ));
    final seetheAttendeesButton = Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 50,
          width: 400,
          child: FlatButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              onPressed: () {
                getAct();
                Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => Attendees())
                );
              },
              child: Text("See The Attendees",
                  style: TextStyle(color: Colors.white))),
        ));
    
    return Scaffold(
      body: Column(
        children: <Widget>[
          topContent,
          bottomContent,
          joinButton,
          seetheAttendeesButton
        ],
      ),
    );
  }
}