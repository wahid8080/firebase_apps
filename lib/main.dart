
import 'dart:io';

import 'package:firebase_apps/my_widgets/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'list_item.dart';
import 'my_style/StyleList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String imageUrl;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("firebaseConnectoin"),),
      body: Center(
        child: new Container(
          child: ListItem(),
        ),
      ),
      floatingActionButton: FloatingActionButton (
        onPressed:(){
          String _title,_name;
          return Alert(
              context: context,
              title: "Input Image",
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.crop_original,color: Colors.white,),
                          SizedBox(width: 10,),
                          Text("Select Image",style: TextStyle(color: Colors.white,fontSize: 18),),
                        ],
                      ),
                      onPressed: (){
                        getImage();
                      },
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      obscureText: false,
                      style: style,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(2.0, 15.0, 20.0, 15.0),
                          hintText: "Name",
                      ),
                      onChanged: (String title){
                        setState(() {
                          _title = title;
                        });
                      },
                    ),
                    TextField(
                      obscureText: false,
                      style: style,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(2.0, 15.0, 20.0, 15.0),
                        hintText: "Disctrption",
                      ),
                      onChanged: (String name){
                        setState(() {
                          _name = name;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            buttons: [
              DialogButton(
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: (){
                  uploadImage();
                  uploadData(_title, _name,imageUrl);
                  Navigator.pop(context);

                },
                color: Color.fromRGBO(0, 179, 134, 1.0),
              ),
            ],
          ).show();
        },
        tooltip: 'Increment',
        child: Icon(
            Icons.add,
        ),
      ),
    );
  }

 void uploadImage() async
  {

    int dateTime = DateTime.now().millisecondsSinceEpoch;

    FirebaseStorage _storage = FirebaseStorage.instance;
    StorageReference reference = _storage.ref().child(dateTime.toString());
    StorageUploadTask uploadTask = reference.putFile(_image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;

    imageUrl = await reference.getDownloadURL();

    setState(() {

    });

  }

  Future<void> uploadData(String title,String name,String imageUri)
  {

    print(imageUri);

    var _firebaseRef = FirebaseDatabase().reference().child('chats');
    _firebaseRef.push().set({
      "title": title,
      "name": name,
      "image" : imageUri,
    });


  }
}
