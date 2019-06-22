import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'base_service.dart';
import 'package:rave_pay/common/exceptions.dart';
import 'package:rave_pay/common/strings.dart';
import 'package:rave_pay/api/model/index.dart';

class CardService extends BaseApiService {
  Future<TransactionApiResponse> chargeCard(Map<String, String> fields) async {
    var url = '$baseUrl/flwv3-pug/getpaidx/api/charge';

    http.Response response =
        await http.post(url, body: fields, headers: headers);
    var body = response.body;

    var statusCode = response.statusCode;

    switch (statusCode) {
      case HttpStatus.ok:
        Map<String, dynamic> responseBody = json.decode(body);
        return TransactionApiResponse.fromMap(responseBody);
        break;
      case HttpStatus.gatewayTimeout:
        throw ChargeException('Gateway timeout error');
        break;
      default:
        throw ChargeException(Strings.unKnownResponse);
        break;
    }
  }

  Future<TransactionApiResponse> validateCharge(
      Map<String, String> fields) async {
    var url = '$baseUrl/charge/validate';

    http.Response response =
        await http.post(url, body: fields, headers: headers);
    var body = response.body;

    var statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      Map<String, dynamic> responseBody = json.decode(body);
      return TransactionApiResponse.fromMap(responseBody);
    } else {
      throw CardException('validate charge transaction failed with '
          'status code: $statusCode and response: $body');
    }
  }

  Future<TransactionApiResponse> reQueryTransaction(String trans) async {
    var url = '$baseUrl/requery/$trans';

    http.Response response = await http.get(url, headers: headers);
    var body = response.body;
    var statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      Map<String, dynamic> responseBody = json.decode(body);
      return TransactionApiResponse.fromMap(responseBody);
    } else {
      throw ChargeException('requery transaction failed with status code: '
          '$statusCode and response: $body');
    }
  }
}
