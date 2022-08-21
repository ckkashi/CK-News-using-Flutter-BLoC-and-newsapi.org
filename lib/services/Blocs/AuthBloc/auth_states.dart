abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSignedinState extends AuthStates {
  final user;
  AuthSignedinState(this.user);
}

class AuthNotSignedinState extends AuthStates {}
