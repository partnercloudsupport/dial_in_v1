
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'data/profile.dart';
import 'data/functions.dart';
import 'data/item.dart';
import 'data/images.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class DatabaseFunctions {

  static Future<void> logIn(String emailUser, String password,Function(bool, String) completion) async {
          // try {
          //   FirebaseUser user = await FirebaseAuth.instance
          //       .signInWithEmailAndPassword(email: emailUser, password: password);
          //   completion(true, StringLabels.loggedIn);
          // } catch (e) {
          //   completion(false, e);
          // }
  }

  static Future<void> signUp(String emailUser, String password, Function(bool, String) completion) async {
    // try {
    //   FirebaseUser user = await FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(email: emailUser, password: password);
    //   completion(true, StringLabels.signedYouUp);
    // } catch (e) {
    //   print(e.message);
    // }
  }

  static Future <void> logOut(Function signOutView)  async{
    signOutView();
    // await FirebaseAuth.instance.signOut();
    print('Logged out');
  }

  static Future<String> getCurrentUserId()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    return user.uid.toString();
  }

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
    
    await downloadTask.future.then((totalByteCount){print ('Downloaded ${totalByteCount.totalByteCount.toInt()}');});
    return file;

     } catch (e){
       print('Error line 65 DB.func/DowloadFile${e}');
       return Functions.getFile(Images.recipeSmaller);
     }
}

/// Update document with referance
  static Future<void> updateProfile(Profile profile)async{

    Map <String, dynamic> _documentProperties = await prepareProfileForFirebaseUpload(profile);

    Firestore.instance.collection(profile.databaseId).document(profile.objectId).updateData(_documentProperties)
    .whenComplete((){print('Successfully updated ${profile.objectId}');}).catchError((error){print(error);});
    
  }
   
/// Upload file
  static Future<String> _upLoadFileReturnUrl(File file, String folder)async{
    
    final StorageReference ref = FirebaseStorage.instance.ref().child(path.basename(file.path));
    final StorageUploadTask uploadTask = ref.putFile(file);
    return await (await uploadTask.onComplete).ref.getDownloadURL().catchError((error){print(error);});

  }

/// Prepare Profile for FirebaseUpload or Update
  static Future<Map <String, dynamic>> prepareProfileForFirebaseUpload(Profile profile)async{

    String downloadUrl = await _upLoadFileReturnUrl(profile.image, profile.databaseId);

    Map <String, dynamic> _properties = new Map <String, dynamic>();

     for (var i = 0; i < profile.properties.length; i++) {_properties[profile.properties[i].databaseId] = profile.properties[i].value;}

    String userId = await DatabaseFunctions.getCurrentUserId();

        _properties[DatabaseIds.image] = downloadUrl;
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

/// Save profile 
  static Future<Profile> saveProfile(Profile profile)async{

    String downloadUrl = await _upLoadFileReturnUrl(profile.image, profile.databaseId);

    Map <String, dynamic> _properties = new Map <String, dynamic>();

     for (var i = 0; i < profile.properties.length; i++) {
          
        _properties[profile.properties[i].databaseId] = profile.properties[i].value;
      
      }
    String userId = await DatabaseFunctions.getCurrentUserId();

        _properties[DatabaseIds.image] = downloadUrl;
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

  static void getImage(String id, Function completion(Image image)){
    Image pic = Image.asset(id);
    completion(pic);
  } 

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

  static Future<List<Profile>> createProfilesFromDataSnapshot(String databaseId, List<DocumentSnapshot> data)async{

      List<Profile> documents = new List<Profile>();

       data.forEach((document){  createProfileFromDocumentSnapshot(databaseId, document).then(((profile){
         documents.add(profile);
       }));  });

    return documents;
  }

  static Future<Profile> createProfileFromDocumentSnapshot(String databaseId, DocumentSnapshot document)async{
    
      DateTime _updatedAt = document[DatabaseIds.updatedAt];
      String _objectId = document.documentID;
      int _orderNumber = document[DatabaseIds.orderNumber];
      File _image = await downloadFile(document.data[DatabaseIds.image]);
      bool _ispublic = document[DatabaseIds.public];

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
        _barista = await DatabaseFunctions.getProfileFromFireStoreWithDocRef(DatabaseIds.Barista, document.data[DatabaseIds.Barista]);}
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

      case DatabaseIds.barista:   
      return  new Profile(
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
  static const String userName = 'username';
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
