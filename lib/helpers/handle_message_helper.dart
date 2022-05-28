import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'toast_message.dart';

class HandleMassageHelper{

  errorMessage(dynamic e,{ String logName = 'ERROR MESSAGE'}){
    if (kDebugMode) { log(e.toString(),name:logName);}
     toastMessage('Error: ' + e.toString()+'❌');
  }

  logMessageWithToast(String message,bool withToastMessage,{ String logName = 'OS:MESSAGE WITH TOAST'}){
    if (kDebugMode) { log(message,name: logName);}
    if(withToastMessage){
      toastMessage(message);
    }
  }

}