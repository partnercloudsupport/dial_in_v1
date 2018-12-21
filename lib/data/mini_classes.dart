import 'package:dial_in_v1/data/profile.dart';

class FeedProfileData{

  Profile _profile;
  String _userName;
  String _userImage;

  FeedProfileData(this._profile, this._userName, this._userImage);

  Profile get profile => _profile;
  String get userName => _userName;
  String get userImage => _userImage;
}

 List<int> primeNumbers =
[2, 3, 5, 7, 11, 13, 17, 19, 23,
 29, 31, 37, 41, 43, 47, 53, 59, 61,
  67, 71, 73, 79, 83, 89, 97, 101, 103,
   107, 109, 113, 127, 131, 137, 139, 149, 
   151, 157, 163, 167, 173, 179, 181, 191, 193,
    197, 199];