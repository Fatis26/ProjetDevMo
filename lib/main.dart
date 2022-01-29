import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Firebase Crud',
      home: MyHomePage(title: 'Firestore CRUD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final FirebaseFirestore  _firestore = FirebaseFirestore.instance;
  static final _CollectionReference = _firestore.collection("Users").doc("UsersInfo").collection("Profile");
  static final _DocumentReference = _CollectionReference.doc();

  static final _CollectionReference1 = _firestore.collection("User").doc("1sTD7Hd8OMQY1pbp9zf7");
  static final _DocumentReference1 = _CollectionReference.doc('1sTD7Hd8OMQY1pbp9zf7');
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(title: const Text('Login'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(  
                hintText: 'Email'
              ),
               onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
  
            
            TextButton( onPressed: ()=>addData(),child: const Text("add")),
            TextButton(onPressed: ()=> readData(), child: const Text("Read Data")),
            TextButton(onPressed: ()=> updateData(), child: const Text("Update Data")),
            TextButton(onPressed: ()=> deleteData(), child: const Text("Delete Data")),
          ],
        ),
      
    );
  }
addData() async{
    Map<String,dynamic> demoData = {
      "Name": _email,
      "Email":_password
    };
    _DocumentReference.set(demoData)
        .whenComplete(() => Fluttertoast.showToast(msg: "User Added"))
        .onError((error, stackTrace) => Fluttertoast.showToast(msg: error.toString()));
  }

//add 1

  addData1() async{
    Map<String,dynamic> demoData = {
      "pass": _email,
      "username":_password
    };
    _DocumentReference1.set(demoData)
        .whenComplete(() => Fluttertoast.showToast(msg: "User Added1"))
        .onError((error, stackTrace) => Fluttertoast.showToast(msg: error.toString()));
  }
  readData() async {
    var documentsnapshot = await  _CollectionReference.doc("ProfileInfo").get();
    if(documentsnapshot.exists){
      Map<String,dynamic>? data = documentsnapshot.data();
      Fluttertoast.showToast(msg: data?['Name']);
    }
  }
  updateData()async{
     Map<String,dynamic> demoData = {
       "Name": "Saral Jain",
     };
     _DocumentReference.update(demoData)
         .whenComplete(() => Fluttertoast.showToast(msg: "User Updated"))
         .onError((error, stackTrace) => Fluttertoast.showToast(msg: error.toString()));
   }
   deleteData() async{
    _DocumentReference.delete().
        whenComplete(() => Fluttertoast.showToast(msg: "User Deleted"))
        .onError((error, stackTrace) => Fluttertoast.showToast(msg: error.toString()));
   }



}
