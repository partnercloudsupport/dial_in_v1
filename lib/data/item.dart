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

