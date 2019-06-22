import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rave_pay/common/rave_pay.dart';
import 'exceptions.dart';

class Utils {
  static const MethodChannel channel = const MethodChannel('flutter_paystack');

  static validateSdkInitialized() {
    if (!RavePay.sdkInitialized) {
      throw new SdkNotInitializedException(
          'RavePay SDK has not been initialized. The SDK has'
          ' to be initialized before use');
    }
  }

  static hasPublicKey() {
    var publicKey = RavePay.publicKey;
    if (publicKey == null || publicKey.isEmpty) {
      throw RavePayException('No Public key found, please set the Public key.');
    }
  }

  static hasEncryptionKey() {
    var publicKey = RavePay.publicKey;
    if (publicKey == null || publicKey.isEmpty) {
      throw RavePayException(
          'No Encryption key found, please set the Encryption key.');
    }
  }

  static String getKeyErrorMsg(String keyType) {
    return 'Invalid $keyType key. You must use a valid $keyType key. Ensure that you '
        'have set a $keyType key. Check https://ravepay.co for more';
  }

  static validatePlatformSpecificInfo() {}

  static validateChargeAndKey(dynamic charge) {
    String publicKey = RavePay.publicKey;
    String encryptionKey = RavePay.encryptionKey;

    if (publicKey == null ||
        publicKey.isEmpty ||
        !publicKey.startsWith("FLWPUBK_")) {
      throw new AuthenticationException(Utils.getKeyErrorMsg('public'));
    }

    if (encryptionKey == null || encryptionKey.isEmpty) {
      throw new AuthenticationException(Utils.getKeyErrorMsg('encryptionKey'));
    }

    if (charge == null) {
      throw new RavePayException('charge must not be null');
    }
    if (charge.amount == null || charge.amount.isNegative) {
      throw new InvalidAmountException(charge.amount);
    }
    if (charge.email == null || charge.email.isEmpty) {
      throw new InvalidEmailException(charge.email);
    }
  }

  static Map<String, dynamic> asStringKeyedMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;
    if (map is Map<String, dynamic>) {
      return map;
    } else {
      return Map<String, dynamic>.from(map);
    }
  }
}
