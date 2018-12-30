import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:dial_in_v1/data/item.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/images.dart';
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

  static void getRatio (List<int> numbers){
    
    List<List<int>> primeFactorList;

    /// Find prime factors for each number
    numbers.forEach((number){
      bool check = true;
      int x = 0;

      List<int> primeFactors;

      while(check == true && number <= primeNumbers[x]/2 && x < primeNumbers.length){

        if( number % primeNumbers[x] == 0){

          primeFactors.add(primeNumbers[x]);

        }
      }
      primeFactorList.add(primeFactors);
    }
    );
  
    List<int> commonFactors;

    /// Find matching values
    for (var i = 0; i < primeFactorList.length; i++) {
          bool check = true;

     for (var x = 0; x < primeFactorList[i].length; x++){

       for (var y = 0; y < primeFactorList[i+1].length - 1; y++){

         while (check == true){
          if(primeFactorList[i][x] == primeFactorList[i][y]){

            commonFactors.add(primeFactorList[i][x]);
            check = false;
          }
         }
       }
     }
    }
    int highestDemoniator = commonFactors.reduce((value, element) => value * element);

    List<int> newNumbers;

     for (var x = 0; x < numbers.length; x++){

       newNumbers.add(numbers[x] * highestDemoniator);

      }
      print('New ratio $newNumbers');
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
      return Center(child: CupertinoActionSheet(actions: <Widget>[

      new CupertinoDialogAction(
          child: const Text(StringLabels.camera),
          isDestructiveAction: false,
          onPressed: ()async{ 
            File image = await ImagePicker.pickImage
                              (maxWidth: 640.0, maxHeight: 480.0, source: ImageSource.camera);
            url = await DatabaseFunctions.upLoadFileReturnUrl(image, [DatabaseIds.image]);
            Navigator.of(context).pop(then(url));
          }
      ),
    
      new  CupertinoDialogAction(
          child: const Text(StringLabels.photoLibrary),
          isDestructiveAction: false,
          onPressed: ()async{ 
            File image = await ImagePicker.pickImage
                              (maxWidth: 640.0, maxHeight: 480.0, source: ImageSource.gallery);
            url = await DatabaseFunctions.upLoadFileReturnUrl(image, [DatabaseIds.image]);
            Navigator.of(context).pop(then(url));
          }
      ),
    ],));
    }
    );
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
        return StringLabels.brewingEquipment;
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
        return DatabaseIds.brewingEquipment;
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
        return StringLabels.brewingEquipment;
        break;

      case DatabaseIds.grinder:
        return StringLabels.grinder;
        break;

      case DatabaseIds.Barista:
        return StringLabels.barista;
        break;

      default:
        return StringLabels.feed;
        break;
    }
  }

  static Future<Profile> createBlankProfile(ProfileType profileType)async{
    switch (profileType) {

      case ProfileType.recipe:
        return new Profile(
            isPublic: true,
            updatedAt: DateTime.now(),
            objectId: '',
            image: Images.recipeSmallerFirebase,
            databaseId: DatabaseIds.recipe,
            type: ProfileType.recipe,
            viewContollerId: ViewControllerIds.recipe,
            orderNumber: 0,
            properties: [
              createBlankItem(DatabaseIds.barista),
              createBlankItem(DatabaseIds.date),
              createBlankItem(DatabaseIds.grindSetting),
              createBlankItem(DatabaseIds.temparature),
              createBlankItem(DatabaseIds.brewingDose),
              createBlankItem(DatabaseIds.preinfusion),
              createBlankItem(DatabaseIds.yielde),
              createBlankItem(DatabaseIds.brewWeight),
              createBlankItem(DatabaseIds.time),
              createBlankItem(DatabaseIds.tds),
              createBlankItem(DatabaseIds.notes),
              createBlankItem(DatabaseIds.flavour),
              createBlankItem(DatabaseIds.body),
              createBlankItem(DatabaseIds.balance),
              createBlankItem(DatabaseIds.afterTaste),
              createBlankItem(DatabaseIds.strength),
              createBlankItem(DatabaseIds.descriptors),
            ],
            profiles: [
              await createBlankProfile(ProfileType.coffee),
              await createBlankProfile(ProfileType.barista),
              await createBlankProfile(ProfileType.equipment),
              await createBlankProfile(ProfileType.grinder),
              await createBlankProfile(ProfileType.water),
            ]);
        break;

      case ProfileType.water:
        return new Profile(
            isPublic: true,
            updatedAt: DateTime.now(),
            objectId: '',
            image: Images.dropFirebase,
            databaseId: DatabaseIds.water,
            type: ProfileType.water,
            viewContollerId: ViewControllerIds.water,
            orderNumber: 0,
            properties: [
              createBlankItem(DatabaseIds.waterID),
              createBlankItem(DatabaseIds.date),
              createBlankItem(DatabaseIds.ppm),
              createBlankItem(DatabaseIds.gh),
              createBlankItem(DatabaseIds.kh),
              createBlankItem(DatabaseIds.ph),
              createBlankItem(DatabaseIds.notes),
            ]);
        break;

      case ProfileType.coffee:
        return new Profile(
            isPublic: true,
            updatedAt: DateTime.now(),
            objectId: '',
            image: Images.coffeeBeansFirebase,
            databaseId: DatabaseIds.coffee,
            type: ProfileType.coffee,
            viewContollerId: ViewControllerIds.coffee,
            orderNumber: 0,
            properties: [
              createBlankItem(DatabaseIds.coffeeId),
              createBlankItem(DatabaseIds.country),
              createBlankItem(DatabaseIds.region),
              createBlankItem(DatabaseIds.farm),
              createBlankItem(DatabaseIds.producer),
              createBlankItem(DatabaseIds.lot),
              createBlankItem(DatabaseIds.altitude),
              createBlankItem(DatabaseIds.roastDate),
              createBlankItem(DatabaseIds.roastProfile),
              createBlankItem(DatabaseIds.roasteryName),
              createBlankItem(DatabaseIds.beanType),
              createBlankItem(DatabaseIds.beanSize),
              createBlankItem(DatabaseIds.processingMethod),
              createBlankItem(DatabaseIds.density),
              createBlankItem(DatabaseIds.aW),
              createBlankItem(DatabaseIds.moisture),
              createBlankItem(DatabaseIds.roasterName),
              createBlankItem(DatabaseIds.harvest),
            ]);
        break;

      case ProfileType.equipment:
        return new Profile(
          isPublic: true,
          updatedAt: DateTime.now(),
          objectId: '',
          image: Images.aeropressSmaller512x512Firebase,
          databaseId: DatabaseIds.brewingEquipment,
          type: ProfileType.equipment,
          viewContollerId: ViewControllerIds.brewingEquipment,
          orderNumber: 0,
          properties: [
            createBlankItem(DatabaseIds.equipmentId),
            createBlankItem(DatabaseIds.equipmentMake),
            createBlankItem(DatabaseIds.equipmentModel),
            createBlankItem(DatabaseIds.method),
            createBlankItem(DatabaseIds.type),
          ],
        );
        break;

      case ProfileType.feed:
        return new Profile(
          isPublic: true,
          updatedAt: DateTime.now(),
          objectId: '',
          image: Images.userFirebase,
          databaseId: DatabaseIds.feed,
          type: ProfileType.feed,
          viewContollerId: ViewControllerIds.feed,
          orderNumber: 0,
          properties: [
            createBlankItem(DatabaseIds.type),
          ],
        );
        break;

      case ProfileType.grinder:
        return new Profile(
          isPublic: true,
          updatedAt: DateTime.now(),
          objectId: '',
          image: Images.grinderFirebase,
          databaseId: DatabaseIds.grinder,
          type: ProfileType.grinder,
          viewContollerId: ViewControllerIds.grinder,
          orderNumber: 0,
          properties: [
            createBlankItem(DatabaseIds.grinderId),
            createBlankItem(DatabaseIds.grinderMake),
            createBlankItem(DatabaseIds.grinderModel),
            createBlankItem(DatabaseIds.burrs),
            createBlankItem(DatabaseIds.notes),
          ],
        );
        break;

      case ProfileType.none:
        return new Profile(
          isPublic: true,
          updatedAt: DateTime.now(),
          objectId: '',
          // image: document[DatabaseIds.image].toString(),
          databaseId: DatabaseIds.databaseId,
          orderNumber: 0,
          properties: [
            createBlankItem(DatabaseIds.type),
            createBlankItem(DatabaseIds.level),
            createBlankItem(DatabaseIds.name),
            createBlankItem(DatabaseIds.notes)
          ],
        );
        break;

      case ProfileType.barista:
        return new Profile(
          isPublic: true,
          updatedAt: DateTime.now(),
          objectId: '',
          image: Images.userFirebase,
          databaseId: DatabaseIds.Barista,
          type: ProfileType.barista,
          viewContollerId: ViewControllerIds.barista,
          orderNumber: 0,
          properties: [
            createBlankItem(DatabaseIds.name),
            createBlankItem(DatabaseIds.level),
            createBlankItem(DatabaseIds.notes)
          ],
        );
        break;

      default:
        return new Profile(
          isPublic: true,
          updatedAt: DateTime.now(),
          objectId: '',
          // image: document[DatabaseIds.image].toString(),
          databaseId: DatabaseIds.databaseId,
          orderNumber: 0,
          properties: [
            createBlankItem(DatabaseIds.name),
          ],
        );
        break;
    }
  }

  static Item createBlankItem(String databaseId) {
    Item _item;

    switch (databaseId) {

      ///
      /// Recipe
      ///
      case DatabaseIds.date:
        _item = new Item(
          title: StringLabels.date,
          value: DateTime.now(),
          databaseId: DatabaseIds.date,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.brewingEquipment:
        _item = new Item(
          title: StringLabels.brewingEquipment,
          value: '',
          databaseId: DatabaseIds.equipmentId,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.grinder:
        _item = new Item(
          title: StringLabels.grinder,
          value: '',
          databaseId: DatabaseIds.grinderId,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.grindSetting:
        _item = new Item(
          title: StringLabels.grindSetting,
          value: '',
          databaseId: DatabaseIds.grindSetting,
          placeHolderText: StringLabels.enterValue,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.waterID:
        _item = new Item(
          title: StringLabels.name,
          value: '',
          databaseId: DatabaseIds.waterID,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.temparature:
        _item = new Item(
          title: StringLabels.temparature,
          value: '',
          databaseId: DatabaseIds.temparature,
          placeHolderText: StringLabels.enterTemparature,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.brewingDose:
        _item = new Item(
          title: StringLabels.brewingDose,
          value: '',
          databaseId: DatabaseIds.brewingDose,
          placeHolderText: StringLabels.enterValue,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.preinfusion:
        _item = new Item(
          title: StringLabels.preinfusion,
          value: '',
          databaseId: DatabaseIds.preinfusion,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.yielde:
        _item = new Item(
          title: StringLabels.yielde,
          value: '',
          databaseId: DatabaseIds.yielde,
          placeHolderText: StringLabels.enterValue,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.brewWeight:
        _item = new Item(
          title: StringLabels.brewWeight,
          value: '',
          databaseId: DatabaseIds.brewWeight,
          placeHolderText: StringLabels.enterValue,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.time:
        _item = new Item(
          title: StringLabels.time,
          value: '',
          databaseId: DatabaseIds.time,
          placeHolderText: StringLabels.enterValue,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.tds:
        _item = new Item(
          title: StringLabels.tds,
          value: '',
          databaseId: DatabaseIds.tds,
          placeHolderText: StringLabels.enterValue,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.notes:
        _item = new Item(
          title: StringLabels.notes,
          value: '',
          databaseId: DatabaseIds.notes,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.flavour:
        _item = new Item(
          title: StringLabels.flavour,
          value: '0.0',
          databaseId: DatabaseIds.flavour,
          placeHolderText: StringLabels.flavour,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.body:
        _item = new Item(
          title: StringLabels.body,
          value: '0.0',
          databaseId: DatabaseIds.body,
          placeHolderText: StringLabels.enterValue,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.balance:
        _item = new Item(
          title: StringLabels.balance,
          value: '0.0',
          databaseId: DatabaseIds.balance,
          placeHolderText: StringLabels.enterValue,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.afterTaste:
        _item = new Item(
          title: StringLabels.afterTaste,
          value: '0.0',
          databaseId: DatabaseIds.afterTaste,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.strength:
        _item = new Item(
          title: StringLabels.strength,
          value: '0.0',
          databaseId: DatabaseIds.strength,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.descriptors:
        _item = new Item(
          title: StringLabels.descriptors,
          value: '',
          databaseId: DatabaseIds.descriptors,
          placeHolderText: StringLabels.descriptors,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.coffeeId:
        _item = new Item(
          title: StringLabels.coffee,
          value: '',
          databaseId: DatabaseIds.coffeeId,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      ///
      /// Water
      ///

      case DatabaseIds.waterID:
        _item = new Item(
          title: StringLabels.waterID,
          value: '',
          databaseId: DatabaseIds.waterID,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.date:
        _item = new Item(
          title: StringLabels.date,
          value: DateTime.now(),
          databaseId: DatabaseIds.date,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.ppm:
        _item = new Item(
          title: StringLabels.ppm,
          value: '',
          databaseId: DatabaseIds.ppm,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.gh:
        _item = new Item(
          title: StringLabels.gh,
          value: '',
          databaseId: DatabaseIds.gh,
          placeHolderText: StringLabels.gh,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.kh:
        _item = new Item(
          title: StringLabels.kh,
          value: '',
          databaseId: DatabaseIds.kh,
          placeHolderText: StringLabels.kh,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.ph:
        _item = new Item(
          title: StringLabels.ph,
          value: '',
          databaseId: DatabaseIds.ph,
          placeHolderText: StringLabels.ph,
          keyboardType: TextInputType.number,
        );
        break;

      ///
      /// Coffee
      ///

      case DatabaseIds.country:
        _item = new Item(
          title: StringLabels.country,
          value: '',
          databaseId: DatabaseIds.country,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
          inputViewDataSet: StringDataArrays.countrys
        );
        break;

      case DatabaseIds.region:
        _item = new Item(
          title: StringLabels.region,
          value: '',
          databaseId: DatabaseIds.region,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.farm:
        _item = new Item(
          title: StringLabels.farm,
          value: '',
          databaseId: DatabaseIds.farm,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.producer:
        _item = new Item(
          title: StringLabels.producer,
          value: '',
          databaseId: DatabaseIds.producer,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.lot:
        _item = new Item(
          title: StringLabels.lot,
          value: '',
          databaseId: DatabaseIds.lot,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.altitude:
        _item = new Item(
          title: StringLabels.altitude,
          value: '',
          databaseId: DatabaseIds.altitude,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

       case DatabaseIds.harvest:
        _item = new Item(
          title: StringLabels.harvest,
          value: '',
          databaseId: DatabaseIds.harvest,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      /// Roasting details

      case DatabaseIds.roastDate:
        _item = new Item(
          title: StringLabels.roastDate,
          value: DateTime.now(),
          databaseId: DatabaseIds.roastDate,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.roastProfile:
        _item = new Item(
          title: StringLabels.roastProfile,
          value: '',
          databaseId: DatabaseIds.roastProfile,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.roasteryName:
        _item = new Item(
          title: StringLabels.roasteryName,
          value: '',
          databaseId: DatabaseIds.roasteryName,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.roasterName: 
        _item = new Item(
          title: StringLabels.roasterName,
          value: '',
          databaseId: DatabaseIds.roasterName,
          placeHolderText: StringLabels.enterName,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.beanType:
        _item = new Item(
            title: StringLabels.beanType,
            value: '',
            databaseId: DatabaseIds.beanType,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
            inputViewDataSet: StringDataArrays.beanType);
        break;

      case DatabaseIds.beanSize:
        _item = new Item(
            title: StringLabels.beanSize,
            value: '',
            databaseId: DatabaseIds.beanSize,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
            inputViewDataSet: StringDataArrays.beanSize);
        break;

      case DatabaseIds.processingMethod:
        _item = new Item(
            title: StringLabels.processingMethod,
            value: '',
            databaseId: DatabaseIds.processingMethod,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
            inputViewDataSet: StringDataArrays.processingMethods);
        break;

      case DatabaseIds.density:
        _item = new Item(
          title: StringLabels.density,
          value: '',
          databaseId: DatabaseIds.density,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.aW:
        _item = new Item(
          title: StringLabels.aW,
          value: '',
          databaseId: DatabaseIds.aW,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.moisture:
        _item = new Item(
          title: StringLabels.moisture,
          value: '',
          databaseId: DatabaseIds.moisture,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.number,
        );
        break;

      ///
      /// Grinder
      ///
      
      case DatabaseIds.grinderId:
        _item = new Item(
          title: StringLabels.name,
          value: '',
          databaseId: DatabaseIds.grinderId,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.burrs:
        _item = new Item(
          title: StringLabels.burrs,
          value: '',
          databaseId: DatabaseIds.burrs,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.grinderMake:
        _item = new Item(
          title: StringLabels.make,
          value: '',
          databaseId: DatabaseIds.grinderMake,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.grinderModel:
        _item = new Item(
          title: StringLabels.model,
          value: '',
          databaseId: DatabaseIds.grinderModel,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      ///
      /// Equipment
      ///
      case DatabaseIds.equipmentId:
        _item = new Item(
          title: StringLabels.name,
          value: '',
          databaseId: DatabaseIds.equipmentId,
          placeHolderText: StringLabels.enterName,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.type:
        _item = new Item(
          title: StringLabels.type,
          value: '',
          databaseId: DatabaseIds.type,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.equipmentModel:
        _item = new Item(
          title: StringLabels.model,
          value: '',
          databaseId: DatabaseIds.equipmentModel,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.equipmentMake:
        _item = new Item(
          title: StringLabels.make,
          value: '',
          databaseId: DatabaseIds.equipmentMake,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.method:
        _item = new Item(
          title: StringLabels.method,
          value: '',
          databaseId: DatabaseIds.method,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      ///
      /// BaristarTop
      ///
      
      case DatabaseIds.name:
        _item = new Item(
          title: StringLabels.name,
          value: '',
          databaseId: DatabaseIds.name,
          placeHolderText: StringLabels.enterName,
          keyboardType: TextInputType.text,
        );
        break;

        case DatabaseIds.level:
        _item = new Item(
          title: StringLabels.level,
          value: '',
          databaseId: DatabaseIds.level,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;
    
      
      default:
        _item = new Item(
          title: StringLabels.method,
          value: '',
          databaseId: DatabaseIds.method,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;
    }

    return _item;
  }

 
  static Future<List<Widget>> buildFeedCardArray( BuildContext context, AsyncSnapshot documents, Function(Profile) giveProfile) async {

    List<Widget> _cardArray = new List<Widget>();

     if (documents.data.documents != null || documents.data.documents.length != 0) {

        for(var document in documents.data.documents){  /// <<<<==== changed line
            Widget result = await buildFeedCardFromDocument(context, document,giveProfile);
            _cardArray.add(result);
        }
     }
      return _cardArray;
  }
  
  /// Creat feed Profile from
  static Future<FeedProfileData> createFeedProfileFromProfile(Profile profile)async{

    String image =  await profile.getUserImage();
    String userId = await profile.getProfileUserName();
    return FeedProfileData(profile, userId, image);

  }

  static Future<Widget> buildFeedCardFromProfile(Profile profile, Function(Profile) giveprofile) async {
    
    FeedProfileData feedProfile = await Functions.createFeedProfileFromProfile(profile);

    return SocialProfileCard(feedProfile, giveprofile);
  }

  static Future<Widget> buildFeedCardFromDocument(BuildContext context, DocumentSnapshot document, Function(Profile) giveprofile) async {
    
    Profile profile = await DatabaseFunctions.createProfileFromDocumentSnapshot(DatabaseIds.recipe, document);
    FeedProfileData feedProfile = await Functions.createFeedProfileFromProfile(profile);
    return SocialProfileCard(feedProfile, giveprofile);
  }
  
  static Future<Widget> buildProfileCardFromDocument(DocumentSnapshot document, String databaseId, Function(Profile) giveprofile, Function(Profile) deleteProfile) async {
    
    Profile profile = await DatabaseFunctions.createProfileFromDocumentSnapshot(databaseId, document);

    return ProfileCard(profile, giveprofile, deleteProfile);
  }

  static Future<List<Widget>> buildProfileCardArrayFromAsyncSnapshot( BuildContext context, AsyncSnapshot documents, String databaseId, Function(Profile) giveProfile, Function(Profile) deleteProfile) async {
      
    List<Widget> _cardArray = new List<Widget>();

     if (documents.data.documents != null || documents.data.documents.length != 0) {

        for(var document in documents.data.documents){  /// <<<<==== changed line
            Widget result = await buildProfileCardFromDocument(document, databaseId ,giveProfile, deleteProfile);
            _cardArray.add(result);
        }
     }
      return _cardArray;
  }

  static Future<List<Widget>> buildProfileCardArrayFromProfileList(List<Profile> profileList, String databaseId, Function(Profile) giveProfile, Function(Profile) deleteProfile) async {

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
