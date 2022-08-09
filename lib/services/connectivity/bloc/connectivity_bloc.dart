import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/services/connectivity/bloc/connectivity_states.dart';

import 'package:news_app/services/connectivity/bloc/connectivity_events.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvents, ConnectivityStates> {
  final Connectivity _connectivity = Connectivity();
  ConnectivityBloc() : super(ConnectivityInitialState()) {
    on<ConnectivityGainEvent>(
        (event, emit) => emit(ConnectivityGainState(event.msg)));
    on<ConnectivityLostEvent>(
        (event, emit) => emit(ConnectivityLostState(event.errorMsg)));
    _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        add(ConnectivityGainEvent('Successfully connected with network.'));
      } else {
        add(ConnectivityLostEvent(
            'please connect your device with wifi or data network.'));
      }
    });
  }
}
