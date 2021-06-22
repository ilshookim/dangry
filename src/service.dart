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

  Map<WebSocket, String> _connections = Map();

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
      final String conns = connections ?? this.conns;
      final String dest = destination ?? this.dest;
      final String destPort = destinationPort ?? this.destPort;
      final int older = int.tryParse(this.conns)!;
      final int newly = int.tryParse(conns)!;

      int count = newly - older;
      print('$function: count=$count (older=$older, newly=$newly), destination=$dest:$destPort');

      String connection = 'ws://$dest:$destPort';
      print('$function: connect: count=$count, url=$connection');
      while (count > 0) {
        WebSocket.connect(connection).then((WebSocket ws) {
          final DateTime now = DateTime.now();
          final String cid = now.toIso8601String();
          _connections[ws] = cid;
          print('$function: connected: connections=${_connections.length}, cid=$cid, url=$connection');

          handleWebSocket(ws, cid);
        });
        count--;
      }

      succeed = true;
    } catch (exc) {
      print('$function: $exc');
    }
    return succeed;
  }

  bool handleWebSocket(WebSocket ws, String cid) {
    final String function = Trace.current().frames[0].member!;
    bool succeed = false;
    try {
      final String message = 'hello, world';
      print('$function: cid=$cid, sent=$message');
      ws.add(message);

      ws.listen((data) { 
        print('$function: cid=$cid, received=$data');
      }, onDone: () {
        print('close: cid=$cid');
      }, onError: (error) {
        print('error: cid=$cid, error=$error');
      });

      succeed = true;
    } catch (exc) {
      print('$function: $exc');
    }
    return succeed;
  }
}
