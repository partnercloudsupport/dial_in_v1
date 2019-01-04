import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:dial_in_v1/pages/overview_page/user_profile_page.dart';

class CurrentUserPage extends StatelessWidget{

  final Stream<UserProfile> _userProfile;

  CurrentUserPage(this._userProfile);

  /// UI Build
  @override
  Widget build(BuildContext context) {
    return 
    StreamBuilder<UserProfile>(
          stream:  _userProfile,
          builder: (context, snapshot) {

    if (!snapshot.hasData) { return Center(child: CircularProgressIndicator(),);}
    
    else{  return UserProfilePage(snapshot.data, true);}
    }
    );
  }
}