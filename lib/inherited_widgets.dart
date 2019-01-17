import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/data/streams.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

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
      DatabaseFunctions.unFollow(currentUserProfile.id, otherUser, (success) {
        _userFeed.refresh();
        competionFollow(false);
      })
      .catchError((error){print(error); Error();});
    } else {
      DatabaseFunctions.addFollower(currentUserProfile.id, otherUser, (success) {
        _userFeed.refresh();
        competionFollow(true);
      })
      .catchError((error){print(error); Error();});
;
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
    DatabaseFunctions.logOut().catchError((error) => print(error));
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
    DatabaseFunctions.updateProfile(profile);
    // switch (profile.type){

    //   case ProfileType.recipe:
    //    _recipeFeed.add(profile);
    //   break;

    //   case ProfileType.coffee:
    //    _coffeeFeed.add(profile);
    //   break;

    //   case ProfileType.grinder:
    //    _grinderFeed.add(profile);
    //   break;

    //   case ProfileType.equipment:
    //    _equipmentFeed.add(profile);
    //   break;

    //   case ProfileType.water:
    //    _waterFeed.add(profile);
    //   break;

    //   case ProfileType.barista:
    //    _baristaFeed.add(profile);
    //   break;

    //   case ProfileType.none:
    //    throw(profile.type);
    //   break;

    //   case ProfileType.feed:
    //    throw(profile.type);
    //   break;

    //   default:
    //    throw(profile.type);
    //   break;
    // }
  }

  void delete(Profile profile) {
    DatabaseFunctions.deleteProfile(profile);

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

      default: Error();        break;
    }
  }
}

class ProfileModel extends Model {
  Profile _profile;

  ProfileModel(_profile);
}

class RatioModel extends Model {
  RatioModel(this._dose, this._yielde, this._brew) {
    _doseStreamController.add(_dose);
    _yieldStreamController.add(_yielde);
    _brewWWeightStreamController.add(_brew);
    _doseStreamController.listen((value) {
      _dose = value;
    });
    _yieldStreamController.listen((value) {
      _yielde = value;
    });
    _brewWWeightStreamController.listen((value) {
      _brew = value;
    });
  }

  ///TODO
  BehaviorSubject<int> _doseStreamController = new BehaviorSubject<int>();
  BehaviorSubject<int> _yieldStreamController = new BehaviorSubject<int>();
  BehaviorSubject<int> _brewWWeightStreamController =
      new BehaviorSubject<int>();

  bool isCalculating = false;

  /// not used yet TODO
  int _dose = 0;
  int _yielde = 0;
  int _brew = 0;

  Stream<int> getStream(String type) {
    Stream<int> result;

    switch (type) {
      case DatabaseIds.brewingDose:
        result = _doseStreamController.stream;
        break;
      case DatabaseIds.yielde:
        result = _yieldStreamController.stream;
        break;
      case DatabaseIds.brewWeight:
        result = _brewWWeightStreamController.stream;
        break;
    }
    assert(result != null, 'no stream allocated');
    return result;
  }

  int getValue(String type) {
    int result;

    switch (type) {
      case DatabaseIds.brewingDose:
        result = _dose;
        break;
      case DatabaseIds.yielde:
        result = _yielde;
        break;
      case DatabaseIds.brewWeight:
        result = _brew;
        break;
    }
    return result ?? 0;
  }

  void dispose() {
    _doseStreamController.close();
    _yieldStreamController.close();
    _brewWWeightStreamController.close();
  }

  String estimateBrewRatio(BrewRatioType type) {
    isCalculating = true;

    int result;

    if (type == BrewRatioType.doseYield) {
      result = _brew - (_dose.roundToDouble() * 1.9).toInt();
      _yielde = result;
      return result.toString();
    } else {
      result = (_dose.roundToDouble() * 1.9).toInt() + _yielde;
      _brew = result;
      return result.toString();
    }
  }

  void updateValue(String databaseId, String value) {
    switch (databaseId) {
      case DatabaseIds.brewingDose:
        _dose = int.parse(value);
        break;
      case DatabaseIds.yielde:
        _yielde = int.parse(value);
        break;
      case DatabaseIds.brewWeight:
        _brew = int.parse(value);
        break;
    }
  }

  void updateValues(Profile profile) {
    _doseStreamController.add(Functions.getIntValue(
        profile.getItemValue(DatabaseIds.brewingDose)));
    _yieldStreamController.add(
        Functions.getIntValue(profile.getItemValue(DatabaseIds.yielde)));
    _brewWWeightStreamController.add(Functions.getIntValue(
        profile.getItemValue(DatabaseIds.brewWeight)));
    _dose =
        Functions.getIntValue(profile.getProfileItem(DatabaseIds.brewingDose));
    _yielde = Functions.getIntValue(profile.getProfileItem(DatabaseIds.yielde));
    _brew =
        Functions.getIntValue(profile.getProfileItem(DatabaseIds.brewWeight));
  }

  String getBrewRatioFromYielde(
    int yieldIn,
  ) {
    int result = _brew - _dose;
    return result.toString();
  }

  String getBrewRatioFromBrewWeight(
    int brewIn,
  ) {}

  static RatioModel of(BuildContext context) =>
      ScopedModel.of<RatioModel>(context);
}
