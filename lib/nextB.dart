import 'package:age/age.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class NextBday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NextBirthday();
  }
}

class NextBirthday extends StatefulWidget {
  @override
  _NextBirthdayState createState() => _NextBirthdayState();
}

class _NextBirthdayState extends State<NextBirthday> with SingleTickerProviderStateMixin {


  Animation animation;
  AnimationController animationController;
  AgeDuration age,nextBirthdayDuration;
  DateTime tempDate,nextBirthdayDate;
  var current;
  var yourDob;
  @override
  void initState() {
    animationController=new AnimationController(vsync: this,duration: new Duration(milliseconds: 1500));
    animation=animationController;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _showPicker(){
    showDatePicker(
      context: context,
      firstDate: new DateTime(1800),
      initialDate: new DateTime.now(),
      lastDate: new DateTime.now()).then((DateTime dt){
        setState(() {
          yourDob=dt;
          _nextB();
        });
      });
  }

  void _nextB(){
    setState(() {
      current = DateTime.now();
      age=Age.dateDifference(
      fromDate: yourDob, toDate: current, includeToDate: false);
      tempDate = DateTime(current.year, yourDob.month, yourDob.day);
      if (tempDate.isBefore(current)) {
        nextBirthdayDate = Age.add(date: tempDate, duration: AgeDuration(years: 1));
      } else {
        nextBirthdayDate = tempDate;
      }
      nextBirthdayDuration =Age.dateDifference(fromDate: current, toDate: nextBirthdayDate);
      animation=new Tween<double>(begin: animation.value,end: 2.0).animate(new CurvedAnimation(
        curve: Curves.fastOutSlowIn,parent:animationController
        ),);
        animation.addListener((){
      setState(() {});
      });
      animationController.forward();
      return nextBirthdayDuration;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Know your next Bday")
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Container(
              width:400,
              height: 150,
              child: FlareActor(
                "assets/teddy.flr",
                animation: "success",   //test, success,idle,fail
                isPaused: false,
                
              ),
            ),
            new Text("Select your Date of Birth",
            style:new TextStyle(fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
            ),),

            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            RaisedButton(onPressed: _showPicker,
              child: new Text(yourDob!=null?yourDob.toString():"Enter your DOB",style:new TextStyle(fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
            ),),
            color: Colors.red,
            ),

            new Padding(
              padding: const EdgeInsets.all(20.0),
            ),

      
           new Text("Your next Birthday will be in: ",
              style:new TextStyle(fontSize: 22.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
              ),),

             new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new Text("$nextBirthdayDuration",
            style:new TextStyle(fontSize: 17.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
            ),),
              
          ]
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child:Text("Built by @TS❤️",textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),),
       // color:Colors.grey
      ),
    );
  }
}