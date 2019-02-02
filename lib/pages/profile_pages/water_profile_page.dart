import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page_model.dart';
import 'package:dial_in_v1/data/strings.dart';

class WaterPage extends StatelessWidget {
// Sets a String and Value in the Parent profie

  WaterPage();

  /// UI Build
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, _, ProfilePageModel model) =>
            StreamBuilder<Profile>(
                stream: model.profileStream,
                builder:
                    (BuildContext context, AsyncSnapshot<Profile> profile) {
 
                  if ( !profile.hasData ) { return CenterdCircularProgressIndicator(); }

                  return Column(children: <Widget>[

                    /// Name
                    Card(child:
                    Container(margin: EdgeInsets.all(10), height: 100.0, child:
                    Column(mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
                    TextFieldItemWithInitalValue
                    (profile.data.getItem(DatabaseIds.waterID), 300)]))),

                    /// Date
                    DateTimeInputCard(StringLabels.dateTested,
                        profile.data.getItemValue(DatabaseIds.date),
                        (dateTime) {
                      model.setProfileItemValue(DatabaseIds.date, dateTime);
                    }),

                    /// Details
                    WaterDetailsCard(),

                    // /// Notes
                    NotesCard(profile.data.getItem(DatabaseIds.notes))
                  ]);
                }));
  }
}

class WaterDetailsCard extends StatelessWidget {
  final double _padding = 5.0;
  final double _margin = 5.0;
  final double _textFieldWidth = 140.0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, _, ProfilePageModel model) =>
            StreamBuilder<Profile>(
                stream: model.profileStream,
                builder:
                    (BuildContext context, AsyncSnapshot<Profile> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Card(
                      child: Container(
                          padding: EdgeInsets.all(_padding),
                          margin: EdgeInsets.all(_margin),
                          child: Column(
                            children: <Widget>[
                              ///Row 1
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ///Total ppm
                                    TextFieldItemWithInitalValue(
                                      snapshot.data.getItem(DatabaseIds.ppm),
                                      _textFieldWidth,
                                    ),

                                    ///gh Ppm
                                    TextFieldItemWithInitalValue(
                                      snapshot.data.getItem(DatabaseIds.gh),
                                      _textFieldWidth,
                                    ),
                                  ]),

                              ///Row 2
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  /// kH
                                  TextFieldItemWithInitalValue(
                                    snapshot.data.getItem(DatabaseIds.kh),
                                    _textFieldWidth,
                                  ),

                                  /// pH
                                  TextFieldItemWithInitalValue(
                                    snapshot.data.getItem(DatabaseIds.ph),
                                    _textFieldWidth,
                                  ),
                                ],
                              ),
                            ],
                          )));
                }));
  }
}
