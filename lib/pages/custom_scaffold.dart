import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {

  final title;
  final Widget _body;

  CustomScaffold(this._body, {this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title,)),
      body: _body);
  }
}
