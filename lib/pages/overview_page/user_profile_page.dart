import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class UserProfilePage extends StatelessWidget {
  final UserProfile _userProfile;
  final bool isCurrentUser;
  final int tag;

  UserProfilePage(this._userProfile, this.isCurrentUser, {this.tag});

  /// UI Build
  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<ProfilesModel>(
        rebuildOnChange: false,
        builder: (context, _, model) => 
        
        ListView(children:[
          Container(
            child: Card(
                    child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    child: Center(
                        child: Hero(
                            tag: tag == null ?  _userProfile.userId : _userProfile.userId + tag.toString(),
                            child: CircularPicture(
                                _userProfile.userImage, 150.0)))),

                /// User name
                Text(
                  _userProfile.userName,
                  style: Theme.of(context).textTheme.display3,
                ),

                ///Spacer
                Container(
                  height: 20.0,
                ),

                // Following button Logic
                isCurrentUser
                    ? Container(width: 0, height: 0)
                    : FollowButton(_userProfile.userId),

                Counts(_userProfile),

                //TODO bio
                Card(
                  margin: EdgeInsets.all(20.0),
                  child: 
                  Container(
                    width: double.infinity, 
                    padding: EdgeInsets.all(20.0), 
                    child:Text('Bio')
                  ),
                )
                
              ],
            )
            )
          )
        ]
      )
    );
  }
}

class CountBlock extends StatelessWidget {
  final String _count;
  final String _label;

  CountBlock(this._count, this._label);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Column(
        children: <Widget>[CountLabel(_count), Text(_label)],
      ),
    );
  }
}

class Counts extends StatelessWidget {
  final UserProfile _userProfile;

  Counts(this._userProfile);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: new Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Brew count
                FutureBuilder(
                    future: _userProfile.getRecipeCount(),
                    initialData: '',
                    builder: (context, snapshot) => CountBlock(
                          snapshot.data.toString(),
                          StringLabels.brewCount,
                        )),

                /// Bean Stash
                FutureBuilder(
                    future: _userProfile.getcoffeeCount(),
                    initialData: '',
                    builder: (context, snapshot) => CountBlock(
                          snapshot.data.toString(),
                          StringLabels.beanStash,
                        )),
              ]),

          Padding(padding: EdgeInsets.all(20.0),),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Followers
              CountBlock(
                _userProfile.followers.length.toString(),
                StringLabels.followers,
              ),

              /// Following
              CountBlock(
                _userProfile.following.length.toString(),
                StringLabels.following,
              ),
            ],
          ),

         
        ],
      ),
    );
  }
}
