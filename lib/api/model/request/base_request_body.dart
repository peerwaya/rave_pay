import 'package:rave_pay/common/platform_info.dart';

abstract class BaseRequestBody {
  final fieldDevice = 'device';
  String _deviceFingerPrint;

  BaseRequestBody() {
    _setDeviceId();
  }

  Map<String, String> paramsMap();

  String get deviceFingerPrint => _deviceFingerPrint;

  _setDeviceId() {
    String deviceFingerPrint = PlatformInfo().deviceFingerPrint ?? '';
    this._deviceFingerPrint = deviceFingerPrint;
  }
}
