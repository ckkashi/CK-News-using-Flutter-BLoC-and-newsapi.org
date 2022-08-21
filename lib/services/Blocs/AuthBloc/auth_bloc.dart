import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/services/Blocs/AuthBloc/auth_events.dart';
import 'package:news_app/services/Blocs/AuthBloc/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitialState()) {
    on<AuthSignedInEvent>((event, emit) => emit(AuthSignedinState(event.user)));
    on<AuthNotSignedInEvent>((event, emit) => emit(AuthNotSignedinState()));

    _firebaseAuth.idTokenChanges().listen((User? user) {
      if (user != null) {
        add(AuthSignedInEvent(user));
      } else {
        add(AuthNotSignedInEvent());
      }
    });
  }
}
