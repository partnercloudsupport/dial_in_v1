import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/theme/appColors.dart';
import 'package:dial_in_v1/pages/overview_page/data.dart';
import 'package:dial_in_v1/pages/overview_page/feed.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/pages/overview_page/current_user_page.dart';
import 'package:dial_in_v1/theme/theme_test_page.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:dial_in_v1/data/images.dart';
import 'dart:io';


class UserInputDetails extends StatefulWidget { 
  final UserDetails userDetails;
  UserInputDetails({this.userDetails});
  _UserInputDetailsState createState() => _UserInputDetailsState();
}

class _UserInputDetailsState extends State<UserInputDetails> {

  final _formKey = GlobalKey<FormState>();

  UserDetails  _userDetails;

  void initState() { 
    super.initState();
    _userDetails = widget.userDetails ?? UserDetails();
  }

  _handleSubmitted() {

    final FormState form = _formKey.currentState;
    if (!form.validate()) {

    } else {
      form.save();
      PopUps.showCircularProgressIndicator(context);
      Dbf.updateUserProfile(_userDetails)
                  .catchError((String error)=> PopUps.showAlert('Warning', error, 'ok', () => Navigator.pop(context), context))
                  .then((_) { 
                      /// Pop Circular indicator
                      Navigator.pop(context);
                      ProfilesModel.of(context).refreshUser();
                      /// PopBack to drawer
                      Navigator.pop(context);
                    }
                  );       
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return 
    
    Container( margin:EdgeInsets.all(10), child: 
    Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[

          Container( padding: EdgeInsets.all(20.0), alignment: Alignment(0, 0),
              child: 
              InkWell(
              onTap:(){ 
                  Functions.getimageFromCameraOrGallery(
                    context,(String imagepath)async{
                        String url = await Dbf.upLoadFileReturnUrl(File(imagepath), [DatabaseIds.user, _userDetails.id, 'images']);
                        setState(() {  _userDetails.photoUrl = url;});});
                  },
              child: UserDetailsCachedProfileImage( _userDetails , 200.0)
            )
          ),

          ///Username
          TextFormField(
            decoration: InputDecoration(labelText: StringLabels.userName),
            initialValue: _userDetails.userName ?? '',
            validator: (String value) {
              if (value.isEmpty) {
                return 'Enter some text';
              }
            },
            onSaved: (value){_userDetails.userName = value;}
          ),

           ///Motto
            TextFormField(
            initialValue: _userDetails.motto ?? '',
            decoration: InputDecoration(
                          labelText: StringLabels.motto,
                          hasFloatingPlaceholder: true,
                                      ),
            obscureText: false,
            // TODO
            onSaved: (String value){if (value != null || value != ''){_userDetails.motto = value;}}

          ),

          /// Email
          TextFormField(
            decoration: InputDecoration(labelText: StringLabels.email),
            initialValue: _userDetails.email ?? '',
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter a valid email';
              }
            },
            onSaved: (value){_userDetails.email = value;}
          ),

          ///Password
          TextFormField(
            decoration: InputDecoration(
                          labelText: StringLabels.password,
                          hasFloatingPlaceholder: true,
                          helperText: 'If applicable'
                                      ),
            obscureText: true,
            onSaved: (String value){if (value != null || value != '')_userDetails.password = value;}
          ),

          /// Submit button
            Container(width: 100,padding: const EdgeInsets.symmetric(vertical: 16.0), child: 
            RaisedButton(
              onPressed: () {
                _handleSubmitted();
              },
              child: Text('Submit'),
            ),
            )
        ],
      ),
      ) 
    );
  }
}



