import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/data/images.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:rxdart/rxdart.dart';


class DatabaseFunctions {

  // void initFireStore(){

  //        FirebaseFirestore firestore = FirebaseFirestore.getInstance();
  //         FirebaseFirestoreSettings settings = new FirebaseFirestoreSettings.Builder()
  //                                                 .setTimestampsInSnapshotsEnabled(true)
  //                                                 .build();
  //                                                 firestore.setFirestoreSettings(settings);
  // }

 static Future addFollower(String currentUser, String follow, Function(bool) completion)async{

   /// Add following
    Firestore.instance.collection(DatabaseIds.User)
      .document(currentUser).get()
      .then((newDoc){ 
        
      if(newDoc.exists){
      /// Add following
       
      if (newDoc.data.containsKey(DatabaseIds.following)){
        if (!((newDoc.data[DatabaseIds.following]) as List).contains(follow)){
          
        /// TODO this is deleting every otherfield. We need to update it using firestore transactions.
        List<dynamic> newFollowingList = new List<String>.from(newDoc.data[DatabaseIds.following]);
        newFollowingList.add(follow);

        Map<String, dynamic> data = { DatabaseIds.following :  newFollowingList};
        
          Firestore.instance
          .collection(DatabaseIds.User)
          .document(currentUser)
          .updateData(data)
          .whenComplete((){
            completion(true);
            print('Successfully updated current user$currentUser follower');})
          .catchError((error){print(error);});
        }

      }else{

        List<String> newFollwingList = [follow];

        newDoc.data[DatabaseIds.following] = { DatabaseIds.following : newFollwingList};

        Firestore.instance
                        .collection(DatabaseIds.User)
                        .document(currentUser)
                        .updateData(newDoc.data[DatabaseIds.following])
                        .catchError((error){print(error);});
      }

    }else{print('No document found with ID $currentUser');}
    }
    );

    /// Add followers

    Firestore.instance.collection(DatabaseIds.User)
      .document(follow).get()
      .then((newDoc){ 
        
      if(newDoc.exists){
    
      if (newDoc.data.containsKey(DatabaseIds.followers)){
         if (!((newDoc.data[DatabaseIds.followers]) as List).contains(currentUser)){
      
        List<dynamic> newFollowersList = new List<String>.from(newDoc.data[DatabaseIds.followers]);
        newFollowersList.add(currentUser);

        Map<String, dynamic> data = { DatabaseIds.followers :  newFollowersList};

          Firestore.instance
          .collection(DatabaseIds.User)
          .document(follow)
          .updateData(data)
          .whenComplete((){
            completion(true);
            print('Successfully updated flollower $follow follower');})
          .catchError((error){print(error);});
        }

      }else{

        List<String> newFollwersList = [currentUser];

        newDoc.data[DatabaseIds.followers] = { DatabaseIds.followers : newFollwersList};

        Firestore.instance
                        .collection(DatabaseIds.User)
                        .document(follow)
                        .setData(newDoc.data[DatabaseIds.followers])
                        .catchError((error){print(error);});
      }
    
    /// Document does not exist  
    }else{print('No document found with ID $currentUser');}
    
    
      }) .catchError((e) => print(e)); 
  }

  //TODO
  static void upDateFirebaseData(){}
  

  static Future unFollow(String currentUser, String unFollow , Function(bool) completion)async{

      Firestore.instance
              .collection(DatabaseIds.User)
              .document(currentUser).get()
              .then((newDoc){
      if(newDoc.exists){
        if (newDoc.data.containsKey(DatabaseIds.following)){
        if ((newDoc.data[DatabaseIds.following] as List).contains(unFollow)){

        List<dynamic> newFollowingList = new List<String>.from(newDoc.data[DatabaseIds.following]);
        newFollowingList.remove(unFollow);
        Map<String, dynamic> data = { DatabaseIds.following : newFollowingList};

          Firestore.instance
          .collection(DatabaseIds.User)
          .document(currentUser)
          .updateData(data)
          .whenComplete((){
            completion(true);
            print('Successfully removed follower $unFollow follower');})
          .catchError((error){print(error);});

        }

      }else{

        newDoc.data[DatabaseIds.following] = Map<String, dynamic>();

        Firestore.instance
        .collection(DatabaseIds.User)
        .document(currentUser)
        .setData(newDoc.data[DatabaseIds.following])
        .then((_){
            completion(true);
            print('Successfully removed current user $currentUser follower');})
        .catchError((error){print(error);});
      }
      }else{print('No document found with ID $currentUser');}
      })..catchError((e) => print(e));

  
    /// Remove current User from Collection

      Firestore.instance
              .collection(DatabaseIds.User)
              .document(unFollow).get()
              .then((newDoc){
      if(newDoc.exists){

      if (newDoc.data.containsKey(DatabaseIds.followers)){
        if ((newDoc.data[DatabaseIds.followers] as List).contains(currentUser)){

        List<dynamic> newFollowersList = new List<String>.from(newDoc.data[DatabaseIds.followers]);
        newFollowersList.remove(currentUser);
        Map<String, dynamic> data = { DatabaseIds.followers : newFollowersList};

          Firestore.instance
          .collection(DatabaseIds.User)
          .document(unFollow)
          .updateData(data)
          .whenComplete((){
            completion(true);
            print('Successfully removed following $currentUser follower');})
          .catchError((error){print(error);});

        }
      }else{
        /// Create blank field for following
        Map<String, dynamic> data = {DatabaseIds.following : List<dynamic>()};

        Firestore.instance
        .collection(DatabaseIds.User)
        .document(unFollow)
        .setData(data)
        .then((_){
            completion(true);
            print('Successfully added following field to $unFollow document');})
        .catchError((error){print(error);});
      }
     
      }else{print('No document found with ID $unFollow');}
      })..catchError((e) => print(e));



  }

  // Firestore fireStore;

  // DatabaseFunctions(){this.fireStore = new Firestore();}

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
 

 static Stream<FirebaseUser>getCurrentUserStream(){

  return FirebaseAuth.instance.onAuthStateChanged;
 }

  static Future<UserDetails>getCurrentUserDetails()async{

    FirebaseUser user = await FirebaseAuth.instance.currentUser().catchError((error) => print(error));
    
    UserDetails userDetails = UserDetails(
                                  idIn: user.uid,
                                  emailIn: user.email,
                                  );

    assert(userDetails != null , 'userDetails is null');
    return userDetails;
  }

  /// SignUp
  static Future<void> signUp
  (String userName, String emailUser, String password, String imageUrl, Function(bool, String) completion) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailUser, password: password)
          .then( (user)async{


            Map<String, dynamic> data = {
            DatabaseIds.userId : user.uid,
            DatabaseIds.userName : userName,
            DatabaseIds.imageUrl : imageUrl,
            DatabaseIds.following : List<String>()
            };

            await Firestore.instance.collection(DatabaseIds.User).document(user.uid).setData(data);

            completion(true, StringLabels.signedYouUp);})
          .catchError((e) => completion(false, e.message));
    } catch (e) {
      completion(false, e.message);
    }
  }

  static Future<String> getCurrentUserEmail()async{

    FirebaseUser user = await FirebaseAuth.instance.currentUser().catchError((error) => print(error));
    String email = user.email;
    return email;
  }

  Future deleteCurrectUser()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    user.delete()
    .then((_){print('User deleted');return true;})
    .catchError((e){ print(e);return false;});

  }



  /// Logout
  static Future <void> logOut()async{
    await FirebaseAuth.instance.signOut();
    print('Logged out');
  }

  /// Get User Image
  static Future <String> getUserImage()async{

    String userId = await getCurrentUserId();

      return await getValueFromFireStoreWithDocRef(DatabaseIds.User, userId, DatabaseIds.imageUrl) ?? '';
  }

  /// Get User Name
  static Future <String> getUserName()async{

    Future<String> username;

     getCurrentUserId().then((String userId){

      getValueFromFireStoreWithDocRef(DatabaseIds.User, userId, DatabaseIds.userName)
                                        .then((userName){  
                                          username = userName; 
                                        })
            .catchError((error) => print(error));
      }
    )
    .catchError((error) => print(error));

    Future.wait([username]);
    assert(username != null, 'username is null'); 

    return username;
  }
    
  
  static Future updateUserProfile(UserDetails userdetails) async{

    FirebaseUser user = await FirebaseAuth.instance.currentUser().catchError((error) => print(error));

    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    if (userdetails.userName != null || userdetails.userName != ""){
    userUpdateInfo.displayName = userdetails.userName;}
    if (userdetails.photo != null || userdetails.photo != ""){
    userUpdateInfo.photoUrl = userdetails.photo;}

    if (userdetails.password != null && userdetails.password != ""){
    user.updatePassword(userdetails.password).catchError(((error) => print(error)));}
     if (userdetails.email != null && userdetails.email != ""){
    user.updateEmail(userdetails.email).catchError(((error) => print(error)));}

    await user.updateProfile(userUpdateInfo)
      .then( (_)async{
            Map<String, dynamic> data = {
            DatabaseIds.userId : user.uid,
            DatabaseIds.userName : userdetails.userName,
            DatabaseIds.imageUrl : userdetails.photo,
            DatabaseIds.motto : userdetails.motto 
            };

            Map<String, dynamic> newData = Map<String, dynamic>();

            newData[DatabaseIds.userId] = user.uid;
            
            userdetails.values.forEach((key, value) {
              if(
                key == DatabaseIds.userName ||
                key == DatabaseIds.imageUrl ||
                key == DatabaseIds.motto 
                ){
               newData[key] = value;}
            });

            Firestore.instance.collection(DatabaseIds.User).document(user.uid).get().then((doc){

              if(doc.exists){ 
                Firestore.instance.collection(DatabaseIds.User).document(user.uid).updateData(data)
                          .then((_) => print('sucessfully updated user'))
                          .catchError((e) => print('Error updating user $e'));
              }else{
                Firestore.instance.collection(DatabaseIds.User).document(user.uid).setData(data)
                          .then((_) => print('sucessfully updated user '))
                          .catchError((e) => print('Error updating user $e'));
              }
            });
      }).catchError((error) => print(error));
  }

  

  // Get current User from firebase
  static Future<String> getCurrentUserId()async{
  
    FirebaseUser user = await FirebaseAuth.instance.currentUser()
                                    .catchError((error) => print(error));
    return user.uid.toString();
  }

  static Future<FirebaseUser> getCurrentUser()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser()
                                    .catchError((error) => print(error));
    return user;
  }
  

  /// Dowload file from Firebase
  static Future<File> downloadFile(String httpPath)async{

    String fileName = getImageNameFromFullUrl(httpPath);

    final Directory tempDir = Directory.systemTemp;

    try {
    final File file = File('${tempDir.path}/$fileName');
    final StorageReference firebaseStorageReferance = FirebaseStorage.instance.ref().child(fileName);
    final StorageFileDownloadTask downloadTask = firebaseStorageReferance.writeToFile(file);

    await downloadTask.future;
    return file;

     } catch (e){
       throw('e');
     }   
  }

  static Future<bool> checkImageFileExists(String httpPath)async{

    String fileName = getImageNameFromFullUrl(httpPath);

    try {

    FirebaseStorage.instance
    .ref().child(fileName)
    .getDownloadURL()
    .then((value)
    {
      print(value);});
     } catch (e){
       throw('e');
     }   
  }

 static String getImageNameFromFullUrl(String httpPath){
    
    final RegExp regExpPng = RegExp('([^?/]*\.(png))');
    final RegExp regExpjpg = RegExp('([^?/]*\.(jpg))');
    String fileName;

    if (httpPath.contains(RegExp('png'))){fileName = regExpPng.stringMatch(httpPath);}
    else if (httpPath.contains(RegExp('jpg'))){fileName = regExpjpg.stringMatch(httpPath);}
    else {throw('No matching file type') ;}
    
    assert(fileName != null);
    return fileName;
  }

  /// Update document with referance
  static Future<void> updateProfile(Profile profile)async{

    Map <String, dynamic> _documentProperties = await prepareProfileForFirebaseUpload(profile);

    Firestore.instance
    .collection(profile.databaseId)
    .document(profile.objectId)
    .updateData(_documentProperties)
    .whenComplete((){print('Successfully updated ${profile.objectId}');})
    .catchError((error){print(error);});

  }

  /// Upload file to Firebase
  static Future<String> upLoadFileReturnUrl(File file, List<String> folders, {Function(String)  errorHandler})async{

   StorageReference ref;
    if(folders.length == 0){
       ref = FirebaseStorage.instance.ref().child(path.basename(file.path));
    }else if(folders.length == 1){
       ref = FirebaseStorage.instance.ref().child(folders[0]).child(path.basename(file.path));
    }else if(folders.length == 2){
       ref = FirebaseStorage.instance.ref().child(folders[0]).child(folders[1]).child(path.basename(file.path));
    }else if(folders.length == 3){
        ref = FirebaseStorage.instance.ref().child(folders[0]).child(folders[1]).child(folders[2]).child(path.basename(file.path));
    }else{
       ref = FirebaseStorage.instance.ref().child(path.basename(file.path));
    }

    final StorageUploadTask uploadTask = ref.putFile(file);
    uploadTask.events.listen((event) {
            double _progress = event.snapshot.bytesTransferred.toDouble() / event.snapshot.totalByteCount.toDouble();
            print(_progress);
        }).onError((error) {
          print(error);
        });

    return await (await uploadTask.onComplete).ref.getDownloadURL().catchError((error){errorHandler(error);});
  }

  /// Delete Firebase Storage Item //TODO
  static void deleteFireBaseStorageItem(String fileUrl){

    String filePath = fileUrl
                      .replaceAll(new 
                      RegExp(r'https://firebasestorage.googleapis.com/v0/b/dial-in-21c50.appspot.com/o/'), '');

    filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');
  
    filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');

    StorageReference storageReferance = FirebaseStorage.instance.ref();

    storageReferance.child(filePath).delete().then((_) => print('Successfully deleted $filePath storage item' ));

  }

  /// Prepare Profile for FirebaseUpload or Update
  static Future<Map <String, dynamic>> prepareProfileForFirebaseUpload(Profile profile)async{


    Map <String, dynamic> _properties = new Map <String, dynamic>();

     for (var i = 0; i < profile.properties.length; i++) {_properties[profile.properties[i].databaseId] = profile.properties[i].value;}

    String userId = await DatabaseFunctions.getCurrentUserId();

        _properties[DatabaseIds.imageUrl] = profile.imageUrl;
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
    Firestore.instance.collection(profile.databaseId).document(profile.objectId)
        .delete()
        .whenComplete((){
          DatabaseFunctions.deleteFireBaseStorageItem(profile.imageUrl);
          print('Successfully deleted ${profile.objectId}');})
        .catchError((e){print(e);});
  }

  /// Save profile
  static Future<Profile> saveProfile(Profile profile)async{

    Map <String, dynamic> _properties = new Map <String, dynamic>();

     for (var i = 0; i < profile.properties.length; i++) {

        _properties[profile.properties[i].databaseId] = profile.properties[i].value;

      }

    String userId = await DatabaseFunctions.getCurrentUserId();

        _properties[DatabaseIds.imageUrl] = profile.imageUrl;
        _properties[DatabaseIds.orderNumber] = profile.orderNumber;
        _properties[DatabaseIds.user] = userId;
        _properties[DatabaseIds.public] = profile.isPublic;
        _properties[DatabaseIds.likes] = profile.likes;
        _properties[DatabaseIds.comments] = profile.comments;

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

  static Future<int> getCount(ProfileType profileType, String userId)async{

    var snaps = Firestore.instance
      .collection(Functions.getProfileTypeDatabaseId(profileType))
      .where(DatabaseIds.user, isEqualTo: userId);

    var querySnapshot = await snaps.getDocuments();

    var totalEquals = querySnapshot.documents.length;

    return totalEquals;
  }

  /// Get Image from assets
  static void getImageFromAssets(String id, Function completion(Image image)){
    Image pic = Image.asset(id);
    completion(pic);
  }

  /// Get profiles from from store with doc referance
  static Future<Profile> getProfileFromFireStoreWithDocRef(String collectionDataBaseId, String docRefernace)async{

    Profile _profile;

    if (docRefernace != ''){

    DocumentSnapshot doc = await Firestore.instance.collection(collectionDataBaseId).document(docRefernace).get();

    if (doc.exists) {
          _profile = await DatabaseFunctions.createProfileFromDocumentSnapshot(collectionDataBaseId, doc);
      } else {_profile =  await Profile.createBlankProfile(Functions.getProfileDatabaseIdType(collectionDataBaseId));}

    }else{_profile =  await Profile.createBlankProfile(Functions.getProfileDatabaseIdType(collectionDataBaseId));}

    return _profile;
  }

  static Future<List<Profile>> convertStreamToListOfProfiles(QuerySnapshot stream, String databaseId) async {

    final futureProfiles = stream.documents.map((doc) =>
        DatabaseFunctions.createProfileFromDocumentSnapshot(databaseId, doc));

    return await Future.wait(futureProfiles);
  }

  /// Get stream with one argument
  static Stream<dynamic> getStreamFromFireStore(String collection, String whereKey, dynamic isEqualTo ){
    return Firestore.instance.collection(collection)
                              .where(whereKey, isEqualTo: isEqualTo)
                              .snapshots();
  }

  /// Get stream with two arguments
  static Stream<dynamic> getStreamFromFireStoreTwoArgs
    (String collection, String whereKeyOne, dynamic isEqualToOne, String whereKeyTwo, dynamic isEqualToTwo ){
    return Firestore.instance.collection(collection)
                              .where(whereKeyOne, isEqualTo: isEqualToOne)
                              .where(whereKeyTwo, isEqualTo: isEqualToTwo)
                              .snapshots();
  }

  /// TODO
  static void  getUserProfileStreamFromFireStoreWithDocRef(String docRefernace){

    Completer completer = new Completer();

    Stream<DocumentSnapshot> userSnapshotStream = Firestore.instance.collection(DatabaseIds.User).document(docRefernace).snapshots();

    final BehaviorSubject<UserProfile> _outgoingController = BehaviorSubject<UserProfile>();

    UserProfile userProfile;

    userSnapshotStream.listen((doc){

      if (doc.exists){

        userProfile = new UserProfile(
                              doc.data[DatabaseIds.user]?? 'Error: submit feedback database_functions.dart => line 557',
                              doc.data[DatabaseIds.userName]?? 'Error: submit feedback database_functions.dart => line 558',
                              doc.data[DatabaseIds.imageUrl]?? '',
                              doc.data[DatabaseIds.following]?? ['Error: submit feedback database_functions.dart => line 560'],
                              doc.data[DatabaseIds.followers]?? ['Error: submit feedback database_functions.dart => line 561'],
                              doc.data[DatabaseIds.motto]?? 'Error: submit feedback database_functions.dart => line 562',
                              doc.data[DatabaseIds.imagePath]?? '',
                              );

        _outgoingController.add(userProfile);
      }else{

        completer.completeError('ERROR');

      }
    });
    completer.completeError('ERROR');
  }

    /// Get profiles from fore store with doc referance //TODO;
  static Future<UserProfile> getUserProfileFromFireStoreWithDocRef(String docRefernace)async{

    UserProfile _userProfile;

    if (docRefernace != ''){

    DocumentSnapshot doc = await Firestore.instance.collection(DatabaseIds.User)
                                                    .document(docRefernace).get();

    if (doc.exists) {

          /// For following
          List<dynamic> following = List<dynamic>.from(doc.data[DatabaseIds.following]) ?? List<dynamic>();
        
          List<String> followingRevisedList = new List<String>();

          following.forEach((follow) 
          { if(follow is String) {followingRevisedList.add(follow);}});
           
          /// For followers
          List<dynamic> followers = List<dynamic>.from(doc.data[DatabaseIds.followers]) ?? List<dynamic>();
          
          List<String> followersRevisedList = new List<String>();

          followers.forEach((follow) 
          { if(follow is String) {followersRevisedList.add(follow);}});


          _userProfile = new UserProfile(
                            docRefernace,
                            doc.data[DatabaseIds.userName] ?? 'Error: submit feedback database_functions.dart => line 604',
                            doc.data[DatabaseIds.imageUrl] ?? '',
                            followingRevisedList ?? List<String>() ?? ['Error: submit feedback database_functions.dart => line 606'],
                            followersRevisedList ?? List<String>() ?? ['Error: submit feedback database_functions.dart => line 607'],
                            doc.data[DatabaseIds.motto] ??  'Error: submit feedback database_functions.dart => line 608',
                            doc.data[DatabaseIds.imagePath]?? '',
                            );
          
          assert(_userProfile != null, '_userProfile == null');
      }
    }
    assert(_userProfile != null, '_userProfile == null');

    return _userProfile ?? new UserProfile
                            ('error', 'error', 'error', ['error'], ['error'],'error', 'error');
  }

  /// Get value from collection with key
  static Future<dynamic> getValueFromFireStoreWithDocRef(String collectionDataBaseId, String docRefernace, String key)async{

    dynamic _value;

    if (docRefernace != ''){

    DocumentSnapshot doc = await Firestore.instance.collection(collectionDataBaseId).document(docRefernace).get();

    if (doc.exists) {
        if(doc.data.length > 0){_value = doc.data[key];}
        else{ _value = '';}

      } else {
          throw Error();
      }
    }else{ throw Error();}

    return _value;
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

      Profile newProfile =  await Profile.createBlankProfile(Functions.getProfileDatabaseIdType(databaseId));

      DateTime _updatedAt = document[DatabaseIds.updatedAt]?? DateTime.now();
      String _user = document[DatabaseIds.user] ?? '';
      String _objectId = document.documentID ?? '';
      int _orderNumber = document[DatabaseIds.orderNumber] ?? 0;
      String _image = document[DatabaseIds.imageUrl] ?? '';
      bool _ispublic = document.data[DatabaseIds.public] ?? false;
      List<dynamic> likesIn = document.data[DatabaseIds.likes] ?? List<dynamic>();
      List<String> likes =  List<String>.from(likesIn);

      List<Map<String,String>> comments;
      if(document.data[DatabaseIds.comments] != null){
      comments = List<Map<String,String>>.from(document.data[DatabaseIds.comments]) ?? List<dynamic>();}
      else{comments = List<Map<String,String>>();};

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
        else{_coffee = await Profile.createBlankProfile(ProfileType.coffee);}

      if (document.data.containsKey(DatabaseIds.barista) && document.data[DatabaseIds.barista] != ""){
        _barista = await DatabaseFunctions.getProfileFromFireStoreWithDocRef(DatabaseIds.Barista, document.data[DatabaseIds.barista]);}
        else{_barista = await Profile.createBlankProfile(ProfileType.barista);}

      if (document.data.containsKey(DatabaseIds.equipmentId) && document.data[DatabaseIds.Barista] != ""){
        _equipment = await DatabaseFunctions.getProfileFromFireStoreWithDocRef(DatabaseIds.brewingEquipment, document.data[DatabaseIds.equipmentId]);}
        else{_equipment = await Profile.createBlankProfile(ProfileType.equipment);}

      if (document.data.containsKey(DatabaseIds.grinderId) && document.data[DatabaseIds.grinderId] != ""){
        _grinder = await DatabaseFunctions.getProfileFromFireStoreWithDocRef(DatabaseIds.grinder, document.data[DatabaseIds.grinderId]);}
        else{_grinder = await Profile.createBlankProfile(ProfileType.grinder);}

      if (document.data.containsKey(DatabaseIds.waterID) && document.data[DatabaseIds.waterID] != ""){
        _water = await DatabaseFunctions.getProfileFromFireStoreWithDocRef(DatabaseIds.water, document.data[DatabaseIds.waterID]);}
        else{_water = await Profile.createBlankProfile(ProfileType.water);}
      }

        document.data.forEach((key, value) {

      if ( key != DatabaseIds.updatedAt){

      if ( key != DatabaseIds.orderNumber){

      if ( key != DatabaseIds.imageUrl){

      if ( key != DatabaseIds.public){

      if ( key != DatabaseIds.user){

        newProfile.properties.forEach((item){

          if (item.databaseId == key){
            item.value = value;
          }
        });
     }}}}}}
    );

    switch(databaseId){

      case DatabaseIds.recipe:

      return  new Profile(
              comments: comments,
              likes: likes,
              userId: _user,
              isPublic: _ispublic,
              updatedAt: _updatedAt,
              objectId: _objectId,
              type: ProfileType.recipe,
              imageUrl: _image,
              databaseId: databaseId,
              orderNumber: _orderNumber,
              properties: newProfile.properties,
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
              comments: comments,
              likes: likes,
              userId: _user,
              isPublic: _ispublic,
              updatedAt: DateTime.now(),
              objectId: _objectId,
              type: ProfileType.coffee,
              imageUrl: _image,
              databaseId: databaseId,
              orderNumber: _orderNumber,
              properties: newProfile.properties
              );
      break;

      case DatabaseIds.grinder:
      return  new Profile(
              comments: comments,
              likes: likes,
              userId: _user,
              isPublic: _ispublic,
              updatedAt: DateTime.now(),
              objectId: _objectId,
              type: ProfileType.grinder,
              imageUrl: _image,
              databaseId: databaseId,
              orderNumber: _orderNumber,
              properties: newProfile.properties
              );
      break;

      case DatabaseIds.brewingEquipment:
      return  new Profile(
        comments: comments,
        likes: likes,
        userId: _user,
        isPublic: _ispublic,
        updatedAt: DateTime.now(),
        objectId: _objectId,
        type: ProfileType.equipment,
        imageUrl: _image,
        databaseId: databaseId,
        orderNumber: _orderNumber,
        properties: newProfile.properties
              );
      break;

      case DatabaseIds.water:
      return  new Profile(
        comments: comments,
        likes: likes,
        userId: _user,
        isPublic: _ispublic,
        updatedAt: DateTime.now(),
        objectId: _objectId,
        type: ProfileType.water,
        imageUrl: _image,
        databaseId: databaseId,
        orderNumber: _orderNumber,
        properties: newProfile.properties
        );
      break;

      case DatabaseIds.Barista:
      return  new Profile(
        comments: comments,
        likes: likes,
        userId: _user,
        isPublic: _ispublic,
        updatedAt: DateTime.now(),
        objectId: _objectId,
        type: ProfileType.barista,
        imageUrl: _image,
        databaseId: databaseId,
        orderNumber: _orderNumber,
        properties: newProfile.properties
        );
      break;

      default:
      Error();
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
}

class CurrentUserDetailsStream{

  Stream<FirebaseUser> userStream;
  BehaviorSubject<UserDetails> userDetailsStreamcontroller = BehaviorSubject<UserDetails>();

  CurrentUserDetailsStream(){
    userStream = DatabaseFunctions.getCurrentUserStream();
    userStream.listen(forUserDetails);
  }

  Stream<UserDetails> get userDetailsStream => userDetailsStreamcontroller.stream;

  
  void dipose(){userDetailsStreamcontroller.close(); }

  void forUserDetails(FirebaseUser user){
    UserDetails userDetails = UserDetails(
                                  idIn: user.uid,
                                  emailIn: user.email,
                                  );
    userDetailsStreamcontroller.add(userDetails);
  }
}

class CurrentUserProfileStream{

  Stream<UserDetails> userStream;
  BehaviorSubject<UserProfile> userProfileStreamcontroller = BehaviorSubject<UserProfile>();

  CurrentUserProfileStream(Stream<UserDetails> userDetailsStream){
    userStream = userDetailsStream;
    userStream.listen(forUserProfile);
  }

  Stream<UserProfile> get userProfileStream => userProfileStreamcontroller.stream;

  
  void dipose(){userProfileStreamcontroller.close(); }

  void forUserProfile(UserDetails user){

    Stream<DocumentSnapshot> userSnapshotStream  = Firestore.instance.collection(DatabaseIds.User).document(user.id).snapshots();

    userSnapshotStream.listen((doc){

      if (doc.exists){

        UserProfile userProfile = new UserProfile(
                              doc.data[DatabaseIds.user] ?? 'Error: submit feedback database_functions.dart => line 976',
                              doc.data[DatabaseIds.userName] ?? 'Error: submit feedback database_functions.dart => line 977',
                              doc.data[DatabaseIds.imageUrl]?? 'Error: submit feedback database_functions.dart => line 778',
                              doc.data[DatabaseIds.following]?? ['Error: submit feedback database_functions.dart => line 979'],
                              doc.data[DatabaseIds.followers]?? ['Error: submit feedback database_functions.dart => line 980'],
                              doc.data[DatabaseIds.motto]?? 'Error: submit feedback database_functions.dart => line 981w',
                              doc.data[DatabaseIds.imagePath]?? 'Error: submit feedback database_functions.dart => line 981w',
                              );

        userProfileStreamcontroller.add(userProfile);
      }
    });    
  }
}

 

class Storage {

  static Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<File> get localFile async {
    final path = await localPath;
    return File('$path/');
  }

  static Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}

class DatabaseIds{
  static const String motto = 'motto';
  static const String comments = 'comments';
  static const String likes = 'likes';
  static const String followers = 'followers';
  static const String userId = 'userId';
  static const String success = 'success';
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
  static const String imageUrl = 'image';
  static const String orderNumber = 'orderNumber';
}
