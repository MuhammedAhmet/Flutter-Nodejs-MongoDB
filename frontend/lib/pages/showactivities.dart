import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/pages/detailpage.dart';
import 'package:frontend/pages/profilepage.dart';
import 'package:frontend/signin.dart';
import 'package:frontend/themes/color.dart';
import 'package:http/http.dart' as http;
import '../dashboard.dart';
import 'addactivities.dart';


String activityId = "";
String activityName = "";
String activityPlace = "";
String activityDate = "";
String activityHour = "";
String activityCreatorUsername = "";
String activityInformation = "";

String getid = "";
String getname = "";
String getsurname = "";
String getemail = "";
String getusername = "";
String getpassword = "";
String getgender = "";
String getage = "";
String getdescription = "";
String getimageURL = "";


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List activities = [];
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
  }

  //////////////////////////////////////
  Future getUsr() async {
    var res = await http.get("http://192.168.1.22:4000/usr/username/"+ activityCreatorUsername,
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
    );

    print("RES NOKTA BODY : " + res.body);

    var data = json.decode(res.body);
    getid = data["_id"];
    getname = data["name"];
    getsurname = data["surname"];
    getpassword = data["password"];
    getemail = data["email"];
    getusername = data["username"];
    getgender = data["gender"];
    getage = data["age"];
    getdescription = data["description"];
    getimageURL = data["imageURL"];


    /////
    if(data["name"] == ""){
      getname = "Null";
    }
    if(data["surname"] == ""){
      getsurname = "Null";
    }
    if(data["gender"] == ""){
      getgender = "Null";
    }
    if(data["age"] == ""){
      getage = "Null";
    }
    if(data["description"] == ""){
      getdescription = "Please Edit Your Profile !!";
    }
    if(data["imageURL"] == null){
      getimageURL = "https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg";
    }

  }
  ///////////////////////////////////////


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
          endDrawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height : 100.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Hello ' + username,
                  style: new TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                  ),
                ),
              ),
             /* ListTile(
                leading: Icon(Icons.message),
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),*/
              ListTile(

                leading: Icon(Icons.account_circle_outlined),
                title: Text('Profile Page'),
                onTap: () {
                  print(name);
                  refresh();
                  Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => ProfilePage())
                  );
                },
              ),
              ListTile(

                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                onTap: () {
                  Navigator.push(
                      context, new MaterialPageRoute(builder: (context) => Signin())
                  );
                },
              ),
            ],
          ),
        ),
          appBar: AppBar(
            title: Text("Activities"),
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
              context, new MaterialPageRoute(builder: (context) => AddActivities())
          );

        },child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
  Widget getBody(){
    if(activities.contains(null) || activities.length < 0 || isLoading){
      return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(primary),));
    }
    return ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context,index){
          return getCard(activities[index]);
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

        print("AKTIVITE OLUSTURANIN kullanıcı ADI : " + activityCreatorUsername);

        getUsr();

        print("AKTIVITE OLUSTURANIN ADI : " + getname);

        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => DetailPage())
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
