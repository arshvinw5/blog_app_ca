import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract interface class connectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements connectionChecker {
  final InternetConnectionChecker _internetConnectionChecker;

  ConnectionCheckerImpl(this._internetConnectionChecker);

  //getting the current connection status boolean
  @override
  Future<bool> get isConnected async =>
      await _internetConnectionChecker.hasConnection;
}
