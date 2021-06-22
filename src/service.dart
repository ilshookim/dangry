/// dangry designed by ilshookim
/// MIT License
///
/// https://github.com/ilshookim/dangry
///
import 'dart:async';
import 'dart:io';

import 'package:stack_trace/stack_trace.dart';

import 'global.dart';

class Service {
  String destPort = Global.defaultConnectionsOption;
  String dest = Global.defaultDestinationOption;
  String conns = Global.defaultConnectionsOption;
  String data = Global.defaultDataOption;
  String app = Global.defaultAppOption;

  List<WebSocket> wsConnections = List.empty(growable: true);

  Stopwatch _consume = Stopwatch();
  Timer? _timer;

  bool get isActive => _timer != null && _timer!.isActive;
  bool get isRunning => _consume.isRunning;

  bool start() {
    final String function = Trace.current().frames[0].member!;
    bool succeed = false;
    try {
      succeed = true;
    } catch (exc) {
      print('$function: $exc');
    }
    return succeed;
  }

  bool stop() {
    final String function = Trace.current().frames[0].member!;
    bool succeed = false;
    try {
      succeed = true;
    } catch (exc) {
      print('$function: $exc');
    }
    return succeed;
  }

  bool connections({
    String? connections, 
    String? destination, 
    String? destinationPort}) {
    final String function = Trace.current().frames[0].member!;
    bool succeed = false;
    try {
      final String _connections = connections ?? this.conns;
      final String _destination = destination ?? this.dest;
      final String _destinationPort = destinationPort ?? this.destPort;
      final int older = int.tryParse(this.conns)!;
      final int newly = int.tryParse(_connections)!;

      int count = newly - older;
      print('$function: count=$count (older=$older, newly=$newly), destination=$_destination:$_destinationPort');

      String connection = 'ws://echo.websocket.org';
      print('$function: connect to $connection');
      WebSocket.connect(connection).then((WebSocket ws) {
        wsConnections.add(ws);
        handleWebSocket(ws);
      });

      succeed = true;
    } catch (exc) {
      print('$function: $exc');
    }
    return succeed;
  }

  bool handleWebSocket(WebSocket ws) {
    final String function = Trace.current().frames[0].member!;
    bool succeed = false;
    try {
      final String data = 'hello, world';
      print('$function: sent=$data');
      ws.add(data);
      ws.listen((data) { 
        print('$function: received=$data');
      });
      succeed = true;
    } catch (exc) {
      print('$function: $exc');
    }
    return succeed;
  }
}
