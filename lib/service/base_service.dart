import 'dart:convert';
import 'dart:io';

import 'package:rave_pay/common/platform_info.dart';
import 'package:rave_pay/common/rave_pay.dart';

class BaseApiService {
  final Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    HttpHeaders.userAgentHeader: PlatformInfo().userAgent,
    HttpHeaders.acceptHeader: 'application/json',
    'X-FLUTTER-USER-AGENT':
        jsonEncode({'lang': Platform.isIOS ? 'objective-c' : 'kotlin'}),
  };
  final String baseUrl = RavePay.isSandbox
      ? 'https://ravesandboxapi.flutterwave.com'
      : 'https://api.ravepay.co';
}
