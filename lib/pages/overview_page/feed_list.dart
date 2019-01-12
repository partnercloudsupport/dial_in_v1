import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:dial_in_v1/routes.dart';
import 'package:dial_in_v1/pages/overview_page/user_profile_page.dart';
import 'package:dial_in_v1/data/strings.dart';



class FeedList extends StatefulWidget{

 final FeedType _feedType;

 FeedList(this._feedType);

 _FeedListState createState() => new _FeedListState();
}


class _FeedListState extends State<FeedList>{
  
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

  void _dealWithProfileSelection(FeedProfileData userProfile){

      Navigator.push(context, SlowerRoute((BuildContext context) =>
      ProfilePage(isFromUserFeed: true ,isOldProfile: false, isCopying: false, isEditing: false, isNew: false, type: userProfile.profile.type, referance: userProfile.userName, profile: userProfile.profile)));
  }

  Widget setupWidgetView(SnapShotDataState dataState , AsyncSnapshot<List<FeedProfileData>> snapshot, FeedType feedType){

    Widget _returnWidget;

    switch(dataState){
      case SnapShotDataState.waiting: 
        _returnWidget = Stack(children: <Widget>[ 
                Center(child:
                  Column
                  (mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
                    
                    CircularProgressIndicator(),
                    Container(margin: EdgeInsets.all(20.0),child: Text('Loading...'),) ,],)),
                    FeedRefresher(ListView(children: <Widget>[],),feedType)
            ],);
        break;

      case SnapShotDataState.noData:
        _returnWidget =  Stack(children: <Widget>[ 
                Center(child:
                  Column
                  (mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
                    Container(child: Icon(Icons.no_sim),),
                    Container(margin: EdgeInsets.all(20.0),child: Text('No Data',style: Theme.of(context).textTheme.display3,),) ,],)),
                    FeedRefresher(ListView(children: <Widget>[],),feedType )
                  ],);
        break;


      case SnapShotDataState.hasdata:

      if (snapshot.data.length < 1 ){

         _returnWidget = 
          Stack(children: <Widget>[ 
            Center(child:
              Column
              (mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
                Container(child: Icon(Icons.no_sim),),
                Container(margin: EdgeInsets.all(20.0),child: Text('No Data',style: Theme.of(context).textTheme.display3,),) ,],)),
                FeedRefresher(ListView(children: <Widget>[],),feedType)
          ],);
        
      }else{
      
        Iterable<FeedProfileData> _reversedList = snapshot.data.reversed;
                    List<FeedProfileData> _list = new List<FeedProfileData>();
                     _reversedList.forEach((x){_list.add(x);});
  
        _returnWidget = 
        
        FeedRefresher(
          ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) =>
            SocialProfileCard(snapshot.data[index], _dealWithProfileSelection, _handleUserSelection, index)
            ),feedType 
            );
      }
      break;


      case SnapShotDataState.hasError:
        _returnWidget =  Stack(children: <Widget>[ 
                Center(child:
                  Column
                  (mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
                    Container(child: Icon(Icons.warning),),
                    Container(margin: EdgeInsets.all(20.0),child: Text('Error',style: Theme.of(context).textTheme.display3,),) ,],)),
                    FeedRefresher(ListView(children: <Widget>[],),feedType)
                  ],);
        break;
    }   

    return _returnWidget ?? Stack(children: <Widget>[ 
                                  Center(child:
                                    Column
                                    (mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
                                      Container(child: Icon(Icons.warning),),
                                      Container(margin: EdgeInsets.all(20.0),child: Text('Error',style: Theme.of(context).textTheme.display3,),) ,],)),
                                      FeedRefresher(ListView(children: <Widget>[],),feedType)
                                    ],);
  }

  Widget view;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProfilesModel>
      (builder: (context, _ ,model) =>

        ///Todo Starts building this before User profile is gotton
        StreamBuilder<List<FeedProfileData>>(
          stream: widget._feedType == FeedType.community ? model.communnityFeed : model.followingFeed,
          builder: (BuildContext context,AsyncSnapshot<List<FeedProfileData>> snapshot) {

            switch (snapshot.hasError) {
              case true: return setupWidgetView(SnapShotDataState.hasError, snapshot, widget._feedType);
              case false:

              switch (snapshot.hasData) {
                case false: 
                  switch(snapshot.connectionState){
                    case ConnectionState.none: break;
                    case ConnectionState.active: return setupWidgetView(SnapShotDataState.noData, snapshot, widget._feedType);
                    case ConnectionState.waiting: return setupWidgetView(SnapShotDataState.waiting, snapshot, widget._feedType);
                    case ConnectionState.done: break;
                  }     
                  break;       

                case true: return setupWidgetView(SnapShotDataState.hasdata, snapshot, widget._feedType); 
                  
                default:
              }
          }
        }
      )
    );
  }
}



