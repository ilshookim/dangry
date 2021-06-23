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
  String destinationPort = Global.defaultConnectionsOption;
  String destination = Global.defaultDestinationOption;
  String data = Global.defaultDataOption;
  String app = Global.defaultAppOption;

  Map<WebSocket, String> _connections = Map();

  int open({
    String? connections, 
    String? destination, 
    String? destinationPort}) {
    final String function = Trace.current().frames[0].member!;
    int count = 0;
    try {
      final String conns = connections ?? "0";
      final String dest = destination ?? this.destination;
      final String port = destinationPort ?? this.destinationPort;

      count = int.tryParse(conns)!;
      print('$function: count=$count, destination=$dest:$port');

      String url = 'ws://$dest:$port';
      _makeConnections(url, count);
    } catch (exc) {
      print('$function: $exc');
    }
    return count;
  }

  int close() {
    final String function = Trace.current().frames[0].member!;
    int count = 0;
    try {
      _connections.forEach((ws, cid) {
        ws.close().then((_) {
          print('$function: cid=$cid');
        });
      });
      count = _connections.length;
    } catch (exc) {
      print('$function: $exc');
    }
    return count;
  }

  int connections() {
    return _connections.length;
  }

  Future<bool> _makeConnections(String url, int count) async {
    final String function = Trace.current().frames[0].member!;
    bool succeed = false;
    try {
      print('$function: connect: count=$count, url=$url');
      while (count > 0) {
        WebSocket ws = await WebSocket.connect(url);
        if (ws.readyState == WebSocket.open) {
          final String cid = _connected(ws, url);
          _listen(ws, cid);
          count--;
        }
      }
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
