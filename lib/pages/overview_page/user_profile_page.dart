import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/data/mini_classes.dart';

class UserProfilePage extends StatelessWidget{

  final UserProfile _userProfile;

  UserProfilePage(this._userProfile);

  /// UI Build
  @override
  Widget build(BuildContext context) {
    return Container(child: 

    new Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center ,children:[

      Container(padding: EdgeInsets.all(10.0), margin: EdgeInsets.all(10.0),
              child: Center(child: Hero(tag: _userProfile.userId ,
                  child: CircularPicture(
                      _userProfile.userImage, 150.0)))),

      /// User name
      Text(_userProfile.userName, style: Theme.of(context).textTheme.display3,),

      ///Spacer
      Container(height: 20.0,),

      Container(margin: EdgeInsets.all(20.0) , child:
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        /// Brew count
        FutureBuilder(future: _userProfile.getRecipeCount(),initialData: '' ,builder: (context, snapshot) =>
        CountBlock(
            snapshot.data.toString(),
            StringLabels.brewCount,
        )),

        /// Bean Stash
        FutureBuilder(future: _userProfile.getcoffeeCount(),initialData: '' ,builder: (context, snapshot) =>
        CountBlock(
            snapshot.data.toString(),
            StringLabels.brewCount,
        )),

        /// Followers
        FutureBuilder(future: _userProfile.getRecipeCount(),initialData: '' ,builder: (context, snapshot) =>
        CountBlock(
            snapshot.data.toString(),
            StringLabels.brewCount,
        )),
      ],
      ),),
      ]
    ,)
    );
    
  }
}


class CountBlock extends StatelessWidget {

  final String _count;
  final String _label;

  CountBlock(this._count,this._label);

  @override
  Widget build(BuildContext context) {
    return 
    FittedBox(fit: BoxFit.fitWidth ,
      child: Column(children: <Widget>[
            CountLabel(_count),
            Text(_label)
        ],),
     );
  }
}

