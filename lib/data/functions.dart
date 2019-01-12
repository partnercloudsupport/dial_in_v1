import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page.dart';
import 'dart:math' as math;
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as Image;
import 'dart:io' as Io;
import 'package:dial_in_v1/data/mini_classes.dart';


class Functions {

   static int getIntValue(dynamic item){

    int value;
    
    if (item == null){value = 0;}
    else if (item is String && item == ''){value = 0;}
    else if (item is String && item != '')
    { double trans = double.parse(item);
      value = trans.toInt();}
    else if (item is double){value = item.round().toInt();}
    else if (item is !int || item is !double){value = 0;}
    else{value = item.value;}

    return value;
   }

  static String convertSecsToMinsAndSec(int timeInput){
        
        int timeSecs = timeInput;
        
        int minutes = (timeSecs / 60).floor();
        int seconds = timeSecs % 60;
            
        return "$minutes minutes and $seconds seconds";
    }



    static String convertSecsmmss(int timeInput){
        
        int timeSecs = timeInput;
        String timeString;
        
        int minutes = (timeSecs / 60).floor();
        int seconds = timeSecs % 60;
        
        if (minutes < 10 && seconds < 10){
            
            timeString = "0$minutes:0$seconds";
            
        }else if (minutes < 10) {
            
            timeString = "0$minutes:$seconds";
            
        }else if (seconds < 10) {
            
            timeString = "$minutes:0$seconds";
            
            
        } else {
            
            timeString = "$minutes:$seconds";
            
        }
        return timeString;
    }
/// Get Numbers 0 to fifity nine
  static List<int> oneToFiftynine(){

    List<int> numbers = new List<int>();

    for (var i = 0; i < 59; i++) {
        numbers.add(i);
    }
    return numbers;
  }


  static String getTwoNumberRatio(int first, int second){

    List<int> newNumbers = getRatio([first,second]);

    return '${newNumbers[0]} : ${newNumbers[1]}';

  }

/// Get ratio
  static List<int> getRatio (List<int> numbers){

    List<int> numbersSorted = numbers;

    // numbersSorted.sort((a, b) => a.compareTo(b));

    List<List<int>> factorList = new List<List<int>>();

    /// Find factors for each number

    /// Find matching values
    for (var i = 0; i < numbersSorted.length; i++) {

      List<int> factors = new  List<int>();

      for (var x = 0 ; x <= numbersSorted[i]; x++) {

        if (numbersSorted[i].toDouble() % x.toDouble() == 0){factors.add(x);}
      }
      factors.add(numbersSorted[i]);
      factorList.add(factors);
    }

    List<int> commonFactors = new List<int>();

    /// Find matching values
    for (var i = 0; i < factorList.length - 1; i++) {

      for (var x = 0; x < factorList[i].length; x++){

       for (var y = 0; y < factorList[i + 1].length; y++){

          if(factorList[i][x] == factorList[i + 1][y]){

            if (i > 0){
              for (var z = 0; z < factorList[i - 1].length ; z++) {
                
                if(factorList[i][x] == factorList[i - 1][z]){

                  commonFactors.add(factorList[i][x]);

                }
              }
            }else{
                  commonFactors.add(factorList[i][x]);
            }
         }
       }
      }
    }

    if (commonFactors.length > 0){
      
      int highestDemoniator = commonFactors.reduce((current, next){

        if (current > next){return current;}
        else{ return next; }

      });

    if (highestDemoniator > 0){

      List<int> newNumbers =  new List<int>();

     for (var x = 0; x < numbersSorted.length; x++){

       int number = numbersSorted[x] ~/ highestDemoniator;
       newNumbers.add(number);

      }
      return newNumbers;}
      else{  return numbersSorted; }
    }

    else{ return numbersSorted;}
     
  }  

  static File fileToPng(File file){
  // decodeImage will identify the format of the image and use the appropriate
  // decoder.
  Image.Image image = Image.decodeImage(file.readAsBytesSync());

  // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
  Image.Image thumbnail = Image.copyResize(image, 120);
  final String filename = '${math.Random().nextInt(10000)}.png';
  // Save the thumbnail as a PNG.
  File returnFile =new Io.File(filename) ..writeAsBytesSync(Image.encodePng(thumbnail));

  return returnFile;      
}

  static File fileToJpg(File file){
  // decodeImage will identify the format of the image and use the appropriate
  // decoder.
  Image.Image image = Image.decodeImage(file.readAsBytesSync());

  // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
  Image.Image thumbnail = Image.copyResize(image, 120);
  final String filename = '${math.Random().nextInt(10000)}.jpg';
  // Save the thumbnail as a PNG.
  File returnFile =new Io.File(filename) ..writeAsBytesSync(Image.encodeJpg(thumbnail));

  return returnFile;      
 } 

  static Future getimageFromCameraOrGallery(BuildContext context, Function(String) then)async{
    String url = '';

    await showDialog(context: context, builder: (BuildContext context){
      return Center(child: Container( width:200, child:
      
       CupertinoActionSheet(actions: <Widget>[

      new CupertinoDialogAction(
          child: Text(StringLabels.camera, style: Theme.of(context).textTheme.display1),
          isDestructiveAction: false,
          onPressed: ()async{ 
            File image = await ImagePicker.pickImage
                              (maxWidth: 640.0, maxHeight: 480.0, source: ImageSource.camera);
            url = await DatabaseFunctions.upLoadFileReturnUrl(image, [DatabaseIds.image]);
            Navigator.of(context);
            Navigator.of(context).pop(then(url));
            Navigator.of(context).pop(then(url));
          }
      ),
    
      new  CupertinoDialogAction(
          child: Text(StringLabels.camera, style: Theme.of(context).textTheme.display1),
          isDestructiveAction: false,
          onPressed: ()async{ 
            File image = await ImagePicker.pickImage
                              (maxWidth: 640.0, maxHeight: 480.0, source: ImageSource.gallery);
            url = await DatabaseFunctions.upLoadFileReturnUrl(image, [DatabaseIds.image]);
            Navigator.of(context);
            Navigator.of(context).pop(then(url));
            Navigator.of(context).pop(then(url));
          }
      ),
    ],)));
    }
    );
    return url;
  }
  
  static Future<File> getPictureFile(String filePath) async {
    // get the path to the document directory.
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = appDocDir.path;
    return new File('/Users/earyzhe/Dropbox/dev/FlutterProjects/dial_in_v1/$filePath');
  }

  static Future<File> getFile(String filepath)async{
    final ByteData bytes = await rootBundle.load(filepath);
    final Directory tempDir = Directory.systemTemp;
    final String filename = '${math.Random().nextInt(10000)}.png';
    final File file = File('${tempDir.path}/$filename');
    file.writeAsBytes(bytes.buffer.asUint8List(), mode: FileMode.write);
    return file;
  }

  static String getRandomNumber(){
    var rng = new math.Random();
    var code = rng.nextInt(900000) + 100000;
    return code.toString();
  }

  static Profile setProfileItemValue({Profile profile, String keyDatabaseId, dynamic value}) {
    for (var i = 0; i < profile.properties.length; i++) {
      if (profile.properties[i].databaseId == keyDatabaseId) {
        profile.properties[i].value = value;
      }
    }
    return profile;
  }

  static String getProfileTypeString(ProfileType type) {

    switch (type) {

      case ProfileType.recipe:
        return StringLabels.recipe;
        break;

      case ProfileType.coffee:
        return StringLabels.coffee;
        break;

      case ProfileType.water:
        return StringLabels.water;
        break;

      case ProfileType.equipment:
        return StringLabels.method;
        break;

      case ProfileType.grinder:
        return StringLabels.grinder;
        break;

      case ProfileType.barista:
        return StringLabels.barista;
        break;

      case ProfileType.none:
        return StringLabels.none;
        break;

      case ProfileType.feed:
        return StringLabels.feed;
        break;

      default:
        return StringLabels.error;
        break;
    }
  }

  static String getProfileTypeDatabaseId(ProfileType type) {

    switch (type) {

      case ProfileType.recipe:
        return DatabaseIds.recipe;
        break;

      case ProfileType.coffee:
        return DatabaseIds.coffee;
        break;

      case ProfileType.water:
        return DatabaseIds.water;
        break;

      case ProfileType.equipment:
        return DatabaseIds.method;
        break;

      case ProfileType.grinder:
        return DatabaseIds.grinder;
        break;

      case ProfileType.barista:
        return DatabaseIds.Barista;
        break;

      default:
        return StringLabels.feed;
        break;
    }
  }

  static ProfileType getProfileDatabaseIdType(String type) {
    switch (type) {
      case DatabaseIds.recipe:
        return ProfileType.recipe;
        break;

      case DatabaseIds.coffee:
        return ProfileType.coffee;
        break;

      case DatabaseIds.water:
        return ProfileType.water;
        break;

      case DatabaseIds.brewingEquipment:
        return ProfileType.equipment;
        break;

      case DatabaseIds.grinder:
        return ProfileType.grinder;
        break;

      case DatabaseIds.Barista:
        return ProfileType.barista;
        break;

      default:
        return ProfileType.none;
        break;
    }
  }

  static String convertDatabaseIdToTitle(String databaseId) {
    switch (databaseId) {
      case DatabaseIds.recipe:
        return StringLabels.recipe;
        break;

      case DatabaseIds.coffee:
        return StringLabels.coffee;
        break;

      case DatabaseIds.water:
        return StringLabels.water;
        break;

      case DatabaseIds.brewingEquipment:
        return StringLabels.method;
        break;

      case DatabaseIds.grinder:
        return StringLabels.grinder;
        break;

      case DatabaseIds.Barista:
        return StringLabels.barista;
        break;

      case DatabaseIds.method:
        return StringLabels.method;
        break;

      default:
        return 'Error';
        break;
    }
  }

 
 
  static Future<List<Widget>> buildFeedCardArray(
     BuildContext context, AsyncSnapshot documents, Function(FeedProfileData) giveProfile, Function(UserProfile, int) _giveUserProfile, int index) async {

    List<Widget> _cardArray = new List<Widget>();

     if (documents.data.documents != null || documents.data.documents.length != 0) {

        for(var document in documents.data.documents){  /// <<<<==== changed line
            Widget result = await buildFeedCardFromDocument(context, document, giveProfile, _giveUserProfile, index);
            _cardArray.add(result);
        }
     }
      return _cardArray;
  }
  
  /// Create feed Profile from profile
  static Future<FeedProfileData> createFeedProfileFromProfile(Profile profile)async{

    UserProfile userProfile = await DatabaseFunctions.getUserProfileFromFireStoreWithDocRef(profile.userId);

    return FeedProfileData(profile, userProfile);
  }

      // Method that return count of the given 
    // character in the string 
  static int countChacters(String string, String c) 
    { 
        int res = 0; 
  
        for (int i=0; i< string.length; i++) 
        { 
            // checking character in string 
            if (string[i] == c) 
            res++; 
        }  
        return res; 
    } 


  static Future<Widget> buildFeedCardFromProfile
  (Profile profile, Function(FeedProfileData) giveprofile, Function(UserProfile, int) _giveUserProfile, int index) async {
    
    FeedProfileData feedProfile = await Functions.createFeedProfileFromProfile(profile);

    return SocialProfileCard(feedProfile, giveprofile, _giveUserProfile, index);
  }

  static Future<Widget> buildFeedCardFromDocument
  (BuildContext context, DocumentSnapshot document, Function(FeedProfileData) giveprofile, Function(UserProfile, int) _giveUserProfile, int index) async {
    
    Profile profile = await DatabaseFunctions.createProfileFromDocumentSnapshot(DatabaseIds.recipe, document);
    FeedProfileData feedProfile = await Functions.createFeedProfileFromProfile(profile);
    return SocialProfileCard(feedProfile, giveprofile, _giveUserProfile, index);
  }
  
  static Future<Widget> buildProfileCardFromDocument(DocumentSnapshot document, String databaseId, Function(Profile) giveprofile, Function(Profile, BuildContext) deleteProfile) async {
    
    Profile profile = await DatabaseFunctions.createProfileFromDocumentSnapshot(databaseId, document);

    return ProfileCard(profile, giveprofile, deleteProfile);
  }

  static Future<List<Widget>> buildProfileCardArrayFromAsyncSnapshot( BuildContext context, AsyncSnapshot<List<Widget>> snapshot, String databaseId, Function(Profile) giveProfile, Function(Profile) deleteProfile) async {
      
    List<Widget> _cardArray = new List<Widget>();

     if (snapshot.data != null || snapshot.data.length != 0) {

        for(var document in snapshot.data){  /// <<<<==== changed line        
            _cardArray.add(document);
        }
     }
      return _cardArray;
  }

  static Future<List<Widget>> buildProfileCardArrayFromProfileList(List<Profile> profileList, String databaseId, Function(Profile) giveProfile, Function(Profile, BuildContext) deleteProfile) async {

    List<Widget> _cardArray = new List<Widget>();

     if (profileList != null || profileList.length != 0) {

        for(var profile in profileList){  /// <<<<==== changed line
            Widget result = ProfileCard(profile, giveProfile, deleteProfile);
            _cardArray.add(result);
        }
     }
      return _cardArray;
    }

  static StreamBuilder createStreamProfileListView(BuildContext context, String profileTypeDatabaseId,  ProfilePageState parent ,Function(Profile) giveProfile, Function(Profile) deleteProfile){
    return StreamBuilder(
        stream:
        Firestore.instance.collection(profileTypeDatabaseId).snapshots(),
        initialData: 10,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return LinearProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading'));

              } else if (snapshot.hasError) {
                print(snapshot.error.toString());
                return  Center(child: Text('Error: ${snapshot.error}'));

              } else if (snapshot.data.documents.length < 1) {
                return const Center(child: Text('No data'));

              } else {
                return new Container(
                    height: 100.0,
                    width: 100.0,
                    child: new FutureBuilder(
                        future: Functions.buildProfileCardArrayFromAsyncSnapshot(context, snapshot.data, profileTypeDatabaseId, giveProfile, deleteProfile),
                        builder: (BuildContext context, AsyncSnapshot futureSnapshot) {

                          switch (futureSnapshot.connectionState) {

                            case ConnectionState.none:
                              return Text('Press button to start.');

                            case ConnectionState.active:

                            case ConnectionState.waiting:
                              return Center(child:Text('Loading...'));

                            case ConnectionState.done:
                              if (futureSnapshot.hasError)
                                return Text('Error: ${futureSnapshot.error}');

                              return ListView.builder(
                                  itemExtent: 80,
                                  itemCount: futureSnapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          futureSnapshot.data[index]);
                          }
                          return null; // unreachable
                        }));
              }
          }
        });
  }
}
