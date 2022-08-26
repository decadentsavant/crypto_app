part of 'crypto_bloc.dart';

enum Status { initial, loading, loaded, error }

class CryptoState extends Equatable {
  const CryptoState({
    required this.status,
    required this.coins,
    required this.onError,
  });

  factory CryptoState.start() => const CryptoState(
        status: Status.initial,
        coins: [],
        onError: DataError(),
      );

  final Status status;
  final List<CryptoCurrency> coins;
  final DataError onError;

  CryptoState copyWith({
    Status? status,
    List<CryptoCurrency>? coins,
    DataError? failure,
  }) {
    return CryptoState(
      status: status ?? this.status,
      coins: coins ?? this.coins,
      onError: failure ?? onError,
    );
  }

  @override
  List<Object> get props => [
        coins,
        status,
        onError,
      ];
}
