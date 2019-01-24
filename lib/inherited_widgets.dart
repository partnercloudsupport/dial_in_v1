import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/data/streams.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'dart:async';

class CameraWidget extends InheritedWidget {
  CameraWidget({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(CameraWidget oldWidget) => true;

  static CameraWidget of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CameraWidget) as CameraWidget;
}

class DateWidget extends InheritedWidget {
  DateWidget({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(DateWidget oldWidget) => true;

  static DateWidget of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(DateWidget) as DateWidget;
}

class ProfilesInheritedWidget extends InheritedWidget {
  ProfilesInheritedWidget({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(DateWidget oldWidget) => true;

  static DateWidget of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(DateWidget) as DateWidget;
}


class ImagePickerWidget extends Model{

  

}

/// Profiles scoped model
class ProfilesModel extends Model {

  Stream<UserProfile> get userProfileStream { assert( _userFeed.userStream != null, '_userFeed.userProfile'); return _userFeed.userStream;}
  UserProfile get currentUserProfile { assert( _userFeed.userProfile != null, '_userFeed.userProfile'); return _userFeed.userProfile;}
  UserDetails get userdetails { assert( _userFeed.userDetails != null, '_userFeed.userDetails'); return _userFeed.userDetails;}

  int get recipeProfilesCount => _recipeFeed.profilesCount ?? 0;
  int get coffeeProfilesCount => _coffeeFeed.profilesCount ?? 0;

  FeedBloc _recipeFeed = new FeedBloc(DatabaseIds.recipe);
  FeedBloc _coffeeFeed = new FeedBloc(DatabaseIds.coffee);
  FeedBloc _grinderFeed = new FeedBloc(DatabaseIds.grinder);
  FeedBloc _equipmentFeed = new FeedBloc(DatabaseIds.brewingEquipment);
  FeedBloc _waterFeed = new FeedBloc(DatabaseIds.water);
  FeedBloc _baristaFeed = new FeedBloc(DatabaseIds.Barista);
  SocialFeedBloc _comminuty;
  SocialFeedBloc _followers;
  UserFeed _userFeed = new UserFeed();

  /// init
  ProfilesModel() {
    _comminuty = new SocialFeedBloc(
                          DatabaseIds.community,
                          userProfileStream,
    );
    _followers = new SocialFeedBloc(DatabaseIds.following,
                                    userProfileStream,
                                    isUserFollowing: isUserFollowing);
  }

  /// Checks the current user agaist the userId
  ///  to check if current is following
  bool isUserFollowing(String otherUser) {
    bool result;

    if (currentUserProfile.following != null) {
      List<String> followingList = currentUserProfile.following;

      result = followingList.contains(otherUser) ? true : false;
    }
    return result;
  }

  /// Checks the following status then updates the record accordingly
  void followOrUnfollow(String otherUser, Function(bool) competionFollow) {
    if (isUserFollowing(otherUser)) {
      Dbf.unFollow(currentUserProfile.id, otherUser, (success) {
        _userFeed.refresh();
        competionFollow(false);
      })
      .catchError((error){print(error); Error();});
    } else {
      Dbf.addFollower(currentUserProfile.id, otherUser, (success) {
        _userFeed.refresh();
        competionFollow(true);
      })
      .catchError((error){print(error); Error();});
    }
    // _followers.refresh();
  }

  /// Getters for profiles
  Stream<List<Profile>> get recipeProfiles => _recipeFeed.profiles;
  Stream<List<Profile>> get coffeeProfiles => _coffeeFeed.profiles;
  Stream<List<Profile>> get grinderProfiles => _grinderFeed.profiles;
  Stream<List<Profile>> get equipmentProfiles => _equipmentFeed.profiles;
  Stream<List<Profile>> get waterProfiles => _waterFeed.profiles;
  Stream<List<Profile>> get baristaProfiles => _baristaFeed.profiles;

  /// Getters for social feeds
  Stream<List<FeedProfileData>> get communnityFeed => _comminuty.profiles;
  Stream<List<FeedProfileData>> get followingFeed => _followers.profiles;


  void logOut() {
    Dbf.logOut().catchError((error) => print(error));
    deInit();
  }

  void refreshUser() {
    _userFeed.refresh();
  }

  void init() async {
    await _userFeed.getProfile();
    _recipeFeed.getProfiles();
    _coffeeFeed.getProfiles();
    _grinderFeed.getProfiles();
    _equipmentFeed.getProfiles();
    _waterFeed.getProfiles();
    _baristaFeed.getProfiles();
    _comminuty.getProfiles();
    _followers.getProfiles();
  }

  void deInit() {
    _recipeFeed.deinit();
    _coffeeFeed.deinit();
    _grinderFeed.deinit();
    _equipmentFeed.deinit();
    _waterFeed.deinit();
    _baristaFeed.deinit();
    _userFeed.deinit();
  }

  static ProfilesModel of(BuildContext context) =>
      ScopedModel.of<ProfilesModel>(context);

  void add(Profile profile) {
    switch (profile.type) {
      case ProfileType.recipe:
        _recipeFeed.add(profile);
        break;

      case ProfileType.coffee:
        _coffeeFeed.add(profile);
        break;

      case ProfileType.grinder:
        _grinderFeed.add(profile);
        break;

      case ProfileType.equipment:
        _equipmentFeed.add(profile);
        break;

      case ProfileType.water:
        _waterFeed.add(profile);
        break;

      case ProfileType.barista:
        _baristaFeed.add(profile);
        break;

      default:
        Error();
        break;
    }
  }

  void update(Profile profile) {
    Dbf.updateProfile(profile);
  }

  void delete(Profile profile) {
    Dbf.deleteProfile(profile);

    switch (profile.type) {
      case ProfileType.recipe:
        _recipeFeed.removeProfile(profile);
        break;

      case ProfileType.coffee:
        _coffeeFeed.removeProfile(profile);
        break;

      case ProfileType.grinder:
        _grinderFeed.removeProfile(profile);
        break;

      case ProfileType.equipment:
        _equipmentFeed.removeProfile(profile);
        break;

      case ProfileType.water:
        _waterFeed.removeProfile(profile);
        break;

      case ProfileType.barista:
        _baristaFeed.removeProfile(profile);
        break;

      default: Error();
      
        break;
    }
  }

  /// Get social feeds with type
  Stream<List<FeedProfileData>> getSocialFeed(FeedType type) {
    _userFeed.refresh();

    switch (type) {
      case FeedType.community:
        return communnityFeed;
        break;

      case FeedType.following:
        return followingFeed;
        break;

      default:
        return throw (type);
        break;
    }
  }

  /// Get Profiles with type
  Stream<List<Profile>> profiles(ProfileType type) {
   
    _userFeed.getProfile();

    switch (type) {
      case ProfileType.recipe:
        _recipeFeed.getProfiles();
        return recipeProfiles;
        break;

      case ProfileType.coffee:
        _coffeeFeed.getProfiles();
        return coffeeProfiles;
        break;

      case ProfileType.grinder:
        _grinderFeed.getProfiles();
        return grinderProfiles;
        break;

      case ProfileType.equipment:
        _equipmentFeed.getProfiles();
        return equipmentProfiles;
        break;

      case ProfileType.water:
        _waterFeed.getProfiles();
        return waterProfiles;
        break;

      case ProfileType.barista:
        _baristaFeed.getProfiles();
        return baristaProfiles;
        break;

      default: throw('No Stream returned ');        break;
    }
  }
}

class ImagePickerModel extends Model {

  String _referance = 'dvjbeuyvba';
  String get referance => _referance;

  String _filePath;
  String get getFilePath => _filePath;
  set setFilePath(String filePath) => _filePath = filePath;

 static ImagePickerModel of(BuildContext context) =>
      ScopedModel.of<ImagePickerModel>(context);
  
}

