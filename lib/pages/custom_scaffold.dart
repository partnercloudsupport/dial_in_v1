import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/theme/appColors.dart';
import 'package:dial_in_v1/pages/overview_page/data.dart';
import 'package:dial_in_v1/pages/overview_page/feed.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/pages/overview_page/current_user_page.dart';
import 'package:dial_in_v1/theme/theme_test_page.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';


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
