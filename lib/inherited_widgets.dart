import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/data/streams.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/profile.dart';



class CameraWidget extends InheritedWidget {

  CameraWidget({Key key ,Widget child}): super(key:key, child: child);
  
  @override
  bool updateShouldNotify(CameraWidget oldWidget) => true;

  static CameraWidget of (BuildContext context) =>
    context.inheritFromWidgetOfExactType(CameraWidget) as CameraWidget;
}

class DateWidget extends InheritedWidget {

  DateWidget({Key key ,Widget child}): super(key:key, child: child);
  
  @override
  bool updateShouldNotify(DateWidget oldWidget) => true;

  static DateWidget of (BuildContext context) =>
    context.inheritFromWidgetOfExactType(DateWidget) as DateWidget;
}

class ProfilesInheritedWidget extends InheritedWidget {

  ProfilesInheritedWidget({Key key ,Widget child}): super(key:key, child: child);
  
  @override
  bool updateShouldNotify(DateWidget oldWidget) => true;

  static DateWidget of (BuildContext context) =>
    context.inheritFromWidgetOfExactType(DateWidget) as DateWidget;
}


class ProfilesModel extends Model{
  
    FeedBloc _recipeFeed  = new FeedBloc(DatabaseIds.recipe);
    FeedBloc _coffeeFeed  = new FeedBloc(DatabaseIds.coffee);
    FeedBloc _grinderFeed  = new FeedBloc(DatabaseIds.grinder);
    FeedBloc _equipmentFeed  = new FeedBloc(DatabaseIds.brewingEquipment);
    FeedBloc _waterFeed  = new FeedBloc(DatabaseIds.water);
    FeedBloc _baristaFeed  = new FeedBloc(DatabaseIds.Barista);
    

    Stream<List<Profile>> get profiles => _recipeFeed.profiles;

}