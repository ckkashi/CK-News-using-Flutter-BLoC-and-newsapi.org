abstract class AuthEvents {}

class AuthSignedInEvent extends AuthEvents {
  final user;
  AuthSignedInEvent(this.user);
}

class AuthNotSignedInEvent extends AuthEvents {}
