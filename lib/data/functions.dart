import 'item.dart';
import '../database_functions.dart';
import 'strings.dart';
import 'package:flutter/material.dart';



class Functions{

  Item createItem(Map<String, dynamic> item){

    String key = item.keys.first.toString();
    
    switch (key){

///
/// Recipe
/// 
    case DatabaseFunctions.date:   
      
      return Item(
        title: StringLabels.date , value: item.toString() ,
        databaseId: DatabaseFunctions.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.equipmentId:   
      
      return Item(
        title: StringLabels.brewingEquipment , value: item.toString() ,
        databaseId: DatabaseFunctions.equipmentId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grinderId:   
      
      return Item(
        title: StringLabels.grinder , value: item.toString() ,
        databaseId: DatabaseFunctions.grinderId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grindSetting:   
      
      return Item(
        title: StringLabels.grindSetting , value: item.toString() ,
        databaseId: DatabaseFunctions.grindSetting, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.waterID:   
      
      return Item(
        title: StringLabels.water , value: item.toString() ,
        databaseId: DatabaseFunctions.waterID, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.temparature:   
      
      return Item(
        title: StringLabels.temparature , value: item.toString() ,
        databaseId: DatabaseFunctions.temparature, 
        placeHolderText: StringLabels.enterTemparature,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.brewingDose:   
      
      return Item(
        title: StringLabels.brewingDose , value: item.toString() ,
        databaseId: DatabaseFunctions.brewingDose, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.preinfusion:   
      
      return Item(
        title: StringLabels.preinfusion , value: item.toString() ,
        databaseId: DatabaseFunctions.preinfusion, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.yield:   
      
      return Item(
        title: StringLabels.yield , value: item.toString() ,
        databaseId: DatabaseFunctions.yield, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.brewWeight:   
      
      return Item(
        title: StringLabels.brewWeight , value: item.toString() ,
        databaseId: DatabaseFunctions.brewWeight, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.time:   
      
      return Item(
        title: StringLabels.time , value: item.toString() ,
        databaseId: DatabaseFunctions.time, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.tds:   
      
      return Item(
        title: StringLabels.tds , value: item.toString() ,
        databaseId: DatabaseFunctions.tds, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;
      

    case DatabaseFunctions.notes:   
      
      return Item(
        title: StringLabels.brewingEquipment , value: item.toString() ,
        databaseId: DatabaseFunctions.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.flavour:   
      
      return Item(
        title: StringLabels.flavour , value: item.toString() ,
        databaseId: DatabaseFunctions.flavour, 
        placeHolderText: StringLabels.flavour,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.body:   
      
      return Item(
        title: StringLabels.body , value: item.toString() ,
        databaseId: DatabaseFunctions.body, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.balance:   
      
      return Item(
        title: StringLabels.balance , value: item.toString() ,
        databaseId: DatabaseFunctions.balance, 
        placeHolderText: StringLabels.enterValue,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.afterTaste:   
      
      return Item(
        title: StringLabels.afterTaste , value: item.toString() ,
        databaseId: DatabaseFunctions.afterTaste, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.descriptors:   
      
      return Item(
        title: StringLabels.descriptors , value: item.toString() ,
        databaseId: DatabaseFunctions.descriptors, 
        placeHolderText: StringLabels.descriptors,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.coffeeId:   
      
      return Item(
        title: StringLabels.coffee , value: item.toString() ,
        databaseId: DatabaseFunctions.coffeeId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;


///
/// Water
/// 

    case DatabaseFunctions.waterID:   
      
      return Item(
        title: StringLabels.waterID , value: item.toString() ,
        databaseId: DatabaseFunctions.waterID, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.date:   
      
      return Item(
        title: StringLabels.date , value: item.toString() ,
        databaseId: DatabaseFunctions.date, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.ppm:   
      
      return Item(
        title: StringLabels.ppm , value: item.toString() ,
        databaseId: DatabaseFunctions.ppm, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.gh:   
      
      return Item(
        title: StringLabels.gh , value: item.toString() ,
        databaseId: DatabaseFunctions.gh, 
        placeHolderText: StringLabels.gh,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.kh:   
      
      return Item(
        title: StringLabels.kh , value: item.toString() ,
        databaseId: DatabaseFunctions.kh, 
        placeHolderText: StringLabels.kh,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.ph:   
      
      return Item(
        title: StringLabels.ph , value: item.toString() ,
        databaseId: DatabaseFunctions.ph, 
        placeHolderText: StringLabels.ph,
        keyboardType: TextInputType.number,);
      break;


///
/// Coffee
/// 

    case DatabaseFunctions.region:   
      
      return Item(
        title: StringLabels.region , value: item.toString() ,
        databaseId: DatabaseFunctions.region, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.farm:   
      
      return Item(
        title: StringLabels.farm , value: item.toString() ,
        databaseId: DatabaseFunctions.farm, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.producer:   
      
      return Item(
        title: StringLabels.producer , value: item.toString() ,
        databaseId: DatabaseFunctions.producer, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.lot:   
      
      return Item(
        title: StringLabels.lot , value: item.toString() ,
        databaseId: DatabaseFunctions.lot, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.altitude:   
      
      return Item(
        title: StringLabels.altitude , value: item.toString() ,
        databaseId: DatabaseFunctions.altitude, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

/// Roasting details

    case DatabaseFunctions.roastDate:   
      
      return Item(
        title: StringLabels.roastDate , value: item.toString() ,
        databaseId: DatabaseFunctions.roastDate, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.roastProfile:   
      
      return Item(
        title: StringLabels.roastProfile , value: item.toString() ,
        databaseId: DatabaseFunctions.roastProfile, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.roasteryName:   
      
      return Item(
        title: StringLabels.roasteryName , value: item.toString() ,
        databaseId: DatabaseFunctions.roasteryName, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.beanType:   
      
      return Item(
        title: StringLabels.beanType , value: item.toString() ,
        databaseId: DatabaseFunctions.beanType, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.beanType);
      break;

    case DatabaseFunctions.beanSize:   
      
      return Item(
        title: StringLabels.beanSize , value: item.toString() ,
        databaseId: DatabaseFunctions.beanSize, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.beanSize);
      break;

    case DatabaseFunctions.processingMethod:   
      
      return Item(
        title: StringLabels.processingMethod , value: item.toString() ,
        databaseId: DatabaseFunctions.processingMethod, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,
        inputViewDataSet: StringDataArrays.processingMethods);
      break;

    case DatabaseFunctions.density:   
      
      return Item(
        title: StringLabels.density , value: item.toString() ,
        databaseId: DatabaseFunctions.density, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.aW:   
      
      return Item(
        title: StringLabels.aW , value: item.toString() ,
        databaseId: DatabaseFunctions.aW, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

    case DatabaseFunctions.moisture:   
      
      return Item(
        title: StringLabels.moisture , value: item.toString() ,
        databaseId: DatabaseFunctions.moisture, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.number,);
      break;

///
/// Grinder
///
    case DatabaseFunctions.grinderId:   
      
      return Item(
        title: StringLabels.grinderId , value: item.toString() ,
        databaseId: DatabaseFunctions.grinderId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.burrs:   
      
      return Item(
        title: StringLabels.burrs , value: item.toString() ,
        databaseId: DatabaseFunctions.burrs, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grinderMake:   
      
      return Item(
        title: StringLabels.grinderMake , value: item.toString() ,
        databaseId: DatabaseFunctions.grinderMake, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.grinderModel:   
      
      return Item(
        title: StringLabels.grinderModel , value: item.toString() ,
        databaseId: DatabaseFunctions.grinderModel, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;


///
/// Equipment
///
    case DatabaseFunctions.equipmentId:   
      
      return Item(
        title: StringLabels.equipmentId , value: item.toString() ,
        databaseId: DatabaseFunctions.equipmentId, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.equipmentType:   
      
      return Item(
        title: StringLabels.equipmentType , value: item.toString() ,
        databaseId: DatabaseFunctions.equipmentType, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.equipmentModel:   
      
      return Item(
        title: StringLabels.equipmentModel , value: item.toString() ,
        databaseId: DatabaseFunctions.equipmentModel, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    case DatabaseFunctions.method:   
      
      return Item(
        title: StringLabels.method , value: item.toString() ,
        databaseId: DatabaseFunctions.method, 
        placeHolderText: StringLabels.enterDescription,
        keyboardType: TextInputType.text,);
      break;

    }
  }
}