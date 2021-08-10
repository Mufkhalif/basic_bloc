import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DataState extends Equatable {}

class Initial extends DataState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Loading extends DataState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Success extends DataState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
