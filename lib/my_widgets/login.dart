import 'dart:math';

import 'package:firebase_apps/my_style/StyleList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../list_item.dart';

class LoginFrom extends StatefulWidget {
  @override
  _LoginFromState createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {

  String _email,_pass;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Email",
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
          onChanged: (String email){
            setState(() {
              _email = email;
            });
          },
        ),
        SizedBox(height: 20,),
        TextField(
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Password",
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
          onChanged: (String pass){
            setState(() {
              _pass = pass;
            });
          },
        ),
        SizedBox(height: 20,),
        RaisedButton(
          color: Colors.red,
          child: Text('Click',style: TextStyle(color: Colors.white,fontSize: 20),),
            onPressed: (){
            bool isLogin;
            login(_email,_pass).whenComplete((){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ListItem()));
            });

        })

      ],
    );
  }

  Future<void> login(String email,String pass) async
  {
    print("EMAIL"+email);
    FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass)) as FirebaseUser;
    print('Login successfull');
  }
}
