
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/strings.dart';
import '../widgets/custom_widgets.dart';
import 'sign_up.dart';
import '../theme/appColors.dart';
import 'data.dart';
import '../data/profile.dart';
import 'feed.dart';
import 'user_profile.dart';
import '../database_functions.dart';


class OverviewPage extends StatefulWidget{
 @override
  OverviewPageState createState() => new OverviewPageState();
}

class OverviewPageState extends State<OverviewPage> with SingleTickerProviderStateMixin{

TabController controller;
TabViewDataArray _tabViews;

@override
void initState() { 
  super.initState();
  _tabViews = TabViewDataArray();
  controller = new TabController(vsync: this, length: _tabViews.ref.length);

}

@override
void dispose(){
controller.dispose();
super.dispose();
}

//
/// UI Build
///
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       
      /// 
      /// App bar 
      ///
      appBar: AppBar(title: Text(StringLabels.overview, style: TextStyle( fontWeight: FontWeight.w700),), automaticallyImplyLeading: false,
      leading: RawMaterialButton( onPressed: () =>  DatabaseFunctions.logOut((){Navigator.pop(context);}) , 
      child: Icon(Icons.exit_to_app),), 
      actions: <Widget>[ 
        RawMaterialButton( onPressed: () => Navigator.pop(context), child: Icon(Icons.menu))  ], ),
    

      body: TabBarView(
        controller: controller,
        children: <Widget>[
          _tabViews.ref[0].screen,
          _tabViews.ref[1].screen,
          _tabViews.ref[2].screen, 
                 ],
      ),
    
     bottomNavigationBar: Material(child: 
     Material( color: AppColors.getColor(ColorType.toolBar), child:
     TabBar(
        labelPadding: EdgeInsets.all(0.0),
        indicatorPadding: EdgeInsets.all(0.0),
        controller: controller,
        tabs: <Widget>[    
          _tabViews.ref[0].tab,
          _tabViews.ref[1].tab,
          _tabViews.ref[2].tab,
        ],),),
      )
      );
    }
}


class TabViewDataArray{

  List<TabViewData> ref;

 TabViewDataArray(){ 
   
    this.ref = [

    TabViewData(FeedPage(), Tab(icon: Icon(Icons.public), text: "Feed")),
   
    TabViewData(DataPage(),Tab(icon: Icon(Icons.list), text: "Data"),),

    TabViewData(UserProfilePage(),Tab(icon: Icon(Icons.portrait), text: "User"),),
    ];
 }
}