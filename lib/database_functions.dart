// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'data/profile.dart';

class DatabaseFunctions {


  static Future<void> logIn(String emailUser, String password,
      Function(bool, String) completion) async {
          // try {
          //   FirebaseUser user = await FirebaseAuth.instance
          //       .signInWithEmailAndPassword(email: emailUser, password: password);
          //   completion(true, StringLabels.loggedIn);
          // } catch (e) {
          //   completion(false, e);
          // }
  }

  static Future<void> signUp(String emailUser, String password,
      Function(bool, String) completion) async {
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

  static Future<void> getCurrentUserId(Function completion (String userId ) ) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  print(user.uid);
  completion(user.uid.toString());
  }

  static void saveProfile(Profile profile){

      // Future<void> file = Images.getFile('assets/images/coffee-beanSmaller512x512.png', (file){    
      // Images.getFile(profile.image.image.toString(), (file){    
        
      // final StorageReference storageReference = 
      //   FirebaseStorage.instance.ref().child(file.path);
      // final StorageUploadTask task = 
      //   storageReference.putFile(file);

    Map <String, dynamic> _properties = new Map <String, dynamic>();

     for (var i = 0; i < profile.properties.length; i++) {
          
        _properties[profile.properties[i].databaseId] = profile.properties[i].value;
      
        }
      DatabaseFunctions.getCurrentUserId( (userId){

      _properties[DatabaseIds.image] = profile.image;
      _properties[DatabaseIds.orderNumber] = profile.orderNumber;
      _properties[DatabaseIds.user] = userId;
      _properties[DatabaseIds.public] = profile.isPublic;
      // _properties[DatabaseFunctions.imagePath] = file.toString();
      

    Firestore.instance.
      collection(profile.databaseId).
      document()
      .setData(_properties);
      }
      );
      // }
      // );
  }

  static void getImage(String id, Function completion(Image image)){
    Image pic = Image.asset(id);
    completion(pic);
  } 

}

class DatabaseIds{

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
  static const String yield = 'yield';
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
