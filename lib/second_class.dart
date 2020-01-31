import 'package:flutter/material.dart';
import 'futureBuilder.dart';

class FactHolder extends StatefulWidget {
  final List<String> l;
  static Future<List<Map<String, dynamic>>> query;
  FactHolder(this.l, {Key key}) : super(key: key) {
    query = getQuery(l);
  }

  @override
  _Fact createState() => _Fact(query);
}

class _Fact extends State<FactHolder> {
  Future<List<Map<String, dynamic>>> query;
  FutureBuilder<Map<String, dynamic>> qa;
  Widget textAnswer = Text("");
  String counter = "0";
  bool locked = false;

  _Fact(q) {
    query = q;
    qa = buildFutureBuilder(getData(query), setAnswerText);
  }
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      counter,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Expanded(
                  child: qa,
                ),
                textAnswer,
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: change,
                  ),
                ),
              ],
            )));
  }

  void setAnswerText(isTrue, rightAnswer) {
    if (!locked) {
      locked = true;
      setState(() {
        if (isTrue) {
          counter = (int.parse(counter) + 1).toString();
          textAnswer = Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Correct!",
                style: TextStyle(
                    color: Color(0xFF529A86),
                    backgroundColor: Colors.black87,
                    fontSize: 20),
              ));
        } else {
          counter = (int.parse(counter) - 1).toString();
          textAnswer = Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Incorrect! " + rightAnswer,
                style: TextStyle(
                    color: Color(0xFFEC6778),
                    backgroundColor: Colors.black87,
                    fontSize: 20),
              ));
        }
      });
    }
  }

  void change() {
    setState(() {
      locked = false;
      textAnswer = Text("");
      qa = buildFutureBuilder(getData(query), setAnswerText);
    });
  }
}

class Second extends StatelessWidget {
  final List<String> l;
  Second(this.l);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF007D75),
      ),
      body: Center(child: FactHolder(l)),
    );
  }
}
