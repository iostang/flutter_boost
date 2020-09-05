import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

class F2FFirstPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new F2FFirstPageState();
  }
}

class F2FFirstPageState extends State<F2FFirstPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          <Widget>[
            RaisedButton(
              child: Text('Open second with native container'),
              onPressed: () {
                FlutterBoost.singleton.open("f2f_second");
              },
            ),
            RaisedButton(
              child: Text('Open second without native container'),
              onPressed: () {
                FlutterBoostAPI.singleton.open("f2f_second",noNeedNativeContainer: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class F2FSecondPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new F2FSecondPageState();
  }
}

class F2FSecondPageState extends State<F2FSecondPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Route'),
      ),
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          <Widget>[
            Text('Hello')

          ],
        ),
      ),
    );
  }
}