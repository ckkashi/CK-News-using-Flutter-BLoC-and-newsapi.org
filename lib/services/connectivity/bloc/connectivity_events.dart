abstract class ConnectivityEvents {}

class ConnectivityGainEvent extends ConnectivityEvents {
  final String msg;
  ConnectivityGainEvent(this.msg);
}

class ConnectivityLostEvent extends ConnectivityEvents {
  final String errorMsg;
  ConnectivityLostEvent(this.errorMsg);
}
