import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/home.dart';
import 'package:news_app/services/connectivity/bloc/connectivity_bloc.dart';
import 'package:news_app/services/connectivity/bloc/connectivity_states.dart';

import '../Blocs/NewsBloc/news_bloc.dart';

class ConnectivityScreen extends StatelessWidget {
  const ConnectivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectivityBloc(),
      child: Scaffold(
        body: BlocListener<ConnectivityBloc, ConnectivityStates>(
            listener: (context, state) {
              if (state is ConnectivityGainState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.msg),
                  backgroundColor: Colors.green,
                ));
              } else if (state is ConnectivityLostState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMsg),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: BlocProvider(
              create: (context) => NewsBloc(),
              child: Home(),
            )),
      ),
    );
  }
}
