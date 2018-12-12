import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/profile.dart';
import '../profile_pages/profile_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';


class FeedList extends StatefulWidget{

 final bool _public;
 final Function(Profile) _giveProfile;
 final bool _isOnOverviewScreen;
 List <Widget> _profileCards;

 FeedList(this._public, this._giveProfile, this._isOnOverviewScreen, this._profileCards);

 _FeedListState createState() => new _FeedListState();
}


class _FeedListState extends State<FeedList>{

  Function(Profile) _giveProfile;
  bool _public;
  bool _isOnOverviewScreen;
  List <Widget> _profileCards;

    @override
    initState(){
    _giveProfile = widget._giveProfile; 
    _public = widget._public;
    _isOnOverviewScreen = widget._isOnOverviewScreen;
    _profileCards = widget._profileCards;
    super.initState();
   }

   void _dealWithProfileSelection(Profile profile){

     if (_isOnOverviewScreen){
       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
        ProfilePage(isOldProfile: true, isCopying: false, isEditing: true, isNew: false, type: profile.type, referance: profile.objectId, profile: profile)));

     }else{
       _giveProfile(profile);
       Navigator.pop(context);
     }
   }

@override
    Widget build(BuildContext context) {
return ScopedModelDescendant<ProfilesModel>
      (builder: (context, _ ,model) =>

        StreamBuilder(
          stream: model.profiles,
          initialData: model.profiles,
          builder: (context, snapshot) {

             if (!snapshot.hasData) { return const Center(child: Text('Loading'));
             } else if (snapshot.hasError) { return const Center(child: Text('Error'));  
             } else if (snapshot.data.documents.length < 1) {return const Center(child: Text('No data'));
             } else {

              return new 
                ListView.builder(
                    itemExtent: 100,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ProfileCard(snapshot.data[index], _dealWithProfileSelection)
                );
            }
          }
        )
      );
    }
}
                                 