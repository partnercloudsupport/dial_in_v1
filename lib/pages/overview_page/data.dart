import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/theme/appColors.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/pages/overview_page/profile_list.dart';


/// Data page
class DataPage extends StatefulWidget {

  @override
  DataPageState createState() => new DataPageState();
}

class DataPageState extends State<DataPage>with SingleTickerProviderStateMixin {
  TabController controller;
  TabViewDataArray _lists;

  @override
  void initState() {
    _lists = TabViewDataArray([
      TabViewData(
        DataList(ProfileType.recipe,(profile){}, true),
        Tab(icon: Icon(Icons.list),),
        ProfileType.recipe
      ),
      TabViewData(
          DataList(ProfileType.coffee,(profile){}, true),
          Tab(icon: Icon(Icons.rounded_corner)),
          ProfileType.coffee
      ),
      TabViewData(
        DataList(ProfileType.grinder,(profile){}, true),
        Tab(icon: Icon(Icons.cloud_off)),
        ProfileType.grinder
      ),
      TabViewData(
        DataList( ProfileType.equipment,(profile){}, true),
        Tab(icon: Icon(Icons.watch_later)),
        ProfileType.equipment
      ),
      TabViewData(
        DataList( ProfileType.water,(profile){}, true),
        Tab(icon: Icon(Icons.branding_watermark)),
        ProfileType.water
      ),
      TabViewData(
        DataList( ProfileType.barista,(profile){}, true),
        Tab(icon: Icon(Icons.people)),
        ProfileType.barista
      ),
    ]);
    controller = new TabController(vsync: this, length: _lists.ref.length);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

//
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              child: Material(
                color: AppColors.getColor(ColorType.toolBar),
                child: TabBar(
                    indicatorPadding: EdgeInsets.all(0.0),
                    labelPadding: EdgeInsets.all(0.0),
                    controller: controller,
                    // isScrollable: true,
                    tabs: <Widget>[
                      _lists.ref[0].tab,
                      _lists.ref[1].tab,
                      _lists.ref[2].tab,
                      _lists.ref[3].tab,
                      _lists.ref[4].tab,
                      _lists.ref[5].tab,
                    ]),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: <Widget>[
                  _lists.ref[0].screen,
                  _lists.ref[1].screen,
                  _lists.ref[2].screen,
                  _lists.ref[3].screen,
                  _lists.ref[4].screen,
                  _lists.ref[5].screen,
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: AddButton(()async{

          Profile _profile = await Functions.createBlankProfile(_lists.ref[controller.index].type);

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>

          ProfilePage    
          (isOldProfile: false,
          isCopying: false,
          isEditing: true,
          isNew: true,
          type: _lists.ref[controller.index].type,
          referance: '',
          profile: _profile ,
          )));
        }));
  }
}

///Data list         
class DataList extends StatelessWidget {
  final ProfileType _profileType;
  final Function(Profile) _giveProfile;
  final bool _isOnOverviewScreen;

  DataList(this._profileType, this._giveProfile, this._isOnOverviewScreen);

  @override
  Widget build(BuildContext context) {
    return 
    Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch,children:[
          Material(color: Theme.of(context).primaryColorLight ,child: Container(padding: EdgeInsets.all(15.0),child: Text(Functions.getProfileTypeString(_profileType)+"'s", style: Theme.of(context).textTheme.subtitle,), alignment: Alignment.center,),),
          Expanded(child:ProfileList(_profileType, _giveProfile, _isOnOverviewScreen),)]);
          }
}
 