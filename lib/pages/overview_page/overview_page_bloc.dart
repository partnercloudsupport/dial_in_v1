import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/theme/appColors.dart';
import 'package:dial_in_v1/pages/overview_page/data.dart';
import 'package:dial_in_v1/pages/overview_page/feed.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/pages/overview_page/user_profile.dart';
import 'package:dial_in_v1/pages/overview_page/overview_page.dart';



class OverviewPageBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScopedModel(
      model: ProfilesModel(),
      child: OverviewPage(),
    )
    );
  }
}