import 'api_response.dart';
import 'package:rave_pay/common/utils.dart';

class ChargeToken {
  final String embedToken;
  final String userToken;

  ChargeToken._internal({this.embedToken, this.userToken});
  factory ChargeToken.fromMap(Map<String, dynamic> map) {
    return ChargeToken._internal(
        embedToken: map['embed_token'], userToken: map['user_token']);
  }
  String toString() {
    return 'ChargeToken{embedToken: $embedToken, userToken: $userToken}';
  }
}

class Customer {
  final String id;
  final String fullName;
  final String customertoken;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String accountId;

  Customer._internal(
      {this.id,
      this.fullName,
      this.customertoken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.accountId});

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer._internal(
        id: map['id'],
        fullName: map['fullName'],
        customertoken: map['customertoken'],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt'],
        deletedAt: map['deletedAt'],
        accountId: map['AccountId']);
  }
  String toString() {
    return 'Customer{id: $id, fullName: $fullName}, '
        'customertoken: $customertoken, createdAt: $createdAt, updatedAt: $updatedAt, '
        'deletedAt: $deletedAt, accountId: $accountId';
  }
}

class TransactionApiResponse extends ApiResponse {
  final String id;
  final String txRef;
  final double amount;
  final String chargeResponseCode;
  final String chargeResponseMessage;
  final String currency;
  final String paymentType;
  final Customer customer;
  final ChargeToken chargeToken;

  TransactionApiResponse._internal(
      {this.id,
      this.txRef,
      this.amount,
      this.chargeResponseCode,
      this.chargeResponseMessage,
      this.currency,
      this.paymentType,
      this.customer,
      this.chargeToken,
      String status,
      String message})
      : super(status: status, message: message);

  TransactionApiResponse.unknownServerResponse()
      : id = null,
        txRef = null,
        amount = null,
        chargeResponseCode = null,
        chargeResponseMessage = null,
        currency = null,
        paymentType = null,
        customer = null,
        chargeToken = null,
        super(status: '0', message: 'Unknown server response');

  factory TransactionApiResponse.fromMap(Map<String, dynamic> map) {
    final data = Utils.asStringKeyedMap(map['data']);
    final transaction = data['data'];
    final customer = Customer.fromMap(transaction['customer']);
    final chargeToken = ChargeToken.fromMap(transaction['chargeToken']);
    final amount = double.tryParse(transaction['amount']);
    return TransactionApiResponse._internal(
        id: transaction['reference'],
        txRef: transaction['txRef'],
        amount: amount,
        chargeResponseCode: transaction['chargeResponseCode'],
        chargeResponseMessage: transaction['chargeResponseMessage'],
        currency: transaction['authurl'],
        paymentType: transaction['paymentType'],
        customer: customer,
        chargeToken: chargeToken,
        status: map['status'],
        message: map['message']);
  }

  bool hasValidReference() {
    return (txRef != null);
  }

  @override
  String toString() {
    return 'TransactionApiResponse{id: $id, txRef: $txRef, amount: $amount, '
        'chargeResponseCode: $chargeResponseCode, chargeResponseMessage: $currency, message: $paymentType, '
        'customer: $customer, chargeToken: $chargeToken, message: $paymentType, '
        'status: $status}';
  }
}
