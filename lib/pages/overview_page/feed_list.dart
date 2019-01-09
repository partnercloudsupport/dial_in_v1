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
import "package:pull_to_refresh/pull_to_refresh.dart";


class FeedList extends StatefulWidget{

 final FeedType _feedType;

 FeedList(this._feedType);

 _FeedListState createState() => new _FeedListState();
}


class _FeedListState extends State<FeedList>{

  RefreshController _refreshController = new RefreshController();
  
  void _handleUserSelection(UserProfile userProfile, int tag){
   
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
      ),
    
      body: UserProfilePage(userProfile, false, tag: tag)
      )
    )
    );

  }

  void _onRefresh(bool up, ProfilesModel model)async{
		if(up){
		   //headerIndicator callback
		   model.socialFeed(widget._feedType); 
       new Future.delayed(const Duration(seconds: 2))
                               .then((val) {
                                 _refreshController.sendBack(true, RefreshStatus.completed);
                           }); 
		}
		else{
			//footerIndicator Callback
		}
  }

  void _dealWithProfileSelection(FeedProfileData userProfile){

      Navigator.push(context, SlowerRoute((BuildContext context) =>
      ProfilePage(isFromUserFeed: true ,isOldProfile: false, isCopying: false, isEditing: false, isNew: false, type: userProfile.profile.type, referance: userProfile.userName, profile: userProfile.profile)));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProfilesModel>
      (builder: (context, _ ,model) =>
          ///Todo Starts building this before User profile is gotton
        StreamBuilder<List<FeedProfileData>>(
          stream: widget._feedType == FeedType.community ? model.communnityFeed : model.followingFeed,
          builder: (context, snapshot) {

            if (!snapshot.hasData || snapshot.data.length < 1) { return 
            Stack(children: <Widget>[ 
            Center(child:
              Column
              (mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[CircularProgressIndicator(),
                 Container(margin: EdgeInsets.all(20.0),child: Text('Loading...'),) ,],)),
                 
            SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                     enablePullUp: true,

                    onRefresh: (up) => _onRefresh(up, model),
                    child: 
                      ListView(children: <Widget>[],))
                 
            ],);

            } else if (snapshot.hasError) { return const Center(child: Text('Error'));  
           
            } else {
                  Iterable<FeedProfileData> _reversedList = snapshot.data.reversed;
                  List<FeedProfileData> _list = new List<FeedProfileData>();
                   _reversedList.forEach((x){_list.add(x);});
                  return new 
                    SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    onRefresh: (up) => _onRefresh(up, model),
                    child: 
                      ListView.builder(
                      itemExtent: 450,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) =>
                      SocialProfileCard(snapshot.data[index], _dealWithProfileSelection, _handleUserSelection, index)
                ));
              }
          }
      )
    );
  }
}