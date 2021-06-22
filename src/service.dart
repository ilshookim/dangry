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

      String url = 'ws://$dest:$destPort';
      print('$function: connect: count=$count, url=$url');
      while (count > 0) {
        WebSocket.connect(url).then((WebSocket ws) {
          final String cid = _connected(ws, url);
          _listen(ws, cid);
        });
        count--;
      }

      succeed = true;
    } catch (exc) {
      print('$function: $exc');
    }
    return succeed;
  }

  String _connected(WebSocket ws, String url) {
    final String function = Trace.current().frames[0].member!;
    final DateTime now = DateTime.now();
    final String cid = now.toIso8601String();
    try {
      _connections[ws] = cid;
    } catch (exc) {
      print('$function: $exc');
    } finally {
      print('$function: connections=${_connections.length}, cid=$cid, url=$url');
    }
    return cid;
  }

  bool _listen(WebSocket ws, String cid) {
    final String function = Trace.current().frames[0].member!;
    bool succeed = false;
    try {
      ws.listen((data) { 
        print('$function: cid=$cid, received=$data');
      }, onDone: () {
        _connections.remove(ws);
        print('close: cid=$cid, connections=${_connections.length}');
      }, onError: (error) {
        _connections.remove(ws);
        print('error: cid=$cid, connections=${_connections.length}, error=$error');
      });

      succeed = true;
    } catch (exc) {
      print('$function: $exc');
    }
    return succeed;
  }

  bool set(String message) {
    final String function = Trace.current().frames[0].member!;
    bool succeed = false;
    try {
      _connections.forEach((ws, cid) {
        final Map payload = { 'cid': cid, 'msg': message };
        Stopwatch sw = Stopwatch()..start();
        ws.add('$payload');
        print('$function: cid=$cid, sent=$payload, consumed=${sw.elapsed}');
      });
      succeed = true;
    } catch (exc) {
      print('$function: $exc');
    }
    return succeed;
  }
}
