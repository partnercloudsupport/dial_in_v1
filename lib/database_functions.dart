import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/data/item.dart';
import 'package:dial_in_v1/data/images.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:dial_in_v1/data/strings.dart';


class DatabaseFunctions {

  ///Login
  static Future<void> logIn(String emailUser, String password,Function(bool, String) completion) async {
          // try {
          //   FirebaseUser user = await FirebaseAuth.instance
          //       .signInWithEmailAndPassword(email: emailUser, password: password);
          //   completion(true, StringLabels.loggedIn);
          // } catch (e) {
          //   completion(false, e);
          // }
  }

  /// SignUp
  static Future<void> signUp(String userName, String emailUser, String password, Function(bool, String) completion) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailUser, password: password);
      completion(true, StringLabels.signedYouUp);
    } catch (e) {
      completion(true, e.message);
    }
  }

  /// Logout
  static Future <void> logOut(Function signOutView)  async{
    signOutView();
    // await FirebaseAuth.instance.signOut();
    print('Logged out');
  }

  /// Get User Image
  static Future <String> getUserImage()async{

    String result = '';
    String userId = await getCurrentUserId();

    DocumentSnapshot document = await Firestore.instance.collection(DatabaseIds.User).document(userId).get();

    if(document != null){
    for(var doc in document.data.entries){  /// <<<<==== changed line
                  
                  if(doc.key == DatabaseIds.objectId){
                    result = doc.value;
                  } 
      }
    }
   return result;
  }

  /// Get User Name
  static Future <String> getUserName()async{

    String result = '';
    String userId = await getCurrentUserId();

    DocumentSnapshot document = await Firestore.instance.collection(DatabaseIds.User).document(userId).get();
      if(document != null){
        for(var doc in document.data.entries){  /// <<<<==== changed line
                      
                      if(doc.key == DatabaseIds.name){
                        result = doc.value;
                      } 
          }
      }
      return result;
        
  }
  
  // Get current User from firebase
  static Future<String> getCurrentUserId()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print('Current user ${user.uid}');
    return user.uid.toString();
  }

  /// Dowload file from Firebase
  static Future<File> downloadFile(String httpPath)async{

    final RegExp regExpPng = RegExp('([^?/]*\.(png))');    
    final RegExp regExpjpg = RegExp('([^?/]*\.(jpg))');
    String fileName;

    if (httpPath.contains(RegExp('png'))){fileName = regExpPng.stringMatch(httpPath);}
    else if (httpPath.contains(RegExp('jpg'))){fileName = regExpjpg.stringMatch(httpPath);}
    else {throw('No matching file type') ;}

    final Directory tempDir = Directory.systemTemp;

    try {
    final File file = File('${tempDir.path}/$fileName');
    final StorageReference firebaseStorageReferance = FirebaseStorage.instance.ref().child(fileName);
    final StorageFileDownloadTask downloadTask = firebaseStorageReferance.writeToFile(file);
    
    await downloadTask.future;
    return file;

     } catch (e){
       return Functions.getFile(Images.recipeSmaller);
     }
}

  /// Update document with referance
  static Future<void> updateProfile(Profile profile)async{

    Map <String, dynamic> _documentProperties = await prepareProfileForFirebaseUpload(profile);

    Firestore.instance.collection(profile.databaseId).document(profile.objectId).updateData(_documentProperties)
    .whenComplete((){print('Successfully updated ${profile.objectId}');}).catchError((error){print(error);});
    
  }
   
  /// Upload file to Firebase
  static Future<String> upLoadFileReturnUrl(File file, {String folder, String subFolder, String subSubFolder})async{
    
   StorageReference ref;
    if(subFolder == null || folder == null || subSubFolder == null){
       ref = FirebaseStorage.instance.ref().child(path.basename(file.path));
    }else
    if(subFolder == null || folder == null){
       ref = FirebaseStorage.instance.ref().child(path.basename(file.path));
    }else if(folder ==  null){
       ref = FirebaseStorage.instance.ref().child(subFolder).child(path.basename(file.path));
    }else if(subFolder ==  null){
       ref = FirebaseStorage.instance.ref().child(folder).child(path.basename(file.path));
    }else if(subFolder != null || folder != null){
        ref = FirebaseStorage.instance.ref().child(folder).child(subFolder).child(path.basename(file.path));
    }else{   
       ref = FirebaseStorage.instance.ref().child(path.basename(file.path));
    }

    final StorageUploadTask uploadTask = ref.putFile(file);
    return await (await uploadTask.onComplete).ref.getDownloadURL().catchError((error){print(error);});
  }

  /// Delete Firebase Storage Item
  static void deleteFireBaseStorageItem(String fileUrl){
        // Create a reference to the file to delete
      StorageReference desertRef = FirebaseStorage.instance.ref().child(fileUrl);

      // Delete the file
      desertRef.delete()
      .then((_) {})
      .catchError((e){print(e);});
  }

  /// Prepare Profile for FirebaseUpload or Update
  static Future<Map <String, dynamic>> prepareProfileForFirebaseUpload(Profile profile)async{


    Map <String, dynamic> _properties = new Map <String, dynamic>();

     for (var i = 0; i < profile.properties.length; i++) {_properties[profile.properties[i].databaseId] = profile.properties[i].value;}

    String userId = await DatabaseFunctions.getCurrentUserId();

        _properties[DatabaseIds.image] = profile.image;
        _properties[DatabaseIds.orderNumber] = profile.orderNumber;
        _properties[DatabaseIds.user] = userId;
        _properties[DatabaseIds.public] = profile.isPublic;
      
      if (profile.type == ProfileType.recipe){
        _properties[DatabaseIds.coffeeId] = profile.getProfileProfileRefernace(profileDatabaseId: DatabaseIds.coffee);
        _properties[DatabaseIds.waterID] = profile.getProfileProfileRefernace(profileDatabaseId: DatabaseIds.water);
        _properties[DatabaseIds.grinderId] = profile.getProfileProfileRefernace(profileDatabaseId: DatabaseIds.grinder);
        _properties[DatabaseIds.barista] = profile.getProfileProfileRefernace(profileDatabaseId: DatabaseIds.Barista);
        _properties[DatabaseIds.equipmentId] = profile.getProfileProfileRefernace(profileDatabaseId: DatabaseIds.brewingEquipment);}

    return _properties;
}

  /// Delete profile 
  static Future<void> deleteProfile(Profile profile)async{
    DatabaseFunctions.deleteFireBaseStorageItem(profile.image);
    Firestore.instance.collection(profile.databaseId).document(profile.objectId)
        .delete()
        .whenComplete((){print('Successfully deleted ${profile.objectId}');})
        .catchError((e){print(e);});
  }

  /// Save profile 
  static Future<Profile> saveProfile(Profile profile)async{

    Map <String, dynamic> _properties = new Map <String, dynamic>();

     for (var i = 0; i < profile.properties.length; i++) {
          
        _properties[profile.properties[i].databaseId] = profile.properties[i].value;
      
      }

    String userId = await DatabaseFunctions.getCurrentUserId();

        _properties[DatabaseIds.image] = profile.image;
        _properties[DatabaseIds.orderNumber] = profile.orderNumber;
        _properties[DatabaseIds.user] = userId;
        _properties[DatabaseIds.public] = profile.isPublic;
      
      if (profile.type == ProfileType.recipe){
        _properties[DatabaseIds.coffeeId] = profile.getProfileProfileRefernace(profileDatabaseId: DatabaseIds.coffee);
        _properties[DatabaseIds.waterID] = profile.getProfileProfileRefernace(profileDatabaseId: DatabaseIds.water);
        _properties[DatabaseIds.grinderId] = profile.getProfileProfileRefernace(profileDatabaseId: DatabaseIds.grinder);
        _properties[DatabaseIds.barista] = profile.getProfileProfileRefernace(profileDatabaseId: DatabaseIds.Barista);
        _properties[DatabaseIds.equipmentId] = profile.getProfileProfileRefernace(profileDatabaseId: DatabaseIds.brewingEquipment);}  
 
      DocumentReference documentReference = await Firestore.instance.collection(profile.databaseId).add(_properties).catchError((error){print(error);});

      final String docId = documentReference.documentID; 

      profile.objectId =  docId;

      return profile;
  }

  /// Get Image from assets
  static void getImageFromAssets(String id, Function completion(Image image)){
    Image pic = Image.asset(id);
    completion(pic);
  } 

  /// Get profiles from fore store with doc referance
  static Future<Profile> getProfileFromFireStoreWithDocRef(String collectionDataBaseId, String docRefernace)async{
    
    Profile _profile;

    if (docRefernace != ''){

    DocumentSnapshot doc = await Firestore.instance.collection(collectionDataBaseId).document(docRefernace).get();
    
    if (doc.exists) {
          _profile = await DatabaseFunctions.createProfileFromDocumentSnapshot(collectionDataBaseId, doc);
      } else {
          _profile = await Functions.createBlankProfile(ProfileType.barista);
      }
    }else{_profile =  await Functions.createBlankProfile(Functions.getProfileDatabaseIdType(collectionDataBaseId));}
    return _profile;
  }

  /// Get value from collection with key
  static Future<dynamic> getValueFromFireStoreWithDocRef(String collectionDataBaseId, String docRefernace, String key)async{
    
    dynamic _value;

    if (docRefernace != ''){

    DocumentSnapshot doc = await Firestore.instance.collection(collectionDataBaseId).document(docRefernace).get();
    
    if (doc.exists) {
          _value = doc.data[key];
      } else {
          throw Error();
      }
    }else{ throw Error();}

    return _value;
  }

  /// Convert
  static List<Item> convertDocumentDataToProperties(DocumentSnapshot document){

  List<Item> _properties = new List<Item>();
  document.data.forEach((key, value) {

      if ( key != DatabaseIds.updatedAt){

      if ( key != DatabaseIds.objectId) {

      if ( key != DatabaseIds.databaseId){

      if ( key != DatabaseIds.databaseId){

      if ( key != DatabaseIds.orderNumber){

      if ( key != DatabaseIds.user){  

         Map<String, dynamic> item = {key: value};
        _properties.add(Functions.createItemWithData(item));
      }}}}
  }}});
  return _properties;
}

  /// Convert profiles from data snapshot
  static Future<List<Profile>> createProfilesFromDataSnapshot(String databaseId, List<DocumentSnapshot> data)async{

      List<Profile> documents = new List<Profile>();

       data.forEach((document){  createProfileFromDocumentSnapshot(databaseId, document).then(((profile){
         documents.add(profile);
       }));  });

    return documents;
  }

  /// Convert profile from document snapshot
  static Future<Profile> createProfileFromDocumentSnapshot(String databaseId, DocumentSnapshot document)async{
    
      DateTime _updatedAt = document[DatabaseIds.updatedAt];
      String _user = document[DatabaseIds.user];
      String _objectId = document.documentID;
      int _orderNumber = document[DatabaseIds.orderNumber];
      String _image = document[DatabaseIds.image];
      bool _ispublic = document.data[DatabaseIds.public];

      Profile _coffee;
      Profile _barista;
      Profile _equipment;
      Profile _grinder;
      Profile _water;

      if (document.data.containsKey(DatabaseIds.updatedAt)) { _updatedAt = document.data[DatabaseIds.updatedAt];} else {_updatedAt = DateTime.now();}
      if (document.data.containsKey(DatabaseIds.orderNumber)) { _orderNumber = document.data[DatabaseIds.orderNumber];} else {_orderNumber = 0;}

      if (databaseId == DatabaseIds.recipe){

      if (document.data.containsKey(DatabaseIds.coffeeId) && document.data[DatabaseIds.coffeeId] != ""){ 
        _coffee = await DatabaseFunctions.getProfileFromFireStoreWithDocRef(DatabaseIds.coffee , document.data[DatabaseIds.coffeeId]);}
        else{_coffee = await Functions.createBlankProfile(ProfileType.coffee);}

      if (document.data.containsKey(DatabaseIds.barista) && document.data[DatabaseIds.barista] != ""){
        _barista = await DatabaseFunctions.getProfileFromFireStoreWithDocRef(DatabaseIds.Barista, document.data[DatabaseIds.barista]);}
        else{_barista = await Functions.createBlankProfile(ProfileType.barista);}

      if (document.data.containsKey(DatabaseIds.equipmentId) && document.data[DatabaseIds.Barista] != ""){
        _equipment = await DatabaseFunctions.getProfileFromFireStoreWithDocRef(DatabaseIds.brewingEquipment, document.data[DatabaseIds.equipmentId]);}
        else{_equipment = await Functions.createBlankProfile(ProfileType.equipment);}

      if (document.data.containsKey(DatabaseIds.grinderId) && document.data[DatabaseIds.grinderId] != ""){
        _grinder = await DatabaseFunctions.getProfileFromFireStoreWithDocRef(DatabaseIds.grinder, document.data[DatabaseIds.grinderId]);}
        else{_grinder = await Functions.createBlankProfile(ProfileType.grinder);}
      
      if (document.data.containsKey(DatabaseIds.waterID) && document.data[DatabaseIds.waterID] != ""){
        _water = await DatabaseFunctions.getProfileFromFireStoreWithDocRef(DatabaseIds.water, document.data[DatabaseIds.waterID]);}
        else{_water = await Functions.createBlankProfile(ProfileType.water);}
      }

      List<Item> _properties = new List<Item>();

        document.data.forEach((key, value) {

      if ( key != DatabaseIds.updatedAt){

      if ( key != DatabaseIds.orderNumber){

      if ( key != DatabaseIds.image){

      if ( key != DatabaseIds.public){

      if ( key != DatabaseIds.user){
  
         Map<String, dynamic> item = {key: value};
        _properties.add(Functions.createItemWithData(item));
      
     }}}}}}
    );

    switch(databaseId){

      case DatabaseIds.recipe: 

      return  new Profile(
              userId: _user,
              isPublic: _ispublic,
              updatedAt: _updatedAt,
              objectId: _objectId,
              type: ProfileType.recipe,
              image: _image,
              databaseId: databaseId,
              orderNumber: _orderNumber,
              properties: _properties,
              profiles:  [
                _coffee,
                _barista,
                _equipment,
                _grinder,
                _water,
              ]
              );
      break;

      case DatabaseIds.coffee:   
      return  new Profile(
              userId: _user,
              isPublic: _ispublic,
              updatedAt: _updatedAt,
              objectId: _objectId,
              type: ProfileType.coffee,
              image: _image,
              databaseId: databaseId,
              orderNumber: _orderNumber,
              properties: _properties
              );
      break;

      case DatabaseIds.grinder:   
      return  new Profile(
              userId: _user,
              isPublic: _ispublic,
              updatedAt: DateTime.now(),
              objectId: _objectId,
              type: ProfileType.grinder,
              image: _image,
              databaseId: databaseId,
              orderNumber: _orderNumber,
              properties: _properties
              );
      break;

      case DatabaseIds.brewingEquipment:   
      return  new Profile(
        userId: _user,
        isPublic: _ispublic,
        updatedAt: DateTime.now(),
        objectId: _objectId,
        type: ProfileType.equipment,
        image: _image,
        databaseId: databaseId,
        orderNumber: _orderNumber,
        properties: _properties
              );
      break;

      case DatabaseIds.water:   
      return  new Profile(
        userId: _user,
        isPublic: _ispublic,
        updatedAt: DateTime.now(),
        objectId: _objectId,
        type: ProfileType.water,
        image: _image,
        databaseId: databaseId,
        orderNumber: _orderNumber,
        properties: _properties
        );
      break;

      case DatabaseIds.Barista:   
      return  new Profile(
        userId: _user,
        isPublic: _ispublic,
        updatedAt: DateTime.now(),
        objectId: _objectId,
        type: ProfileType.barista,
        image: _image,
        databaseId: databaseId,
        orderNumber: _orderNumber,
        properties: _properties
        );
      break;

      default: 

      return  new Profile(
              userId: _user,
              isPublic: _ispublic,
              updatedAt: DateTime.now(),
              objectId: _objectId,
              type: ProfileType.barista,
              image: _image,
              databaseId: databaseId,
              orderNumber: 0,
              properties: _properties
              );
      break;
    }
  }
  
  /// Give user profile name and photo
  static Future<void> updateUserProfileWithNameAndPhoto(String displayName, String photoUrl,)async{

     var user = await FirebaseAuth.instance.currentUser();

     UserUpdateInfo info = new UserUpdateInfo();
     info.displayName = displayName;
     info.photoUrl = photoUrl;
     user.updateProfile(info)
     .then((a){
      // Update successful.
        print('Sucessfully updated $user');
    }).catchError((error) {
    // An error happened.
      print(error);
    });
  }

  /// Get feed
  static StreamBuilder getFeed(String _listDatabaseId, bool isProfileFeed ,Function(Profile)  _dealWithProfileSelection, Function(Profile) _deleteProfile){

    return StreamBuilder(
      stream: Firestore.instance.collection(_listDatabaseId).snapshots(),
      initialData: 10,
      builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none: return const Center(child: Text('No internet connection'));
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading'));
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error'));
                      } else if (snapshot.data.documents.length < 1) {
                        return const Center(child: Text('No data'));
                      } else {
                        return new Container(
                            height: 200.0,
                            width: 150.0,
                            child: new FutureBuilder(
                                future: isProfileFeed ? Functions.buildProfileCardArrayFromAsyncSnapshot(context, snapshot, _listDatabaseId, _dealWithProfileSelection, _deleteProfile):
                                Functions.buildFeedCardArray(context, snapshot, _dealWithProfileSelection),
                                builder: (BuildContext context, AsyncSnapshot futureSnapshot) {
                                  switch (futureSnapshot.connectionState) {
                                    case ConnectionState.none: return Text('Press button to start.');  
                                    case ConnectionState.active:
                                    case ConnectionState.waiting: return Center(child: Text(StringLabels.loading));                                     
                                    case ConnectionState.done:
                                      if (futureSnapshot.hasError){return Text('Error: ${futureSnapshot.error}');}
                                      else if (futureSnapshot.data == null){ return Center(child: Text(StringLabels.noData));}
                                      else{
                                      List<dynamic> list = futureSnapshot.data;
                                      List<dynamic> reversedlist = list.reversed.toList();
                                      return 
                                      ListView.builder(
                                          itemExtent: 100,
                                          itemCount: reversedlist.length,
                                          itemBuilder: (BuildContext context, int index) =>
                                              reversedlist[index]);}
                                  }
                                  return new Container(width: 0.0, height: 0.0,); // unreachable
                                }));
                      }
                  }
                }
      );
  }
}

class Storage {

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}

class DatabaseIds{

  static const String community = 'communtiy';
  static const String following = 'following';
  static const String roasterName = 'roasterName';
  static const String harvest = 'harvest';
  static const String feed = 'feed';
  static const String strength ='strength';
  static const String friends = 'friends';
  static const String public = 'public';
  static const String age = 'age';
  static const String viewContollerId = 'viewContollerId';
  static const String type = 'type';
  static const String databaseId = 'databaseId';
  static const String coreDataId = 'coreDataId';
  static const String updatedAt = 'updatedAt';
  static const String userName = 'userName';
  static const String email = 'email';
  static const String currentUser = 'currentUser';
  static const String password = 'password';
  static const String username = 'username';
  static const String objectId = 'objectId';
  static const String brewWeight = 'brewWeight';
  static const String Barista = 'Barista';
  static const String name = 'name';
  static const String data = 'data';
  static const String User = 'User';
  static const String altitude = 'altitude';
  static const String method = 'method';
  static const String density = 'density';
  static const String moisture = 'moistureContent';
  static const String aW = 'waterActivity';
  static const String notes = 'notes';
  static const String level = 'level';
  static const String barista = 'barista';
  static const String date = 'date';
  static const String totalScore = 'totalScore';
  static const String recipeId = 'recipeId';
  static const String tasteBalance = 'tasteBalance';
  static const String tactile = 'tactile';
  static const String sweet = 'sweet';
  static const String acidic = 'acidic';
  static const String flavour = 'flavour';
  static const String bitter = 'bitter';
  static const String weight = 'weight';
  static const String texture = 'texture';
  static const String finish = 'finish';
  static const String grindSetting = 'grindSetting';
  static const String descriptors = 'descriptors';
  static const String body = 'body';
  static const String balance = 'balance';
  static const String afterTaste = 'afterTaste';
  static const String water = 'Water';
  static const String brewingEquipment = 'BrewingEquipment';
  static const String coffee = 'Coffee';
  static const String grinder = 'Grinder';
  static const String creationDate = 'createdAt';
  static const String recipe = 'Recipe';
  static const String brewingDose = 'dose';
  static const String yielde = 'yield';
  static const String time = 'time';
  static const String temparature = 'temparature';
  static const String tds = 'tds';
  static const String score = 'score';
  static const String preinfusion = 'preInfusion';
  static const String coffeeId = 'coffeeID';
  static const String producer = 'producer';
  static const String lot = 'lot';
  static const String farm = 'farm';
  static const String region = 'region';
  static const String country = 'country';
  static const String beanType = 'beanType';
  static const String beanSize = 'beanSize';
  static const String roastProfile = 'roastProfile';
  static const String roastDate = 'roastDate';
  static const String processingMethod = 'processingMethod';
  static const String roasteryName = 'roasteryName';
  static const String grinderId = 'grinderId';
  static const String grinderMake = 'grinderMake';
  static const String grinderModel = 'grinderModel';
  static const String equipmentMake = 'equipmentMake';
  static const String equipmentModel = 'equipmentModel';
  static const String burrs = 'burrs';
  static const String testTemparature = 'testTemparature';
  static const String gh = 'gh';
  static const String kh = 'kh';
  static const String ppm = 'ppm';
  static const String ph = 'ph';
  static const String equipmentId = 'equipmentId';
  static const String equipmentType = 'equipmentType';
  static const String waterID = 'waterId';
  static const String user = 'user';
  static const String userImage = 'userPicture';
  static const String brewingEquipmentImage = 'brewingEquipmentImage';
  static const String coffeeImage = 'coffeeImage';
  static const String grinderImage = 'grinderImage';
  static const String recipeImage = 'recipeImage';
  static const String waterImage = 'waterImage';
  static const String picture = 'picture';
  static const String imagePath = 'imagePath';
  static const String image = 'image';
  static const String orderNumber = 'orderNumber';
}
