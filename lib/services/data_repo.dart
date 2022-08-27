import 'dart:convert';

import 'package:crypto_app/model/currency.dart';
import 'package:http/http.dart' as http;

class CryptoRepository {
  CryptoRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  static const String _baseUrl = 'https://min-api.cryptocompare.com/';

  final http.Client _httpClient;

  Future<List<CryptoCurrency>> getCurrencies() async {
    const requestUrl =
        '${_baseUrl}data/top/totalvolfull?limit=10&tsym=USD&page=0';
    try {
      final response = await _httpClient.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final coinList = List<dynamic>.from(data['Data'] as Iterable<dynamic>);
        return coinList
            .map(
              (e) => CryptoCurrency.fromMap(e as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    } catch (err) {
      throw ArgumentError(err.toString());
    }
  }
}
