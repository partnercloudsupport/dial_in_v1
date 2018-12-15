import 'package:dial_in_v1/data/profile.dart';
import 'dart:io';

class FeedProfileData{

  Profile _profile;
  String _userId;
  File _userImage;

  FeedProfileData(this._profile, this._userId, this._userImage);

  Profile get profile => _profile;
  String get userId => _userId;
  File get userImage => _userImage;
}