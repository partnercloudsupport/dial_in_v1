import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'dart:async';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/data/item.dart';
import 'package:rxdart/rxdart.dart';

class ProfilePageModel extends Model {

  Profile _profile;

  set profile(Profile profile) {
    _profile = profile;
    _profileStreamController.sink.add(_profile);
  }

  void setProfileItemValue(String id, dynamic value) { 
    _profile.setItemValue(id, value);
    _profileStreamController.sink.add(_profile);
  }

  void setSubProfile(Profile profile) {
    _profile.setSubProfile( profile );
    _profileStreamController.add(_profile);
  }

  set profileImagePath(String imagePath) { 
    _profile.imageFilePath = imagePath;
    _profileStreamController.add(_profile);
  }

  set profileImageUrl(String imageUrl){
    _profile.imageUrl = imageUrl;
    _profileStreamController.add(_profile);
  }

  String get imageUrl => _profile.imageUrl;
  String get placeholder => _profile.placeholder;

  Item getItem(String databaseId){
    return _profile.getItem(databaseId);
  }


  dynamic getItemValue(String databaseId){
    return _profile.getItemValue(databaseId);
  }

  ///TODO
  BehaviorSubject<int> _doseStreamController ;
  BehaviorSubject<int> _yieldStreamController ;
  BehaviorSubject<int> _brewWWeightStreamController ;

  BehaviorSubject<Profile> _profileStreamController ;
  Stream<Profile> get profileStream => _profileStreamController.stream;


  BehaviorSubject<bool> _isEditingStreamController;
  Stream<bool> get isEditingStream => _isEditingStreamController.stream;
  Sink<bool> get isEdtingSink => _isEditingStreamController.sink;


  bool isFromUserFeed;
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
  _isEditing, 
  this.isOldProfile, 
  this.isCopying,
  this._isNew,
  ) {
    this.type = type; 
    _profileStreamController = new BehaviorSubject<Profile>();
    _isEditingStreamController = new BehaviorSubject<bool>();
    _isEditingStreamController.add(_isEditing);
    getProfile(profileReferance, type);
  }

 

    
    void getProfile ( String profileReferance, ProfileType type ) async {
    _profile = await Dbf.getProfileFromFireStoreWithDocRef( Functions.getProfileTypeDatabaseId( type ), profileReferance );
    _profileStreamController.add(_profile);    
    }

  String appBarTitle(bool isEditing){
  if ( isFromUserFeed && _referance != null)
    { return  "$_referance's Recipe"; } 
    
    else{
    if ( _isNew || isCopying) 
      { return StringLabels.newe + ' ' + Functions.getProfileTypeString( _profile.type);

    }else if(isEditing != null){
    if ( isEditing){  return StringLabels.editing + ' ' + Functions.getProfileTypeString( _profile.type);}
    else{ return Functions.getProfileTypeString( _profile.type );}
    }

    else{ return Functions.getProfileTypeString( _profile.type );}
    }
  }

  // Stream<int> getRatioStream(String type) {
  //   Stream<int> result;

  //   switch (type) {
  //     case DatabaseIds.brewingDose:
  //       result = _doseStreamController.stream;
  //       break;
  //     case DatabaseIds.yielde:
  //       result = _yieldStreamController.stream;
  //       break;
  //     case DatabaseIds.brewWeight:
  //       result = _brewWWeightStreamController.stream;
  //       break;
  //   }
  //   assert(result != null, 'no stream allocated');
  //   return result;
  // }

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
    _isEditingStreamController.close();
  }

  void estimateBrewRatio(BrewRatioType type) {
    isCalculating = true;

    double _dose = double.parse(_profile.getItemValue(DatabaseIds.brewingDose));
    double _yielde = double.parse(_profile.getItemValue(DatabaseIds.yielde));
    double _brewWeight = double.parse(_profile.getItemValue(DatabaseIds.brewWeight));

    double result;

    if (type == BrewRatioType.doseYield) {

      result =  (_brewWeight - (_dose* 1.9)).toDouble();
       setProfileItemValue( DatabaseIds.yielde, result );

    } else {
      result = ((_dose * 1.9) + _yielde).toDouble();
       setProfileItemValue(DatabaseIds.brewWeight, result);
    }
  }

  String getBrewRatioFromYielde( int yieldIn ) {
    int result = Functions.getIntValue( _profile.getItemValue( DatabaseIds.brewWeight )) - Functions.getIntValue( _profile.getItemValue( DatabaseIds.brewingDose ));
    return result.toString();
  }


  static ProfilePageModel of(BuildContext context) =>
      ScopedModel.of<ProfilePageModel>(context);
  
}


