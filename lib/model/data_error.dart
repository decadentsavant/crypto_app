import 'package:equatable/equatable.dart';

class DataError extends Equatable {

  const DataError({this.message = ''});
  final String message;

  @override
  List<Object?> get props => [message];
}
