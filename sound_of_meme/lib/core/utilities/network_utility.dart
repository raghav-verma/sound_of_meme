import 'dart:async';
import 'dart:developer';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkUtility {
  Future<bool> get isConnected;

  Stream<bool> getConnectionStream();
}

class NetworkUtilityImplementation implements NetworkUtility {
  final InternetConnectionChecker connectionChecker =
      InternetConnectionChecker();

  @override
  Future<bool> get isConnected async {
    try {
      return connectionChecker.hasConnection;
    } catch (e) {
      log('Internet Connection Checker Error: $e');

      return false;
    }
  }

  @override
  Stream<bool> getConnectionStream() {
    final controller = StreamController<bool>();

    // Check initial connection status and add to the stream
    connectionChecker.hasConnection.then((isConnected) {
      controller.add(isConnected);
    });

    // Listen for status changes
    final subscription = connectionChecker.onStatusChange.listen((status) {
      controller.add(status == InternetConnectionStatus.connected);
    });

    // Handle disposal by closing the StreamController and cancelling the subscription
    controller.onCancel = () {
      subscription.cancel();
      controller.close();
    };

    return controller.stream;
  }
}

