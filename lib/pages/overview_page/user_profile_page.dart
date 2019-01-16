import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/data/images.dart';
import 'package:scoped_model/scoped_model.dart';

class UserProfilePage extends StatelessWidget {
  final UserProfile _userProfile;
  final bool isCurrentUser;
  final int tag;

  UserProfilePage(this._userProfile, this.isCurrentUser, {this.tag});

  /// UI Build
  @override
  Widget build(BuildContext context) =>

 
    Stack(children: <Widget>[
        
          Container(color: Theme.of(context).cardColor),
      
       Center(child: 
      ScalableWidget(
          Container(
              child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(15.0),
                    child: Center(
                        child: Hero(
                            tag: tag == null ?  _userProfile.id : _userProfile.id + tag.toString(),
                            child: CircularPicture(
                                _userProfile.image, 
                                Images.user,
                                150.0)))),

                /// User name
                Text(
                  _userProfile.userName ?? '',
                  style: Theme.of(context).textTheme.display4,
                ),

                 //MOTTO
                 
                  _userProfile.motto == null ? 
                  Container(width: 0, height: 0): 
                  Container(padding: EdgeInsets.all(20.0), 
                    child: Text(_userProfile.motto ?? '', style: Theme.of(context).textTheme.headline)
                  ),


                // Following button Logic
                isCurrentUser
                    ? Container(width: 0, height: 0)
                    : FollowButton(_userProfile.id),

                Counts(_userProfile),

              ],
            )
             
          )
        )
        )
      ],
    
  ); 
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
      margin: EdgeInsets.all(10.0),
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

                Padding(padding: EdgeInsets.all(10.0),),

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

              Padding(padding: EdgeInsets.all(10.0),),

              Icon(Icons.people_outline),

              Padding(padding: EdgeInsets.all(10.0),),

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
