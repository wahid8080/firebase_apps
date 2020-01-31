import 'package:firebase_apps/model/my_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListItem extends StatefulWidget {
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List<MyData> myData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("chats");
    reference.once().then((DataSnapshot datasnap) {
      var KEYS = datasnap.value.keys;
      var data = datasnap.value;

      myData.clear();

      for (var key in KEYS) {
        MyData data2 = new MyData(
            data[key]["image"], data[key]["name"], data[key]["title"]);
        myData.add(data2);
      }

      setState(() {
        print(myData[0].title);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List View',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Items'),
        ),
        body: Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: myData.length,
              itemBuilder: (context, position) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(myData[position].image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    // where to position the child
                    child: Container(

                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          children: <Widget>[
                            Text("Name : "+myData[position].title,style: TextStyle(fontSize: 20,color: Colors.white),),
                            Text("Discreption : "+myData[position].name,style: TextStyle(fontSize: 16,color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                  ),

                );
              }),
        ),
      ),
    );
  }
}
