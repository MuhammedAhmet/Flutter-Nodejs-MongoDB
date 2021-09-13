import 'package:flutter/material.dart';
import 'package:frontend/AlertBoxes/alert.dart';
import 'package:frontend/pages/profilepage.dart';
import 'individualactivities.dart';
import 'package:http/http.dart' as http;


class IndividualDetailPage extends StatelessWidget {

  Future deleteact() async{
    var res = await http.delete("http://192.168.1.22:4000/act/" + activityId,
        headers: <String, String>{
          'Content-Type': 'application/json'
        });

    print(res);
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
                    child: Text(
                      "Creator : " + activityCreatorUsername,
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
          height: MediaQuery.of(context).size.height * 0.7,
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
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
              SizedBox(width: 325,),
              InkWell(
                onTap: () {
                  deleteact();
                  successfullDeletedActivity(context);
                },
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ],
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
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText],
        ),
      ),
    );


    return Scaffold(
      body: Column(
        children: <Widget>[
          topContent,
          bottomContent,
        ],
      ),
    );
  }
}