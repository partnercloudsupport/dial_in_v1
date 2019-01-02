import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/data/mini_classes.dart';



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

      StreamBuilder<UserProfile>(
          stream:  model.userProfile,
          builder: (context, snapshot) {

if (!snapshot.hasData) { return Center(child: CircularProgressIndicator(),);}else{ 
  
  return

    new Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center ,children:[

      Container(padding: EdgeInsets.all(10.0), margin: EdgeInsets.all(10.0),
              child: Center(
                  child: CircularPicture(
                      ProfilesModel.of(context).userImage, 150.0))),

      ///TODO: when values have not loaded it thorws an error make loading screen while loading                
      /// User name
      Text(model.userName, style: Theme.of(context).textTheme.display3,),

      ///Spacer
      Container(height: 20.0,),

      Container(margin: EdgeInsets.all(20.0) , child:
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        /// Brew count
        CountBlock(
            model.recipeProfilesCount.toString(),
            StringLabels.brewCount,
        ),

        /// Bean Stash
        CountBlock(
            model.coffeeProfilesCount.toString(),
            StringLabels.beanStash,
        ),

        /// Followers
        CountBlock(
            model.recipeProfilesCount.toString(),
            StringLabels.followers,
        ),
      ],
      ),),
      ]
    );
          }})
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