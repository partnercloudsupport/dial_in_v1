import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:scoped_model/scoped_model.dart';

class UserProfilePage extends StatefulWidget{
 @override
  UserProfileState createState() => new UserProfileState();
}

class UserProfileState extends State<UserProfilePage>{

/// UI Build
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProfilesModel>
      (builder: (context, _ ,model) =>
    new Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center ,children:[

      Container(
              child: Center(
                  child: CircularPicture(
                      ProfilesModel.of(context).userImage, 100.0))),
      Text(ProfilesModel.of(context).userName),
      Text(model.userName),

      Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        CountBlock(
            model.recipeProfilesCount.toString(),
            StringLabels.brewCount,
        ),

        CountBlock(
            model.recipeProfilesCount.toString(),
            StringLabels.beanStash,
        ),

        CountBlock(
            model.recipeProfilesCount.toString(),
            StringLabels.followers,
        ),
      ],
      )
      ]
    )
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
    Container(
      child: Column(children: <Widget>[
            CountLabel(_count),
            Text(_label),
        ],),
     );
  }
}