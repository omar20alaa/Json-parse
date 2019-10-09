import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {

  List json_data = await getJson();
  String body;

  for (int i = 0 ; i < json_data.length ; i ++)
    {
      print("title : " + json_data[i]['title']);
    }

  body = json_data[0]['body'];

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('JSON Parse'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: new Center(
        child: new ListView.builder(
            itemCount: json_data.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context , int position)
            {
              if (position.isOdd)
                return new Divider();
              final index = position ~/ 2;
              return new ListTile(
                title: new Text("${json_data[position]['title']}",
                style : new TextStyle(
                fontSize: 13.9
                )),
                subtitle: new Text("${json_data[position]['body']}",
                  style : new TextStyle(
                      color: Colors.grey,
                    fontStyle: FontStyle.italic
                  )),
                leading: new CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  child: new Text("${json_data[position]['body'][0].toString().toUpperCase()}",
                  style : new TextStyle(
                    fontSize: 19.4,
                    color: Colors.black
                  )
                  )
                ),

                onTap: () {
                  showOnTapMessage(context , "${json_data[index]['title']}");
                },


              );
            }
        ),
      ),
    ),
  ));
}


void showOnTapMessage(BuildContext context , String message){
  var alert = new AlertDialog(
    title : new Text('App'),
    content : new Text(message),
    actions: <Widget>[
      new FlatButton(onPressed : (){Navigator.pop(context);},
          child : new Text('Ok')
      )
    ],
  );
  showDialog(context: context , child : alert);
} // init click on item


Future<List> getJson() async {

  String api_url = 'https://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(api_url);

  return jsonDecode(response.body);

} // get json method
