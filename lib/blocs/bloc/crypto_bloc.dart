import 'package:bloc/bloc.dart';
import 'package:crypto_app/model/crypto_currency.dart';
import 'package:crypto_app/model/data_error.dart';
import 'package:crypto_app/services/data_repo.dart';
import 'package:equatable/equatable.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  CryptoBloc({required CryptoRepository cryptoRepository})
      : _cryptoRepository = cryptoRepository,
        super(CryptoState.start()) {
    on<Start>((event, emit) => _start(emit));
    on<RefreshCoins>((event, emit) => _refreshCoins(emit));
  }
  final CryptoRepository _cryptoRepository;

  Future<CryptoState> _start(Emitter<CryptoState> emit) async {
    state.copyWith(status: Status.loading);
    return _refreshCoins(emit);
  }

  Future<CryptoState> _refreshCoins(Emitter<CryptoState> emit) async {
    try {
      final coins = await _cryptoRepository.getCurrencies();
      emit(state.copyWith(coins: coins, status: Status.loaded));
      return state;
    } on DataError catch (err) {
      emit(
        state.copyWith(
          failure: err,
          status: Status.error,
        ),
      );
    return state;
    }
  }
}
