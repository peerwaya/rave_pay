import 'api_response.dart';
import 'package:rave_pay/common/utils.dart';

class InitiatePaymentResponse extends ApiResponse {
  final String reference;
  final String trans;
  final String authModelUsed;
  final String otpMessage;
  final String displayText;
  final String authUrl;
  final String chargeResponseCode;
  final String chargeResponseMessage;

  InitiatePaymentResponse._internal(
      {this.reference,
      this.trans,
      this.authModelUsed,
      this.otpMessage,
      this.displayText,
      this.authUrl,
      this.chargeResponseCode,
      this.chargeResponseMessage,
      String status,
      String message})
      : super(status: status, message: message);

  InitiatePaymentResponse.unknownServerResponse()
      : reference = null,
        trans = null,
        authModelUsed = null,
        otpMessage = null,
        displayText = null,
        authUrl = null,
        chargeResponseCode = null,
        chargeResponseMessage = null,
        super(status: '0', message: 'Unknown server response');

  factory InitiatePaymentResponse.fromMap(Map<String, dynamic> map) {
    final data = Utils.asStringKeyedMap(map['data']);
    return InitiatePaymentResponse._internal(
        reference: data['reference'],
        trans: data['txRef'],
        authModelUsed: data['authModelUsed'],
        otpMessage: data['otpmessage'],
        displayText: data['chargeResponseMessage'],
        authUrl: data['authurl'],
        chargeResponseCode: data['chargeResponseCode'],
        chargeResponseMessage: data['chargeResponseMessage'],
        status: map['status'],
        message: map['message']);
  }

  bool hasValidReferenceAndTrans() {
    return (reference != null) && (trans != null);
  }

  bool hasValidUrl() {
    if (otpMessage == null || otpMessage.length == 0) {
      return false;
    }

    return RegExp(r'^https?://', caseSensitive: false).hasMatch(otpMessage);
  }

  bool hasValidOtpMessage() {
    return otpMessage != null;
  }

  bool hasValidAuth() {
    return authModelUsed != null;
  }

  @override
  String toString() {
    return 'TransactionApiResponse{reference: $reference, trans: $trans, auth: $authModelUsed, '
        'otpMessage: $otpMessage, displayText: $displayText, message: $message, '
        'status: $status}';
  }
}
