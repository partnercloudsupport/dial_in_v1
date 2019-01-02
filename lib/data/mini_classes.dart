import 'package:dial_in_v1/data/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeedProfileData{

  Profile _profile;
  String _userName;
  String _userImage;

  FeedProfileData(this._profile, this._userName, this._userImage);

  Profile get profile => _profile;
  String get userName => _userName;
  String get userImage => _userImage;
}

class NumericTextFormatter extends TextInputFormatter {

  TextEditingValue formatEditUpdate
  (TextEditingValue oldValue, TextEditingValue newValue) {
       String newText = oldValue.text;
          if(oldValue.text.contains(',')){
          newText = oldValue.text.replaceAll(new RegExp(r','), '.');
          // newValue.text         oldValue.text.replaceAll(new RegExp(r'. '), '.0');
          }else{newText = oldValue.text;}
      return TextEditingValue(text: newText);
    }
}

/// TODO;
class UserProfile {
    String _userId;
    String get userId => _userId;

    String _userName;
    String get userName => _userName;

    String _userImage;
    String get userImage => _userImage;

    UserProfile(this._userId,this._userName,this._userImage);
}

 List<int> primeNumbers =
[2, 3, 5, 7, 11, 13, 17, 19, 23,
 29, 31, 37, 41, 43, 47, 53, 59, 61,
  67, 71, 73, 79, 83, 89, 97, 101, 103,
   107, 109, 113, 127, 131, 137, 139, 149, 
   151, 157, 163, 167, 173, 179, 181, 191, 193,
    197, 199];