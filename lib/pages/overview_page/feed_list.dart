import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:dial_in_v1/routes.dart';
import 'package:dial_in_v1/pages/overview_page/user_profile_page.dart';
import 'package:dial_in_v1/data/strings.dart';

class FeedList extends StatefulWidget{

 final Function(Profile) _giveProfile;
 final bool _isOnOverviewScreen;

 FeedList(this._giveProfile, this._isOnOverviewScreen,);

 _FeedListState createState() => new _FeedListState();
}


class _FeedListState extends State<FeedList>{

  
  void _handleUserSelection(UserProfile userProfile){
   
      Navigator.push(context, SlowerRoute((BuildContext context) =>

      Scaffold(
       
      /// App bar 
      appBar: AppBar
              (title: Text
              (StringLabels.userProfile, style: 
                TextStyle( fontWeight: FontWeight.w700,),textAlign: TextAlign.center,),
               automaticallyImplyLeading: false,
      leading: FlatButton( onPressed: () {Navigator.pop(context);}, 
      child: Icon(Icons.arrow_back),), 
      actions: <Widget>[ 
        RawMaterialButton( onPressed: () { },
         child: Text(StringLabels.follow))  ], ),
    
      body: UserProfilePage(userProfile, false))));

  }

  void _dealWithProfileSelection(Profile profile){

    if (widget._isOnOverviewScreen){
      Navigator.push(context, SlowerRoute((BuildContext context) =>
      ProfilePage(isOldProfile: true, isCopying: false, isEditing: true, isNew: false, type: profile.type, referance: profile.objectId, profile: profile)));

    }else{
      widget._giveProfile(profile);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProfilesModel>
      (builder: (context, _ ,model) =>

        StreamBuilder<List<FeedProfileData>>(
          stream:  model.communnityFeed,
          builder: (context, snapshot) {

            if (!snapshot.hasData) { return  
            Center(child:
              Column
              (mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[CircularProgressIndicator(),
              Container(margin: EdgeInsets.all(20.0),child: Text('Loading...'),) ,],));

            } else if (snapshot.hasError) { return const Center(child: Text('Error'));  
            } else if (snapshot.data.length < 1) {return const Center(child: Text('No data'));
            } else {
                  Iterable<FeedProfileData> _reversedList = snapshot.data.reversed;
                  List<FeedProfileData> _list = new List<FeedProfileData>();
                   _reversedList.forEach((x){_list.add(x);});
                  return new 
                    ListView.builder(
                    itemExtent: 450,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) =>
                        SocialProfileCard(snapshot.data[index], _dealWithProfileSelection, _handleUserSelection)
                );
              }
          }
      )
    );
  }
}