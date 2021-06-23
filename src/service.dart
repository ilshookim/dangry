/// dangry designed by ilshookim
/// MIT License
///
/// https://github.com/ilshookim/dangry
///
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'global.dart';
import 'data.dart';

class Service {
  String destinationPort = Global.defaultConnectionsOption;
  String destination = Global.defaultDestinationOption;
  String data = Global.defaultDataOption;
  String app = Global.defaultAppOption;
  String epoch = Global.defaultEpochOption;

  Map<WebSocket, String> _connections = Map();

  int open({
    String? connections, 
    String? destination, 
    String? destinationPort}) {
    final String function = 'Service.open';
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
    final String function = 'Service.close';
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
    final String function = 'Service._makeConnections';
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

  String _cid() {
    final DateTime now = DateTime.now();
    if (epoch.parseBool()) return '${now.millisecondsSinceEpoch}';
    return now.toIso8601String();
  }

  String _connected(WebSocket ws, String url) {
    final String function = 'Service._connected';
    final String cid = _cid();
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
    final String function = 'Service._listen';
    bool succeed = false;
    try {
      ws.listen((message) { 
        final int ended = DateTime.now().millisecondsSinceEpoch;
        final Map payload = json.decode(message);
        final String pts = payload['pts'];
        final int began = int.tryParse(pts) ?? ended;
        final int dur = ended - began;
        print('$function: dur=$dur ms, cid=$cid, received: length=${message.length}');

        // print('$function: cid=$cid, received: length=${message.length}');
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
    final String function = 'Service.set';
    bool succeed = false;
    try {
      _connections.forEach((ws, cid) {
        Stopwatch sw = Stopwatch()..start();
        final Map payload = { 'cid': '$cid', 'msg': message, 'data': data10KB(), 'pts': '${DateTime.now().millisecondsSinceEpoch}' };
        ws.add('${json.encode(payload)}');
        print('$function: cid=$cid, sent: length=${payload.length}, consumed=${sw.elapsed.inMicroseconds / 1000} ms');
      });
      succeed = true;
    } catch (exc) {
      print('$function: $exc');
    }
    return succeed;
  }
}
