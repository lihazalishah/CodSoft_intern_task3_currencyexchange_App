import 'dart:io';

import 'package:currency_converter_app/functions/app_Exception.dart';
import 'package:currency_converter_app/utils/key.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../models/allCurrencies.dart';
import '../models/ratesmodel.dart';

//for latest rates of currencies
Future<RatesModel> fetchrates() async {
  final result;

  try {
    final response = await http.get(Uri.parse(
        'https://openexchangerates.org/api/latest.json?app_id=' + key));

    result = returnResponse(response);
    // result = rateModelFromJson(response.body);
  } on SocketException {
    throw FetchDataException('No Internet Connection');
  }
  return result;
}

// for countries name fetching
Future<Map> fetchCurrencies() async {
  final allcurreiencies;
  try {
    final response = await http.get(Uri.parse(
        'https://openexchangerates.org/api/currencies.json?app_id=' + key));

    allcurreiencies = allcurrenciesFromJson(response.body);
  } on SocketException {
    throw FetchDataException('No Internet Connection');
  }
  return allcurreiencies;
}

dynamic returnResponse(http.Response response) {
  // print(response.statusCode);
  switch (response.statusCode) {
    case 200: // valid response
      final result = rateModelFromJson(response.body);
      return result;
    case 400:
      throw BadRequestException(response.body.toString());
    case 404:
      throw UnauthorizedException(response.body.toString());
    default:
      throw FetchDataException(
          'Error accured while communicating with server with server ststus code ${response.statusCode.toString()}');
  }
}

// form usd conversion
dynamic Convertusd(Map exchangeRates, String usd, String currency) {
  var output = (double.parse(usd) * exchangeRates[currency])
      .toStringAsFixed(2)
      .toString();
  return output;
}

// from any to any
dynamic Convertany(Map exchangeRates, String amount, String currencybase,
    String currencyfinal) {
  var output = ((double.parse(amount) / exchangeRates[currencybase]) *
          exchangeRates[currencyfinal])
      .toStringAsFixed(2)
      .toString();
  return output;
}
