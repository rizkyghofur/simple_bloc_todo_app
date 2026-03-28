import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/network/network_cubit.dart';
import '../../bloc/network/network_state.dart';
import '../../../injection_container.dart';

class NetworkStatusWidget extends StatelessWidget {
  final Widget child;
  const NetworkStatusWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NetworkCubit>(),
      child: BlocListener<NetworkCubit, NetworkState>(
        listener: (context, state) {
          if (state is NetworkStatus) {
            if (state.isOffline) {
              Fluttertoast.showToast(
                msg: 'Offline',
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
            } else if (state.showBackOnline) {
              Fluttertoast.showToast(
                msg: 'Back Online',
                backgroundColor: Colors.green,
                textColor: Colors.white,
              );
            }
          }
        },
        child: child,
      ),
    );
  }
}
