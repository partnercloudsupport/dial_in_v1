import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'dart:async';
import 'package:dial_in_v1/data/strings.dart';
import 'package:rxdart/rxdart.dart';

class ProfilePageModel extends Model {

  Profile _profile;

  void setProfileItemValue(String id, dynamic value) {
    
    _profile.setItemValue(DatabaseIds.brewingDose, value);
    _profileStreamController.add(_profile);
  }

   void setSubProfile(Profile profile) {
    
    _profile.setSubProfile( profile );
    _profileStreamController.add(_profile);
  }

  set profileImagePath(String imagePath) => _profile.imageFilePath;
  set profileImageUrl(String imageUrl) => _profile.imageUrl;



  ///TODO
  BehaviorSubject<int> _doseStreamController ;
  BehaviorSubject<int> _yieldStreamController ;
  BehaviorSubject<int> _brewWWeightStreamController ;

  BehaviorSubject<Profile> _profileStreamController ;
  Stream<Profile> get profileStream => _profileStreamController.stream;

  bool isFromUserFeed;
  bool isEditing;
  bool isOldProfile;
  bool isCopying;
  bool _referance;
  bool _isNew;
  ProfileType type;

  bool isCalculating = false;

  ProfilePageModel(
    String profileReferance, 
    ProfileType type, 
    this.isFromUserFeed, 
    this.isEditing, 
    this.isOldProfile, 
    this.isCopying,
    this._isNew) {
      this.type = type; 
      _profileStreamController = new BehaviorSubject<Profile>();
      getProfile(profileReferance, type);
  }

  void getProfile ( String profileReferance, ProfileType type ) async {
    _profile = await Dbf.getProfileFromFireStoreWithDocRef( Functions.getProfileTypeDatabaseId( type ), profileReferance );
    _profileStreamController.add(_profile);

    if ( _profile.type == ProfileType.recipe ) { setupRatios(); }
  }

  void setupRatios(){
    _doseStreamController = new BehaviorSubject<int>();
    _yieldStreamController = new BehaviorSubject<int>();
    _brewWWeightStreamController = new BehaviorSubject<int>();

    _doseStreamController.add( Functions.getIntValue(_profile.getItemValue(DatabaseIds.brewingDose)));
    _yieldStreamController.add( Functions.getIntValue(_profile.getItemValue(DatabaseIds.yielde)));
    _brewWWeightStreamController.add( Functions.getIntValue(_profile.getItemValue(DatabaseIds.brewWeight)));

    _doseStreamController.listen((value) {
       setProfileItemValue(DatabaseIds.brewingDose, value);
    });
    _yieldStreamController.listen((value) {
       setProfileItemValue(DatabaseIds.yielde, value);
    });
    _brewWWeightStreamController.listen((value) {
       setProfileItemValue(DatabaseIds.brewWeight, value);
    });
  }

  String appBarTitle(){
  if ( isFromUserFeed && _referance != null)
    { return  "$_referance's Recipe"; } 
    
    else{
    if ( _isNew || isCopying) 
      { return StringLabels.newe + ' ' + Functions.getProfileTypeString( _profile.type);

    }else if ( isEditing){  return StringLabels.editing + ' ' + Functions.getProfileTypeString( _profile.type);}
    else{ return Functions.getProfileTypeString( _profile.type);}
    }
  }

  Stream<int> getRatioStream(String type) {
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

  int getRatioValue(String type) {
    int result;

    switch (type) {
      case DatabaseIds.brewingDose:
        result = _profile.getItemValue(DatabaseIds.brewingDose);
        break;
      case DatabaseIds.yielde:
        result = _profile.getItemValue(DatabaseIds.yielde);
        break;
      case DatabaseIds.brewWeight:
        result = _profile.getItemValue(DatabaseIds.brewWeight);
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
      result = Functions.getIntValue( _profile.getItemValue(DatabaseIds.brewWeight)) - Functions.getIntValue(( _profile.getItemValue(DatabaseIds.brewingDose).roundToDouble() * 1.9));
       setProfileItemValue( DatabaseIds.yielde, result );
      return result.toString();
    } else {
      result = Functions.getIntValue( _profile.getItemValue(DatabaseIds.brewingDose).roundToDouble() * 1.9) + Functions.getIntValue( _profile.getItemValue(DatabaseIds.yielde));
       setProfileItemValue(DatabaseIds.brewWeight, result);
      return result.toString();
    }
  }

  void updateRatioValues(){
    _doseStreamController.add ( Functions.getIntValue( _profile.getItemValue( DatabaseIds.brewingDose )));
    _yieldStreamController.add ( Functions.getIntValue(_profile.getItemValue( DatabaseIds.yielde )));
    _brewWWeightStreamController.add ( Functions.getIntValue( _profile.getItemValue( DatabaseIds.brewWeight )));
  }

  String getBrewRatioFromYielde( int yieldIn ) {
    int result = Functions.getIntValue( _profile.getItemValue( DatabaseIds.brewWeight )) - Functions.getIntValue( _profile.getItemValue( DatabaseIds.brewingDose ));
    return result.toString();
  }

  static ProfilePageModel of(BuildContext context) =>
      ScopedModel.of<ProfilePageModel>(context);
}
