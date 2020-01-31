import 'package:flutter/material.dart';
import 'second_class.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Know';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Home(),
    );
  }
}

class CheckBox extends StatefulWidget {
  final Map<String, bool> cat;
  final String name;
  CheckBox(this.name, this.cat, {Key key}) : super(key: key);

  @override
  _Check createState() => _Check(name, cat);
}

class _Check extends State<CheckBox> {
  Map<String, bool> cat;
  String name;
  @override
  _Check(this.name, this.cat);
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: <Widget>[
          Checkbox(
              value: cat[name],
              onChanged: (bool value) {
                setState(() {
                  cat[name] = value;
                });
              }),
          Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Text(name, style: TextStyle(fontSize: 20)))
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  static final List<Map<String, bool>> cats = [
    {"General Knowledge": false},
    {"Entertainment: Books": false},
    {"Entertainment: Film": false},
    {"Entertainment: Music": false},
    {"Entertainment: Musicals & Theatres": false},
    {"Entertainment: Television": false},
    {"Entertainment: Video Games": false},
    {"Entertainment: Board Games": false},
    {"Science & Nature": false},
    {"Science: Computers": false},
    {"Science: Mathematics": false},
    {"Mythology": false},
    {"Sports": false},
    {"Geography": false},
    {"History": false},
    {"Politics": false},
    {"Art": false},
    {"Celebrities": false},
    {"Animals": false},
    {"Vehicles": false},
    {"Entertainment: Comics": false},
    {"Science: Gadgets": false},
    {"Entertainment: Japanese Anime & Manga": false},
    {"Entertainment: Cartoon & Animations": false},
  ];

  List<String> getKeys(List<Map<String, bool>> c) {
    List<String> l = [];
    c.forEach((f) {
      String s = f.keys.toString().replaceAll("(", "");
      s = s.replaceAll(")", "");
      l.add(s);
    });
    return l;
  }

  @override
  Widget build(BuildContext context) {
    List<String> keys = getKeys(cats);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF007D75),
        title: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('Know',
                      style: TextStyle(fontFamily: 'Satisfy', fontSize: 40))
                ])),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: ListView.builder(
              itemCount: cats.length,
              itemBuilder: (con, i) {
                return CheckBox(keys[i], cats[i]);
              },
            ),
          ),
          Container(
            height: 50,
              child: RaisedButton(
            child: Text(
              'Commit',
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () {
              List<String> l = [];
              keys.forEach((f) {
                if (cats[keys.indexOf(f)][f]) {
                  l.add(f);
                }
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Second(l)),
              );
            },
          )),
        ],
      ),
    );
  }
}
