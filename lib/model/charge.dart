import 'package:rave_pay/model/card.dart';

class Charge {
  final PaymentCard card;
  final String email;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String ip;
  final String country;
  final bool isPreAuth;
  final String redirectUrl;
  final String deviceFingerPrint;

  final double amount;
  final Map<String, dynamic> metadata;
  final List<Map<String, dynamic>> customFields;
  final Map<String, String> additionalParameters;
  final double transactionCharge;
  final String reference;
  final String currency;
  final String suggestedAuth;
  final String billingZip;
  final String billingCity;
  final String billingAddress;
  final String billingState;
  final String billingCountry;

  Charge(
      {this.card,
      this.email,
      this.phoneNumber,
      this.firstName,
      this.lastName,
      this.ip,
      this.country,
      this.amount = 0,
      this.isPreAuth,
      this.redirectUrl,
      this.metadata,
      this.customFields,
      this.deviceFingerPrint,
      this.additionalParameters,
      this.transactionCharge = 0,
      this.reference,
      this.currency,
      this.suggestedAuth,
      this.billingZip,
      this.billingCity,
      this.billingAddress,
      this.billingState,
      this.billingCountry,
      });
}
