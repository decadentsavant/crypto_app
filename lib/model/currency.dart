// ignore_for_file: avoid_dynamic_calls

import 'package:equatable/equatable.dart';

class CryptoCurrency extends Equatable {
  const CryptoCurrency({
    required this.name,
    required this.fullName,
    required this.price,
  });

  factory CryptoCurrency.fromMap(Map<String, dynamic> map) {

    return CryptoCurrency(
      name: map['CoinInfo']?['Name'].toString() ?? '',
      fullName: map['CoinInfo']?['FullName'].toString() ?? '',
      price: map['RAW']?['USD']?['PRICE'].toDouble() as double,
    );
  }
  final String name;
  final String fullName;
  final double price;

  @override
  List<Object?> get props => [name, fullName, price];
}
