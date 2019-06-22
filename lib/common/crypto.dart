import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tripledes/tripledes.dart';

import 'utils.dart';
import 'package:rave_pay/common/rave_pay.dart';

class Crypto {

  static Future<String> encryptAsync(String data) async {
    return compute(encrypt, data);
  }

  static String encrypt(String data) {
    Utils.hasEncryptionKey();
    var blockCipher = BlockCipher(TripleDESEngine(), RavePay.encryptionKey);
    return blockCipher.encodeB64(data);
  }

  // static Future<String> encrypt(String data) async {
  //   var completer = Completer<String>();
  //   Utils.hasEncryptionKey();
  //   var blockCipher = BlockCipher(TripleDESEngine(), RavePay.encryptionKey);
  //   var ciphertext = blockCipher.encodeB64(data);
  //   try {
  //     String result = await Utils.channel.invokeMethod('getEncryptedData',
  //         {"stringData": data, "encryptionKey": RavePay.encryptionKey});
  //     completer.complete(result);
  //   } on PlatformException catch (e) {
  //     completer.completeError(e);
  //   }

  //   return completer.future;
  // }
}
