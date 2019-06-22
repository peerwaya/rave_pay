import 'api_response.dart';
import 'package:rave_pay/common/utils.dart';

class SuggestedAuthResponse extends ApiResponse {
  final String suggestedAuth;

  SuggestedAuthResponse._internal(
      {this.suggestedAuth, String status, String message})
      : super(status: status, message: message);

  SuggestedAuthResponse.unknownServerResponse()
      : suggestedAuth = null,
        super(status: '0', message: 'Unknown server response');

  factory SuggestedAuthResponse.fromMap(Map<String, dynamic> map) {
    final status = map['status'];
    final message = map['message'];
    final data = Utils.asStringKeyedMap(map['data']);
    return SuggestedAuthResponse._internal(
        suggestedAuth: data['suggested_auth'],
        status: status,
        message: message);
  }

  @override
  String toString() {
    return 'SuggestedAuthResponse{suggestedAuth: $suggestedAuth, '
        'message: $message, '
        'status: $status}';
  }
}
