import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/data/streams.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/mini_classes.dart';


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

/// Profiles scoped model
class ProfilesModel extends Model{

    String _userId;
    String get userId => _userId;

    String _userName;
    String get userName => _userName;

    String _userImage;
    String get userImage => _userImage;

    int get recipeProfilesCount => _recipeFeed.profilesCount;
    // cofflleProfilesCount
    // followersCount
    // followingCount

  
    Stream<List<Profile>> communityFeed;
    Stream<List<Profile>> followersFeed;

    FeedBloc _recipeFeed  = new FeedBloc(DatabaseIds.recipe);
    FeedBloc _coffeeFeed  = new FeedBloc(DatabaseIds.coffee);
    FeedBloc _grinderFeed  = new FeedBloc(DatabaseIds.grinder);
    FeedBloc _equipmentFeed  = new FeedBloc(DatabaseIds.brewingEquipment);
    FeedBloc _waterFeed  = new FeedBloc(DatabaseIds.water);
    FeedBloc _baristaFeed  = new FeedBloc(DatabaseIds.Barista);
    SocialFeedBloc _comminuty;
    SocialFeedBloc _followers;
    
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

    ProfilesModel(){
        communityFeed = recipeProfiles;
        followersFeed = recipeProfiles;
        _comminuty = new SocialFeedBloc(DatabaseIds.community);
        _followers = new SocialFeedBloc(DatabaseIds.following);
    }

    void init(){
      _recipeFeed.getProfiles();
      _coffeeFeed.getProfiles();
      _grinderFeed.getProfiles();
      _equipmentFeed.getProfiles();
      _waterFeed.getProfiles();
      _baristaFeed.getProfiles();
      _comminuty.getProfiles();
      _followers.getProfiles();
      DatabaseFunctions.getCurrentUserId().then((user){_userId = user;});
      DatabaseFunctions.getUserImage().then((image){_userImage = image;});
      DatabaseFunctions.getUserName().then((name){_userName = name;});
    }

    void deInit(){


      
    }

    static ProfilesModel of(BuildContext context) =>
      ScopedModel.of<ProfilesModel>(context);

    void add(Profile profile){

      switch (profile.type){

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

        case ProfileType.none:
         throw(profile.type);
        break;

        case ProfileType.feed:
         throw(profile.type);
        break;

        default:
         throw(profile.type);
        break;
      }
    }

    void update(Profile profile){
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
    
    void delete(Profile profile){
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
   
    /// Get social feeds with type
    Stream<List<FeedProfileData>> socialFeed(ProfileType type){

      switch(type){

        case ProfileType.recipe:
        return communnityFeed;
        break;

        case ProfileType.coffee:
        return followingFeed;
        break;

        default:
        return throw(type);
        break;
      }
    }

    /// Get Profiles with type
    Stream<List<Profile>> profiles(ProfileType type){

      switch(type){

        case ProfileType.recipe:
        return recipeProfiles;
        break;

        case ProfileType.coffee:
        return coffeeProfiles;
        break;

        case ProfileType.grinder:
        return grinderProfiles;
        break;

        case ProfileType.equipment:
        return equipmentProfiles;
        break;

        case ProfileType.water:
        return waterProfiles;
        break;

        case ProfileType.barista:
        return baristaProfiles;
        break;

        case ProfileType.none:
        return throw(type);
        break;

        case ProfileType.feed:
        return throw(type);
        break;

        default:
        return throw(type);
        break;
      }
    }
}
