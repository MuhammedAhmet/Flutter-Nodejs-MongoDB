import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/pages/detailpage.dart';
import 'package:frontend/pages/profilepage.dart';
import 'package:frontend/signin.dart';
import 'package:frontend/themes/color.dart';
import 'package:http/http.dart' as http;
import '../dashboard.dart';
import 'addactivities.dart';
import 'individualaddactivities.dart';
import 'individualdetailpage.dart';

String activityId = "";
String activityName = "";
String activityPlace = "";
String activityDate = "";
String activityHour = "";
String activityCreatorUsername = "";
String activityInformation = "";


class IndividualIndexPage extends StatefulWidget {
  @override
  _IndividualIndexPageState createState() => _IndividualIndexPageState();
}

class _IndividualIndexPageState extends State<IndividualIndexPage> {
  List activities = [];
  List activities2 = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }
  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = "http://192.168.1.22:4000/act";
    var response = await http.get(url);
    // print(response.body);
    if(response.statusCode == 200){
      var items = json.decode(response.body);
      setState(() {
        activities = items;
        isLoading = false;
      });
    }else{
      activities = [];
      isLoading = false;
    }

    for(int i=0;i<activities.length;i++){
      if(activities[i]['creatorUsername'] == username){
        activities2.add(activities[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("Your Activities"),
            automaticallyImplyLeading: false,
            actions: <Widget>[
            ],
          ),
          //body: getBody(),
          //body: button(),
          body: Stack(
            children: [
              getBody(),
              button(),
            ],
          ),
        )
    );

  }
  Widget button(){
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        onPressed: () {
          print("Tapped!!!");

          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => IndAddActivities())
          );

        },child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
  Widget getBody(){
    if(activities2.contains(null) || activities2.length < 0 || isLoading){
      return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(primary),));
    }
    return ListView.builder(
        itemCount: activities2.length,
        itemBuilder: (context,index){
          return getCard(activities2[index]);
        });
  }
  Widget getCard(item){
    //var fullName = item['name']['title']+" "+item['name']['first']+" "+item['name']['last'];
    //var email = item['email'];
    //var profileUrl = item['picture']['large'];
    var id = item['_id'];
    var name = item['name'];
    var place = item['place'];
    var date = item['date'];
    var hour = item['hour'];
    var creatorUsername = item['creatorUsername'];
    var info = item['information'];
    return InkWell(
        onTap: (){
          print("Tapped!!");

          activityId = id.toString();
          activityName = name.toString();
          activityPlace = place.toString();
          activityDate = date.toString();
          activityHour = hour.toString();
          activityCreatorUsername =  creatorUsername.toString();
          activityInformation = info.toString();

          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => IndividualDetailPage())
          );
        },
        child: Card(
          //color: Color.fromRGBO(64, 75, 96, .9),
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(60/2),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("https://ysprodportal.blob.core.windows.net/cache/5/7/a/5/0/c/57a50c410ddc8493e033712fe272b1837f647d0a.png")
                        )
                    ),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                          width: MediaQuery.of(context).size.width-200,
                          child: Text(name,style: TextStyle(fontSize: 17),)),
                      SizedBox(height: 10,),
                      SizedBox(width: MediaQuery.of(context).size.width-140,child: Text(place.toString(),overflow: TextOverflow.fade,style: TextStyle(color: Colors.grey),)),
                      Text(date.toString(),style: TextStyle(color: Colors.grey),),
                      Text(hour.toString(),style: TextStyle(color: Colors.grey),),

                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
