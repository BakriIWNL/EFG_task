import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:efg_currency_converter/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkCubit extends Cubit<InternetState> {
  NetworkCubit() : super(InternetState.initialState);

  final connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? streamSubscription;

  Future<void> init() async {
    streamSubscription =
        connectivity.onConnectivityChanged.listen(updateConnectivity);
    updateConnectivity(await connectivity.checkConnectivity());
  }

  void updateConnectivity(List<ConnectivityResult> events) {
    if (isClosed) return;
    final isConnected = events.any(
      (event) =>
          event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi ||
          event == ConnectivityResult.ethernet ||
          event == ConnectivityResult.vpn,
    );
    if (isConnected) {
      emit(InternetState.onState);
    } else {
      emit(InternetState.offState);
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
