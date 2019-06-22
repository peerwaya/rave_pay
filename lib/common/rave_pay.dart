
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'index.dart';

final MethodChannel _channel =
    const MethodChannel('rave_pay');

class RavePay {
  static String _publicKey;
  static String _encryptionKey;
  static bool _isSandbox;

  static bool _inititalized = false;

  RavePay._internal();

  static final RavePay instance = RavePay._internal();

  /// Initialize the RavePay
  ///
  /// [publicKey] - your flutterwave public key. This is mandatory
  ///
  /// [encryptionKey] flutterwave encryption key
  ///
  ///
  static Future<void> initialize(
      {@required String publicKey, @required String encryptionKey, bool isSandbox}) async {
    assert(publicKey != null || publicKey.isEmpty,
        'publicKey cannot be null or empty');
    assert(encryptionKey != null || encryptionKey.isEmpty,
        'encryptionKey cannot be null or empty');
    if (_inititalized) {
      return null;
    }
    try {
      final Map<dynamic, dynamic> response =
          await _channel.invokeMethod('initialize');
      _publicKey = publicKey;
      _encryptionKey = encryptionKey;
      _isSandbox = isSandbox;
      PlatformInfo()
        ..userAgent = response['userAgent']
        ..deviceFingerPrint = response['deviceFingerPrint'];
      _inititalized = true;
    } on PlatformException {
      rethrow;
    }
  }

  static bool get sdkInitialized => _inititalized;

  static bool get isSandbox => _isSandbox;

  static String get publicKey {
    // Validate that the sdk has been initialized
    Utils.validateSdkInitialized();
    return _publicKey;
  }

  static String get encryptionKey {
    // Validate that the sdk has been initialized
    Utils.validateSdkInitialized();
    return _encryptionKey;
  }
}
