import 'package:AgeCalc/nextB.dart';
import 'package:flutter/material.dart';
import 'package:age/age.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Calculate(),
    );
  }
}

class Calculate extends StatefulWidget {
  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> with SingleTickerProviderStateMixin {


  Animation animation;
  AnimationController animationController;
  AgeDuration age,nextBirthdayDuration;
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
      firstDate: new DateTime(1900),
      initialDate: new DateTime.now(),
      lastDate: new DateTime.now()).then((DateTime dt){
        setState(() {
          yourDob=dt;
          calculateAge();
        });
      });
  }

  void calculateAge(){
    setState(() {
      current = DateTime.now();

    age=Age.dateDifference(
      fromDate: yourDob, toDate: current, includeToDate: false);

      animation=new Tween<double>(begin: animation.value,end: 2.0).animate(new CurvedAnimation(
        curve: Curves.fastOutSlowIn,parent:animationController
        ),);
        animation.addListener((){
      setState(() {});
    });
    animationController.forward();
      return age;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculate Your age")
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
           
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

            new Text("Your age is:",
              style:new TextStyle(fontSize: 29.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
              ),),

            new Padding(
              padding: const EdgeInsets.all(5.0),
            ),

            new Text("$age",
            style:new TextStyle(fontSize: 21.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
            ),),

            new Padding(
              padding: const EdgeInsets.all(30.0),
            ),
            RaisedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => NextBday())),
              child: new Text("Know your next Birthday",style:new TextStyle(fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
            ),),color: Colors.green,
            ),

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


// Teekam Singh
// Hello world
