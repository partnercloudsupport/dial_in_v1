import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/pages/log_in.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: RaisedButton(onPressed: (){ Navigator.push(context,  MaterialPageRoute(builder: (BuildContext context) =>
                    MyHomePage()));}) ,
    )
    );
  }
}