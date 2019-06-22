import 'suggested_auth_response.dart';
import 'api_response.dart';
import 'transaction_api_response.dart';
import 'initiate_payment_response.dart';

const _kauth_suggestion = "AUTH_SUGGESTION";
const _kv_comp = "V-COMP";
const _kcharge_success = "Charge Complete";

ApiResponse apiResponseFromMap(Map<String, dynamic> map) {
  final message = map['message'];
  switch (message) {
    case _kauth_suggestion:
      return SuggestedAuthResponse.fromMap(map);
    case _kv_comp:
      return TransactionApiResponse.fromMap(map);
    case _kcharge_success:
      return InitiatePaymentResponse.fromMap(map);
  }
  return ApiResponse(status: map["status"], message: message);
}
