import 'package:dial_in_v1/data/profile.dart';
import 'dart:io';

class FeedProfileData{

  Profile _profile;
  String _userName;
  String _userImage;

  FeedProfileData(this._profile, this._userName, this._userImage);

  Profile get profile => _profile;
  String get userName => _userName;
  String get userImage => _userImage;
}