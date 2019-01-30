import 'package:dial_in_v1/data/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'dart:io';

class FeedProfileData{

  Profile _profile;
  UserProfile _userProfile;

  FeedProfileData(this._profile, this._userProfile);

  Profile get profile => _profile;
  UserProfile get userProfile => _userProfile;
  String get userName => _userProfile.userName;
  String get userImage => _userProfile.imageUrl;

}

class NumericTextFormatter extends TextInputFormatter {

  TextEditingValue formatEditUpdate
  (TextEditingValue oldValue, TextEditingValue newValue) {
       String newText = oldValue.text;
          if(oldValue.text.contains(',')){
          newText = oldValue.text.replaceAll(new RegExp(r','), '.');
          }else{newText = oldValue.text;}
      return TextEditingValue(text: newText);
    }
}

class  UserProfile {

    UserProfile
    (String _userId, String _userName, String _userImageUrl, List<String> _following, List<String> _followers, String _motto, ){
       id = _userId; 
       userName = _userName; 
       imageUrl = _userImageUrl; 
       following = _following; 
       followers = _followers; 
       motto = _motto; 
      //  imageFilePath = _userImageFilePath;      
    }

    //TODO put into map
    Map<String, dynamic> values = Map<String, dynamic>();

    String get id => values[DatabaseIds.userId];
    set id(String setid) => values[DatabaseIds.userId] = setid;

    String get userName => values[DatabaseIds.userName];
    set userName(String setuserName) => values[DatabaseIds.userName] = setuserName;

    String get motto => values[DatabaseIds.motto];
    set motto(String setmotto) => values[DatabaseIds.motto] = setmotto;

    String get imageUrl => values[DatabaseIds.imageUrl];
    set imageUrl(String setimageUrl) => values[DatabaseIds.imageUrl] = setimageUrl;

    // String get imageFilePath => values[DatabaseIds.imagePath];
    // set imageFilePath(String setimageFilePath) => values[DatabaseIds.imagePath] = setimageFilePath;

    List<String> get followers => values[DatabaseIds.followers];
    set followers(List<String> setimageFilePath) => values[DatabaseIds.followers] = setimageFilePath;

    List<String> get following => values[DatabaseIds.following];
    set following(List<String> setimageFilePath) => values[DatabaseIds.following] = setimageFilePath;


    Future<int> getRecipeCount()async{ 
      return await Dbf.getCount(ProfileType.recipe, id);
    }

    Future<int> getcoffeeCount()async{ 
      return await Dbf.getCount(ProfileType.coffee, id);
    }

    bool isUserFollowing(String otherUser){

      bool result;

      if (following != null) {

        List<String> followingList = following;

         result =  followingList.contains(otherUser) ? true : false; 
      }
      return result;
  }
}

class UserDetails{

  UserDetails({String userNameIn, String idIn, String photoIn, String mottoIn, String emailIn ,String passwordIn, }){
      id = idIn;
      photoUrl = photoIn;
      // imagePath = photoPathIn;
      userName = userNameIn;
      motto = mottoIn;
      email = emailIn;
      password = passwordIn;
  }

    Map<String, String> values = Map<String, String>();

      set id(String newId) => values[DatabaseIds.userId] = newId;
      set photoUrl(String newimage) => values[DatabaseIds.imageUrl] = newimage;
      // set imagePath(String newimageFile) => values[DatabaseIds.imagePath] = newimageFile;
      set userName(String newuserName) => values[DatabaseIds.userName] = newuserName;
      set motto(String newmotto) => values[DatabaseIds.motto] = newmotto;
      set email(String newemail) => values[DatabaseIds.email] = newemail;
      set password(String newpassword) => values[DatabaseIds.password] = newpassword; 
    
      String get id => values[DatabaseIds.userId];
      String get photoUrl => values[DatabaseIds.imageUrl];
      // String get imagePath => values[DatabaseIds.imagePath];
      String get userName => values[DatabaseIds.userName];
      String get motto => values[DatabaseIds.motto];
      String get email => values[DatabaseIds.email];
      String get password => values[DatabaseIds.password];

      Future<String> getPhotoPath()async{ 

        dynamic value;

        if (await File(values[DatabaseIds.imagePath]).exists())
        { value = values[DatabaseIds.imagePath];}
        else{ Dbf.updateField(DatabaseIds.user, id, DatabaseIds.imagePath, null);
        }
        assert(value != null, 'Value is null');
        return value;
      }
}

abstract class ImagePickerReturn{}

abstract class ImageReturnedFalse extends ImagePickerReturn{}

abstract class ImageReturnedTrue extends ImagePickerReturn{}

enum FeedType {community, following}
enum SnapShotDataState{waiting, noData, hasdata, hasError}

 List<int> primeNumbers =
[2, 3, 5, 7, 11, 13, 17, 19, 23,
 29, 31, 37, 41, 43, 47, 53, 59, 61,
  67, 71, 73, 79, 83, 89, 97, 101, 103,
   107, 109, 113, 127, 131, 137, 139, 149, 
   151, 157, 163, 167, 173, 179, 181, 191, 193,
    197, 199];