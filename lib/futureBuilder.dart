import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'base.dart';

Future<List<Map<String, dynamic>>> getQuery(List<String> li) {
  Base base = Base();
  return base.base.then((db) {
    Future<List<Map<String, dynamic>>> l;
    if (li.isEmpty) {
      l = db.query("Trivia");
    } else {
      String have = "category = \"" + li[0] + "\"";
      li.forEach((f) {
        if (li.indexOf(f) != 0) {
          have = have + "OR category = \"" + f + "\"";
        }
        l = db.query("Trivia", where: have);
      });
    }
    return l;
  });
}

Future<Map<String, dynamic>> getData(Future<List<Map<String, dynamic>>> li) {
  final _random = new Random();
  return li.then((l) {
    num index = _random.nextInt(l.length);
    Map<String, dynamic> result = l[index];
    return result;
  });
}

FutureBuilder<Map<String, dynamic>> buildFutureBuilder(query, fn) {
  return FutureBuilder<Map<String, dynamic>>(
    future: query,
    builder:
        (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
      List<Widget> children;

      if (snapshot.hasData) {
        children = <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 100, bottom: 20),
            child: Text(
              snapshot.data["question"],
              style: TextStyle(fontSize: 20),
            ),
          ),
        ];
        children.add(getButtons(snapshot.data, fn));
      } else if (snapshot.hasError) {
        children = [Text('Error: ${snapshot.error}')];
      } else {
        children = <Widget>[
          Text("Loading..."),
        ];
      }
      return Center(
        child: Column(
          children: children,
        ),
      );
    },
  );
}

Expanded getButtons(data, fn) {
  List<String> all = [];
  List<Widget> buttons = [];
  List<Color> colors = [Color(0xFFFCD2A8), Color(0xFFEC6778), Color(0xFF007D75), Color(0xFF529A86)];
  all.add(data["correct"]);
  all.addAll(data["incorrect"].split(","));
  if(all.length > 4){
    all = all.take(4).toList();
  }
  all.shuffle();
  all.forEach((f) => {
        buttons.add(
          Container(
              child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 100,
                    width: 180,
                    child: RaisedButton(
                      color: colors[all.indexOf(f)],
                    onPressed: () {
                      correctAnswer(f, data, fn);
                    },
                    child: Text(
                      f,
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                  )
                  )),
        )
      });
  //buttons.shuffle();
  return Expanded(
    child: GridView.count(
      mainAxisSpacing: 50,
      childAspectRatio: 3,
      crossAxisCount: 2,
      children: buttons,
    ),
  );
}

void correctAnswer(ans, data, fn) {
  if (ans == data["correct"]) {
    fn(true, "");
  } else {
    fn(false, data["correct"]);
  }
}
