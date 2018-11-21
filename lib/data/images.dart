import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'dart:math';


class Images{

    static String cherries = 'assets/images/cherries.jpg';
    static String dialInWhiteLogo = 'assets/images/DialInWhiteLogo.png';
    static String user = 'assets/images/user.png';
    static String backIcon = 'assets/images/back_icon.png';
    static String cherriestwo = 'assets/images/cherriestwo.jpg';
    static String addProfileButtonWithOrangeTint = 'assets/images/addProfileButtonWithOrangeTint.png';
    static String logout = 'assets/images/logout.png';
    static String aeropressSmaller512x512 = 'assets/images/aeropressSmaller512x512.png';
    static String drop = 'assets/images/drop.png';
    static String whiteRecipe200X200 = 'assets/images/whiteRecipe200X200.png';
    static String beanSmaller512x512 = 'images/coffee-beanSmaller512x512.png';
    static String coffeeBeans = 'assets/images/coffee-beanSmaller512x512.png';
    static String grinder = 'assets/images/grinderSmaller512x512.png';
    static String groupHandle = 'assets/images/whiteGrouphandle80x80@2x.png';
    static String water = 'assets/images/drop.png';


  static  Future<void> getFile(String filePath, Function(File) completion) async{

    final ByteData bytes = await rootBundle.load(filePath);
    final Directory tempDir = Directory.systemTemp;
    final String fileName = "${Random().nextInt(10000)}.jpg";
    final File file = File('${tempDir.path}/$fileName');
    file.writeAsBytes(bytes.buffer.asInt8List(),mode: FileMode.write);

   completion(file);
  }
}