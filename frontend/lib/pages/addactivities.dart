import 'dart:convert';
import 'package:frontend/AlertBoxes/alert.dart';
import 'package:frontend/Tables/activity.dart';
import 'package:frontend/pages/showactivities.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/signin.dart';

class AddActivities extends StatefulWidget {
  const AddActivities({Key? key}) : super(key: key);

  @override
  _AddActivitiesState createState() => _AddActivitiesState();
}

class _AddActivitiesState extends State<AddActivities> {
  String date = "";
  String hour = "";
  String response = "";
  final _formKey = GlobalKey<FormState>();

  Activity activity = Activity(
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  );

  Future save() async {
    var res = await http.post("http://192.168.1.22:4000/act",
        headers: <String, String>{
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "name" : activity.name,
          "information" : activity.information,
          "place": activity.place,
          "date": activity.date,
          "hour": activity.hour,
          "creatorUsername" : activity.creatorUsername
        })
    );
    print(res.body);
    /*if(res.body.length != 33 && res.body.length != 36){
      successfullAddedActivity(context);
    }*/
    response = res.body;
  }

  ValidatorAndSave(){
    if(activity.name != "" || activity.name.isNotEmpty){
      if(activity.place != "" || activity.place.isNotEmpty){
        if(activity.place != "" || activity.place.isNotEmpty){
          if(activity.date != "" || activity.date.isEmpty){
            if(activity.hour != "" || activity.hour.isEmpty){
              activity.creatorUsername = username;
              save();
            }else{
              errorAddedActivity(context);
            }
          }else{
            errorAddedActivity(context);
          }
        }else{
          errorAddedActivity(context);
        }
      }else{
        errorAddedActivity(context);
      }
    }else{
      errorAddedActivity(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Add Activity"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            new IconButton(icon: const Icon(Icons.save), onPressed: () {

              print("Tapped!!");
              if(activity.name != "" && activity.information != "" && activity.place != "" && activity.date != "" && activity.hour != "")
                {
                  ValidatorAndSave();
                  successfullAddedActivity(context);
                }
              else
                {
                  errorAddedActivity(context);
                }
            }),
            new IconButton(onPressed: (){

              //Navigator.of(context).pop();
              Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => IndexPage())
              );
            }, icon: const Icon(Icons.arrow_back_ios)),
          ],
        ),
        body: new Column(
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.add_circle),
              title: new TextFormField(
                onChanged: (value) {
                  activity.name = value;
                  //value = user.email;
                },
                decoration: new InputDecoration(
                  hintText: "Activity Name",
                ),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.info),
              title: new TextFormField(
                onChanged: (value) {
                  activity.information = value;
                  //value = user.email;
                },
                decoration: new InputDecoration(
                  hintText: "Activity information",
                ),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.place),
              title: new TextFormField(
                onChanged: (value) {
                  activity.place = value;
                  //value = user.email;
                },
                decoration: new InputDecoration(
                  hintText: "Activity Place/Address",
                ),
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            new ListTile(
              onTap: () {
                print("tapped!");
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2022)).then((value) {
                  setState(() {
                    date = value.toString().substring(0,11);
                  });
                  print(date);
                  activity.date = date;
                }

                );
              },
              leading: const Icon(Icons.today),
              title: const Text('Activity Date'),
              subtitle: Text(date),
            ),
            new ListTile(
              onTap: (){
                print("tapped!");
                showTimePicker(context: context,
                    initialTime: TimeOfDay.now()).then((value) {
                  setState(() {
                    hour =  value.toString().substring(10,15);
                  });
                  print(hour);
                  activity.hour = hour;
                }
                );
              },
              leading: const Icon(Icons.timelapse),
              title: const Text('Activity Hour'),
              subtitle: Text(hour),
            )
          ],
        ),
      )
    );
  }
}
