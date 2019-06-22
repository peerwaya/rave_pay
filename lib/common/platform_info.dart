/// Holds data that's different on Android and iOS
class PlatformInfo {
  static String _userAgent;
  static String _deviceFingerPrint;

  static final PlatformInfo _platformSpecificInfo =
     PlatformInfo._internal();

  factory PlatformInfo() {
    return _platformSpecificInfo;
  }

  PlatformInfo._internal();

  set userAgent(String value) => _userAgent = value;


  set deviceFingerPrint(String value) => _deviceFingerPrint = value;

  String get userAgent {
    _validateValue(_userAgent);
    return _userAgent;
  }

  String get deviceFingerPrint {
    _validateValue(_deviceFingerPrint);
    return _deviceFingerPrint;
  }

  _validateValue(String value) {
    if (value == null || value.isEmpty) {
      throw Exception('Has you initialized RavePay SDK?');
    }
  }

  @override
  String toString() {
    return '[userAgent = $userAgent, deviceFingerPrint = $_deviceFingerPrint]';
  }
}
