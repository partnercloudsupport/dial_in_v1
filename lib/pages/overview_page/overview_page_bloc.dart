import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/pages/overview_page/overview_page.dart';



class OverviewPageBloc extends StatelessWidget {
  
  final ProfilesModel model = ProfilesModel();

  @override
  Widget build(BuildContext context) {
    print('rebuilding bloc');
    return ScopedModel(
      model: model,
      child: OverviewPage(),
    );
  }
}