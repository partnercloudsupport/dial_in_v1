import 'package:dial_in_v1/data/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dial_in_v1/database_functions.dart';

class FeedProfileData{

  Profile _profile;
  UserProfile _userProfile;

  FeedProfileData(this._profile, this._userProfile);

  Profile get profile => _profile;
  UserProfile get userProfile => _userProfile;
  String get userName => _userProfile._userName;
  String get userImage => _userProfile._userImage;
  List<String> get following => _userProfile._following;

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

    UserProfile(this._userId,this._userName,this._userImage, this._following);

    String _userId;
    String get userId => _userId;

    String _userName;
    String get userName => _userName;

    String _userImage;
    String get userImage => _userImage;

    List<String> _following = new List<String>();
    List<String> get following => _following;

    Future<int> getRecipeCount()async{ 
      return await DatabaseFunctions.getCount(ProfileType.recipe, _userId);
    }

    Future<int> getcoffeeCount()async{ 
      return await DatabaseFunctions.getCount(ProfileType.coffee, _userId);
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

enum FeedType {community, following}
enum SnapShotDataState{
  waiting, noData, hasdata, hasError
}

 List<int> primeNumbers =
[2, 3, 5, 7, 11, 13, 17, 19, 23,
 29, 31, 37, 41, 43, 47, 53, 59, 61,
  67, 71, 73, 79, 83, 89, 97, 101, 103,
   107, 109, 113, 127, 131, 137, 139, 149, 
   151, 157, 163, 167, 173, 179, 181, 191, 193,
    197, 199];