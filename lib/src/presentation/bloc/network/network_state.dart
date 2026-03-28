import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object?> get props => [];
}

class NetworkInitial extends NetworkState {
  const NetworkInitial();
}

class NetworkStatus extends NetworkState {
  final List<ConnectivityResult> results;
  final bool isOffline;
  final bool showBackOnline;

  const NetworkStatus({
    required this.results,
    this.isOffline = false,
    this.showBackOnline = false,
  });

  @override
  List<Object?> get props => [results, isOffline, showBackOnline];
}
