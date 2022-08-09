abstract class ConnectivityStates {}

class ConnectivityGainState extends ConnectivityStates {
  final String msg;
  ConnectivityGainState(this.msg);
}

class ConnectivityLostState extends ConnectivityStates {
  final String errorMsg;
  ConnectivityLostState(this.errorMsg);
}

class ConnectivityInitialState extends ConnectivityStates {}
