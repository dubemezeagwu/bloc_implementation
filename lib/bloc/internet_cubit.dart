import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_implementation/utils/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {

  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()){
     monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivity.onConnectivityChanged.listen((connectivityResult) {
    if(connectivityResult == ConnectivityResult.wifi){
      emitInternetConnected(ConnectionType.WiFi);
    } else if (connectivityResult == ConnectivityResult.mobile){
      emitInternetConnected(ConnectionType.Mobile);
    } else if (connectivityResult == ConnectivityResult.none){
      emitInternetDisconnected();
    }
  });
  }

  // These methods emit an internet state from our cubit, depending on what type of connection we have at a particular moment
  void emitInternetConnected (ConnectionType _connectionType) => emit(InternetConnected(connectionType: _connectionType));
  void emitInternetDisconnected ()  => emit(InternetDisconnected());

  // This override function helps in closing the cubit when it is no longer in use, to prevent stream leaks.
  @override
  Future<void> close() {
    // TODO: implement close
    connectivityStreamSubscription?.cancel();
    return super.close();
  }
}

final InternetCubit internetCubit = InternetCubit(connectivity: Connectivity());
