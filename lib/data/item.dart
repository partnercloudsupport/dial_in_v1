import 'package:flutter/material.dart';



class Item{

     @required String title; 
     @required dynamic value; 
     @required String segueId = '';
     @required String databaseId; 
     @required String placeHolderText; 
     @required List<List<String>> inputViewDataSet = List<List<String>>();
     @required TextInputType keyboardType = TextInputType.text;
    
    Item({
        this.title,
        this.value,
        this.segueId,
        this.databaseId,
        this.placeHolderText,
        this.keyboardType,
        this.inputViewDataSet   
    })
    {
      if (this.inputViewDataSet == null){  this.inputViewDataSet = List<List<String>>(); }
      if (this.segueId == null){  this.segueId = ''; }
      if (this.keyboardType == null){ this.keyboardType = TextInputType.text;}
    }
}

// class Items {
    
//     static Item createItem(String labelName){
        
//         Item item;
        
//         switch (labelName) {
            
//         case StringLabels.method:

//            item = Item(
//               StringLabels.method,
//               "", 
//               "", 
//               ViewControllerIds.method, 
//               DatabaseFunctions.method, 
//               StringLabels.writeADescriptionOfMethod, 
//               TextInputType.text);

//             break;
            
//         case StringLabels.brewingEquipment:

//           item = Item(
//             StringLabels.brewingEquipment,
//             '', 
//             '', 
//             ViewControllerIds.brewingEquipment, 
//             DatabaseFunctions.brewingEquipment, 
//             StringLabels.enterType, 
//             TextInputType.text);
            
//             break;
            
//         case StringLabels.altitude:
            
//           item = Item(
//             StringLabels.altitude,
//             '', 
//             '', 
//             ViewControllerIds.altitude, 
//             DatabaseFunctions.altitude, 
//             StringLabels.enterValue, 
//             TextInputType.number);
            
//             break;
            
//         case StringLabels.baristaName:
            
//             item = Item(
//             StringLabels.baristaName,
//             '', 
//             '', 
//             ViewControllerIds.barista, 
//             DatabaseFunctions.barista, 
//             StringLabels.enterValue, 
//             TextInputType.text);
            
//             break;
            
//         case StringLabels.baristaLevel:
            
//             item = Item(
//                         StringLabels.level,
//                         '', 
//                         '', 
//                         ViewControllerIds.level, 
//                         DatabaseFunctions.level, 
//                         StringLabels.enterInfo, 
//                         TextInputType.text);

//             break;

//         case StringLabels.baristaNotes:
            
//             item = Item(
//                         StringLabels.level,
//                         '', 
//                         '', 
//                         ViewControllerIds.level, 
//                         DatabaseFunctions.level, 
//                         StringLabels.enterInfo, 
//                         TextInputType.text);
            
//             break;



//         case StringLabels.blankItem:
            
//             item = Item(title: "",
//                         value: "",
//                         'segueId: "",'
//                         viewcontrollerId: "",
//                         databaseId:  "",
//                         placeHolderText: "",
//                         inputViewDataSet: nil,
//                         keyboardType: UIKeyboardType.alphabet)
            
//             break;


//         case StringLabels.notes:
            
//             item = Item(title: StringLabels.notes,
//                         value: "",
//                         'segueId: Strings.Segues.tableViewWithTitleToSingleTextFieldPopup,'
//                         viewcontrollerId: Strings.ViewControllerIds.notes,
//                         databaseId:  Strings.DataBaseIds.notes,
//                         placeHolderText: StringLabels.enterInfo,
//                         inputViewDataSet: nil,
//                         keyboardType: UIKeyboardType.alphabet)
            
//                                    break;
 

//         case StringLabels.brewWeight:
            
//             item = Item(title: StringLabels.brewWeight,
//                         value: "",
//                         'segueId: Strings.Segues.mainScreenToAddProfile,'
//                         viewcontrollerId: Strings.ViewControllerIds.brewWeight,
//                         databaseId: Strings.DataBaseIds.brewWeight,
//                         placeHolderText: StringLabels.enterValueGrams,
//                         inputViewDataSet: nil,
//                         keyboardType: UIKeyboardType.decimalPad)

//                                     break;

            
//         case StringLabels.coffeeId:
            
            
//                         break;

//         case StringLabels.barista:
            
            
//                         break;

//         case StringLabels.date:
            
            
//                         break;

//         case StringLabels.brewingEquipment:
            
            
//                         break;

//         case StringLabels.grinder:
            
            
//                         break;

//         case StringLabels.grindSetting:
            
            
//                         break;

//         case StringLabels.brewingDose:
            
            
//         case StringLabels.yield:
            
            
//                         break;

//         case StringLabels.temparature:
            
            
//                         break;

//         case StringLabels.time:
            
            
//                         break;

//         case StringLabels.preinfusion:
            
            
//                         break;

//         case StringLabels.water:
            
            
//                         break;

//         case StringLabels.tds:
            
            
//                         break;

//         case StringLabels.name:
            
            
//                         break;

//         case StringLabels.email:
            
            
//                         break;
            
//         case StringLabels.password:
            
                      
//                         break;

//         default:
            
//                         break;

//             print(StringLabels.Errors.noMatchingCaseInSwitchStatement , " " ,#line, " ", #function , " ", #file)
            
//         }
        

//         guard let finalItem = item else { return
        
//         return finalItem
//     }
    
