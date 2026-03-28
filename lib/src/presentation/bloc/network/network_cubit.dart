import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  NetworkCubit({required Connectivity connectivity})
    : _connectivity = connectivity,
      super(const NetworkInitial()) {
    _monitorConnectivity();
  }

  void _monitorConnectivity() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      final isNowOffline = results.contains(ConnectivityResult.none);
      final currentState = state;

      if (currentState is NetworkStatus) {
        if (currentState.isOffline && !isNowOffline) {
          // Came back online
          emit(
            NetworkStatus(
              results: results,
              isOffline: false,
              showBackOnline: true,
            ),
          );
          Timer(const Duration(seconds: 3), () {
            if (!isClosed) {
              emit(
                NetworkStatus(
                  results: results,
                  isOffline: false,
                  showBackOnline: false,
                ),
              );
            }
          });
        } else {
          emit(
            NetworkStatus(
              results: results,
              isOffline: isNowOffline,
              showBackOnline: false,
            ),
          );
        }
      } else {
        emit(
          NetworkStatus(
            results: results,
            isOffline: isNowOffline,
            showBackOnline: false,
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
