import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/item.dart';
import '../database_functions.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/data/images.dart';

class Profile {
  @required
  String userId;
  @required
  DateTime updatedAt;
  @required
  String objectId;
  @required
  String databaseId;
  @required
  List<Item> properties;
  @required
  String image;
  @required
  ProfileType type;
  @required
  String viewContollerId;
  @required
  int referanceNumber;
  @required
  int orderNumber = 0;
  @required
  bool isPublic = true;
  List<Profile> profiles;

  // Is it water , coffee, grinder , machine etc?

  Profile({
      this.userId,
      this.updatedAt,
      this.objectId,
      this.type,
      this.properties,
      this.image,
      this.databaseId,
      this.viewContollerId,
      this.orderNumber,
      this.profiles,
      this.isPublic
      }) {
    switch (type) {
      case ProfileType.recipe:
        this.referanceNumber = 0;
        break;

      case ProfileType.coffee:
        this.referanceNumber = 1;
        break;

      case ProfileType.grinder:
        this.referanceNumber = 2;
        break;

      case ProfileType.equipment:
        this.referanceNumber = 3;
        break;

      case ProfileType.water:
        this.referanceNumber = 4;
        break;

      case ProfileType.barista:
        this.referanceNumber = 5;
        break;

      default:
        break;
    }
    // setDefaultPic();
  }

  //  Future<void> setDefaultPic()async{if (this.image == null){ this.image = await Functions.getFile(Images.recipeSmaller);}}

  void setProfileItemValue(String itemDatabaseId, dynamic value) {
    if (value != null){
      for (var i = 0; i < this.properties.length; i++) {
        if (this.properties[i].databaseId == itemDatabaseId) {
          this.properties[i].value = value;
        }
      }
    }  
  }

  dynamic getProfileItemValue(String itemDatabaseId) {
    
    dynamic value;
    for (var i = 0; i < this.properties.length; i++) {
      if (this.properties[i].databaseId == itemDatabaseId) {
        value = this.properties[i].value;
      }
    }

    
    if (value == null) {
      if(itemDatabaseId == DatabaseIds.date || itemDatabaseId == DatabaseIds.roastDate)
      { return DateTime.now();}
      else{return '';}
    } else {
      return value;
    }
  }

  Item getProfileItem(String itemDatabaseId){
    
    Item item;
    for (var i = 0; i < this.properties.length; i++) {
      if (this.properties[i].databaseId == itemDatabaseId) {
        item = this.properties[i];
      }
    }

    if (item == null) {
      return Item();
    } else {
      return item;
    }
  } 


  void setProfileProfileTitleValue({String profileDatabaseId, String profileDatabaseIdref}) {
    for (var i = 0; i < this.profiles.length; i++) {
      if (this.profiles[i].databaseId == profileDatabaseId) {
        switch (profileDatabaseId) {
          case DatabaseIds.recipe:
            setProfileItemValue(
                 DatabaseIds.recipeId,
                 profileDatabaseIdref);
            break;

          case DatabaseIds.coffee:
            setProfileItemValue(
                 DatabaseIds.coffeeId,
                 profileDatabaseIdref);
            break;

          case DatabaseIds.water:
            setProfileItemValue(
                 DatabaseIds.waterID,
                 profileDatabaseIdref);
            break;

          case DatabaseIds.brewingEquipment:
            setProfileItemValue(
                 DatabaseIds.equipmentId,
                 profileDatabaseIdref);
            break;

          case DatabaseIds.grinder:
            setProfileItemValue(
                 DatabaseIds.grinderId,
                 profileDatabaseIdref);
            break;

          case DatabaseIds.barista:
            setProfileItemValue(
                 DatabaseIds.name,  profileDatabaseIdref);
            break;

          default:
            break;
        }
      }
    }
  }

Future<String> getUserImage ()async{
  
  String imageUrl = await DatabaseFunctions.getValueFromFireStoreWithDocRef(DatabaseIds.User, this.userId, DatabaseIds.image);

  return imageUrl;
} 

 dynamic getProfileProfileItemValue(ProfileType profiletype, String itemDatabaseId) {
  dynamic value = '';
   if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].type == profiletype) {
          for (var x = 0; x < this.profiles[i].properties.length; x++) {
            if (this.profiles[i].properties[x].databaseId == itemDatabaseId){
              value = this.profiles[i].properties[x].value;
            }
          }
        }
      }
   }
   return value;
 }

 Item getProfileProfileItem(ProfileType profiletype, String itemDatabaseId) {
  Item value;
   if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].type == profiletype) {
          for (var x = 0; x < this.profiles[i].properties.length; x++) {
            if (this.profiles[i].properties[x].databaseId == itemDatabaseId){
              value = this.profiles[i].properties[x];
            }
          }
        }
      }
   }
   return value;
 }

 dynamic getProfileProfileImage(ProfileType profiletype) {
  dynamic value;
   if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].type == profiletype) {
              value = this.profiles[i].image;
        }
      }
   }
   return value;
 }

 Profile getProfileProfile(ProfileType profiletype) {
  Profile value;
   if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].type == profiletype) {
              value = this.profiles[i];
        }
      }
   }
   return value;
 }

 Future<String> getProfileUserName()async{
   
  String userId = await DatabaseFunctions.getValueFromFireStoreWithDocRef(DatabaseIds.User, this.userId, DatabaseIds.userName);

  return userId;
 }

  // dynamic getProfileTotalScoreValue(){
//   dynamic value = 0;
//    if (this.type == ProfileType.recipe) {
//       for (var i = 0; i < this.profiles.length; i++) {
//         if (this.profiles[i].type == ProfileType.recipe) {
//           for (var x = 0; x < this.profiles[i].properties.length; x++) {
//             if (
//               this.profiles[i].properties[x].databaseId == DatabaseIds.balance ||
//               this.profiles[i].properties[x].databaseId == DatabaseIds.strength ||
//               this.profiles[i].properties[x].databaseId == DatabaseIds.flavour ||
//               this.profiles[i].properties[x].databaseId == DatabaseIds.afterTaste ||
//               this.profiles[i].properties[x].databaseId == DatabaseIds.acidic ||
//               this.profiles[i].properties[x].databaseId == DatabaseIds.body 
//               )
              
//               {
//               value = value + this.profiles[i].properties[x].value;
//               }
//         }
//       }
//      }
//    }
//     return value;
//  }

  String getProfileProfileTitleValue({String profileDatabaseId}) {
    String value = 'Error';

    if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].databaseId == profileDatabaseId) {
          switch (profileDatabaseId) {
            case DatabaseIds.recipe:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.recipeId);
              break;

            case DatabaseIds.coffee:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.coffeeId);
              break;

            case DatabaseIds.water:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.waterID);
              break;

            case DatabaseIds.brewingEquipment:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.equipmentId);
              break;

            case DatabaseIds.grinder:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.grinderId);
              break;

            case DatabaseIds.Barista:
              value = this.profiles[i].getProfileItemValue( DatabaseIds.name);
              break;

            case DatabaseIds.score:
              value = (this.profiles[i].getProfileItemValue( DatabaseIds.strength) +
                      this.profiles[i].getProfileItemValue( DatabaseIds.balance) +
                      this.profiles[i].getProfileItemValue( DatabaseIds.flavour) +
                      this.profiles[i].getProfileItemValue( DatabaseIds.body) +
                      this.profiles[i].getProfileItemValue( DatabaseIds.afterTaste)).toString();
              break;  

            default:
              value = 'Error';
              break;
          }
        }
      }
    }
    return value;
  }
  
  String getProfileTitleValue() {
  String value = 'Error';
   switch (this.databaseId) {
            case DatabaseIds.recipe:
              value = this.getProfileItemValue( DatabaseIds.recipeId);
              break;

            case DatabaseIds.coffee:
              value = this.getProfileItemValue( DatabaseIds.coffeeId);
              break;

            case DatabaseIds.water:
              value = this.getProfileItemValue( DatabaseIds.waterID);
              break;

            case DatabaseIds.brewingEquipment:
              value = this.getProfileItemValue( DatabaseIds.equipmentId);
              break;

            case DatabaseIds.grinder:
              value = this.getProfileItemValue( DatabaseIds.grinderId);
              break;

            case DatabaseIds.Barista:
              value = this.getProfileItemValue( DatabaseIds.name);
              break;

            case DatabaseIds.score:
            value = (this.getProfileItemValue( DatabaseIds.strength) +
                      this.getProfileItemValue( DatabaseIds.balance) +
                      this.getProfileItemValue( DatabaseIds.flavour) +
                      this.getProfileItemValue( DatabaseIds.body) +
                      this.getProfileItemValue( DatabaseIds.afterTaste)).toString();
              break;  
   }
   return value;
 }

  String getProfileProfileRefernace({String profileDatabaseId}) {
    String value = '';

    if (this.profiles != null) {
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].databaseId == profileDatabaseId) {
              value = this.profiles[i].objectId;
        }
      }
    }
    return value;
  }

  void setSubProfile(Profile profile) {
    if (this.profiles != null){
      for (var i = 0; i < this.profiles.length; i++) {
        if (this.profiles[i].type == profile.type) {
          this.profiles[i] = profile;
        }
      }
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
          value: '0',
          databaseId: DatabaseIds.flavour,
          placeHolderText: StringLabels.flavour,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.body:
        _item = new Item(
          title: StringLabels.body,
          value: '0',
          databaseId: DatabaseIds.body,
          placeHolderText: StringLabels.enterValue,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.balance:
        _item = new Item(
          title: StringLabels.balance,
          value: '0',
          databaseId: DatabaseIds.balance,
          placeHolderText: StringLabels.enterValue,
          keyboardType: TextInputType.number,
        );
        break;

      case DatabaseIds.afterTaste:
        _item = new Item(
          title: StringLabels.afterTaste,
          value: '0',
          databaseId: DatabaseIds.afterTaste,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.strength:
        _item = new Item(
          title: StringLabels.strength,
          value: '0',
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

  static Item createItemWithData(Map<String, dynamic> item) {
    Item _item;

    item.forEach((key, aValue) {
      dynamic value;

      if (aValue != null) {
        value = aValue;
      } else {
        value = '';
      }
      switch (key) {

        ///
        /// Recipe
        ///
        case DatabaseIds.date:
          _item = new Item(
            title: StringLabels.date,
            value: value,
            databaseId: DatabaseIds.date,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.equipmentId:
          _item = new Item(
            title: StringLabels.brewingEquipment,
            value: value,
            databaseId: DatabaseIds.equipmentId,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.grinderId:
          _item = new Item(
            title: StringLabels.grinder,
            value: value,
            databaseId: DatabaseIds.grinderId,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.grindSetting:
          _item = new Item(
            title: StringLabels.grindSetting,
            value: value,
            databaseId: DatabaseIds.grindSetting,
            placeHolderText: StringLabels.enterValue,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.waterID:
          _item = new Item(
            title: StringLabels.water,
            value: value,
            databaseId: DatabaseIds.waterID,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.temparature:
          _item = new Item(
            title: StringLabels.temparature,
            value: value,
            databaseId: DatabaseIds.temparature,
            placeHolderText: StringLabels.enterTemparature,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.brewingDose:
          _item = new Item(
            title: StringLabels.brewingDose,
            value: value,
            databaseId: DatabaseIds.brewingDose,
            placeHolderText: StringLabels.enterValue,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.preinfusion:
          _item = new Item(
            title: StringLabels.preinfusion,
            value: value,
            databaseId: DatabaseIds.preinfusion,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.yielde:
          _item = new Item(
            title: StringLabels.yielde,
            value: value,
            databaseId: DatabaseIds.yielde,
            placeHolderText: StringLabels.enterValue,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.brewWeight:
          _item = new Item(
            title: StringLabels.brewWeight,
            value: value,
            databaseId: DatabaseIds.brewWeight,
            placeHolderText: StringLabels.enterValue,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.time:
          _item = new Item(
            title: StringLabels.time,
            value: value,
            databaseId: DatabaseIds.time,
            placeHolderText: StringLabels.enterValue,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.tds:
          _item = new Item(
            title: StringLabels.tds,
            value: value,
            databaseId: DatabaseIds.tds,
            placeHolderText: StringLabels.enterValue,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.notes:
          _item = new Item(
            title: StringLabels.notes,
            value: value,
            databaseId: DatabaseIds.notes,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.flavour:
          _item = new Item(
            title: StringLabels.flavour,
            value: value,
            databaseId: DatabaseIds.flavour,
            placeHolderText: StringLabels.flavour,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.body:
          _item = new Item(
            title: StringLabels.body,
            value: value,
            databaseId: DatabaseIds.body,
            placeHolderText: StringLabels.enterValue,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.balance:
          _item = new Item(
            title: StringLabels.balance,
            value: value,
            databaseId: DatabaseIds.balance,
            placeHolderText: StringLabels.enterValue,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.afterTaste:
          _item = new Item(
            title: StringLabels.afterTaste,
            value: value,
            databaseId: DatabaseIds.afterTaste,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.descriptors:
          _item = new Item(
            title: StringLabels.descriptors,
            value: value,
            databaseId: DatabaseIds.descriptors,
            placeHolderText: StringLabels.descriptors,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.coffeeId:
          _item = new Item(
            title: StringLabels.coffee,
            value: value,
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
            value: value,
            databaseId: DatabaseIds.waterID,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.date:
          _item = new Item(
            title: StringLabels.date,
            value: value,
            databaseId: DatabaseIds.date,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.ppm:
          _item = new Item(
            title: StringLabels.ppm,
            value: value,
            databaseId: DatabaseIds.ppm,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.gh:
          _item = new Item(
            title: StringLabels.gh,
            value: value,
            databaseId: DatabaseIds.gh,
            placeHolderText: StringLabels.gh,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.kh:
          _item = new Item(
            title: StringLabels.kh,
            value: value,
            databaseId: DatabaseIds.kh,
            placeHolderText: StringLabels.kh,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.ph:
          _item = new Item(
            title: StringLabels.ph,
            value: value,
            databaseId: DatabaseIds.ph,
            placeHolderText: StringLabels.ph,
            keyboardType: TextInputType.number,
          );
          break;

        ///
        /// Coffee
        ///

        case DatabaseIds.region:
          _item = new Item(
            title: StringLabels.region,
            value: value,
            databaseId: DatabaseIds.region,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.farm:
          _item = new Item(
            title: StringLabels.farm,
            value: value,
            databaseId: DatabaseIds.farm,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.producer:
          _item = new Item(
            title: StringLabels.producer,
            value: value,
            databaseId: DatabaseIds.producer,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.lot:
          _item = new Item(
            title: StringLabels.lot,
            value: value,
            databaseId: DatabaseIds.lot,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.altitude:
          _item = new Item(
            title: StringLabels.altitude,
            value: value,
            databaseId: DatabaseIds.altitude,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.country:
          _item = new Item(
            title: StringLabels.country,
            value: value,
            databaseId: DatabaseIds.country,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

         case DatabaseIds.harvest:
          _item = new Item(
            title: StringLabels.harvest,
            value: value,
            databaseId: DatabaseIds.harvest,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        /// Roasting details

        case DatabaseIds.roastDate:
          _item = new Item(
            title: StringLabels.roastDate,
            value: value,
            databaseId: DatabaseIds.roastDate,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.roastProfile:
          _item = new Item(
            title: StringLabels.roastProfile,
            value: value,
            databaseId: DatabaseIds.roastProfile,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.roasteryName:
          _item = new Item(
            title: StringLabels.roasteryName,
            value: value,
            databaseId: DatabaseIds.roasteryName,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.roasterName:
          _item = new Item(
            title: StringLabels.roasterName,
            value: value,
            databaseId: DatabaseIds.roasterName,
            placeHolderText: StringLabels.enterName,
            keyboardType: TextInputType.text,
          );
          break;  

        case DatabaseIds.beanType:
          _item = new Item(
              title: StringLabels.beanType,
              value: value,
              databaseId: DatabaseIds.beanType,
              placeHolderText: StringLabels.enterDescription,
              keyboardType: TextInputType.text,
              inputViewDataSet: StringDataArrays.beanType);
          break;

        case DatabaseIds.beanSize:
          _item = new Item(
              title: StringLabels.beanSize,
              value: value,
              databaseId: DatabaseIds.beanSize,
              placeHolderText: StringLabels.enterDescription,
              keyboardType: TextInputType.text,
              inputViewDataSet: StringDataArrays.beanSize);
          break;

        case DatabaseIds.processingMethod:
          _item = new Item(
              title: StringLabels.processingMethod,
              value: value,
              databaseId: DatabaseIds.processingMethod,
              placeHolderText: StringLabels.enterDescription,
              keyboardType: TextInputType.text,
              inputViewDataSet: StringDataArrays.processingMethods);
          break;

        case DatabaseIds.density:
          _item = new Item(
            title: StringLabels.density,
            value: value,
            databaseId: DatabaseIds.density,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.aW:
          _item = new Item(
            title: StringLabels.aW,
            value: value,
            databaseId: DatabaseIds.aW,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.number,
          );
          break;

        case DatabaseIds.moisture:
          _item = new Item(
            title: StringLabels.moisture,
            value: value,
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
            title: StringLabels.grinderId,
            value: value,
            databaseId: DatabaseIds.grinderId,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.burrs:
          _item = new Item(
            title: StringLabels.burrs,
            value: value,
            databaseId: DatabaseIds.burrs,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.grinderMake:
          _item = new Item(
            title: StringLabels.grinderMake,
            value: value,
            databaseId: DatabaseIds.grinderMake,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.grinderModel:
          _item = new Item(
            title: StringLabels.grinderModel,
            value: value,
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
            value: value,
            databaseId: DatabaseIds.equipmentId,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.equipmentModel:
          _item = new Item(
            title: StringLabels.equipmentModel,
            value: value,
            databaseId: DatabaseIds.equipmentModel,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.method:
          _item = new Item(
            title: StringLabels.method,
            value: value,
            databaseId: DatabaseIds.method,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.type:
           _item = new Item(
          title: StringLabels.type,
          value: value,
          databaseId: DatabaseIds.type,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

      case DatabaseIds.equipmentMake:
        _item = new Item(
          title: StringLabels.make,
          value: value,
          databaseId: DatabaseIds.equipmentMake,
          placeHolderText: StringLabels.enterDescription,
          keyboardType: TextInputType.text,
        );
        break;

        ///
        /// Barista
        ///

        case DatabaseIds.level:
          _item = new Item(
            title: StringLabels.level,
            value: value,
            databaseId: DatabaseIds.level,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.name:
          _item = new Item(
            title: StringLabels.name,
            value: value,
            databaseId: DatabaseIds.name,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.age:
          _item = new Item(
            title: StringLabels.age,
            value: value,
            databaseId: DatabaseIds.age,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;

        case DatabaseIds.notes:
          _item = new Item(
            title: StringLabels.notes,
            value: value,
            databaseId: DatabaseIds.notes,
            placeHolderText: StringLabels.enterDescriptors,
            keyboardType: TextInputType.text,
          );
          break;

        default:
          _item = new Item(
            title: StringLabels.method,
            value: value,
            databaseId: DatabaseIds.method,
            placeHolderText: StringLabels.enterDescription,
            keyboardType: TextInputType.text,
          );
          break;
      }
    });
    return _item;
  }

/// Profile Spercific Functions

  double getTotalScore(){

    List<double> scores = [
      double.parse(this.getProfileItemValue(DatabaseIds.strength),),
      double.parse(this.getProfileItemValue(DatabaseIds.balance)),
      double.parse(this.getProfileItemValue(DatabaseIds.flavour)),
      double.parse(this.getProfileItemValue(DatabaseIds.body)),
      double.parse(this.getProfileItemValue(DatabaseIds.afterTaste)),
    ];
    
    double finalscore = scores.reduce((value, element) => value + element);

    return finalscore;
  }  

  int getDaysRested(){
    DateTime coffeeRoastDate = getProfileProfileItemValue(ProfileType.coffee, DatabaseIds.roastDate);
    DateTime recipeMadeTime = getProfileItemValue(DatabaseIds.date);
    int result = recipeMadeTime.difference(coffeeRoastDate).inDays;
    print(coffeeRoastDate);
    print(recipeMadeTime);
    return result;
  }
}

enum ProfileType {
  recipe,
  coffee,
  water,
  grinder,
  equipment,
  barista,
  feed,
  none
}
