import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/example_snackbar/bloc/data_event.dart';
import 'package:learn_bloc/example_snackbar/bloc/data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(Initial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is FetchData) {
      yield Loading();
      await Future.delayed(Duration(seconds: 2));
      yield Success();
    }
  }
}
