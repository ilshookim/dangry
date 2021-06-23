/// dangry designed by ilshookim
/// MIT License
///
/// https://github.com/ilshookim/dangry
///
import 'package:path/path.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'global.dart';
import 'service.dart';

class API {
  final Service service = Service();
  final Router router = Router();

  /// configure: curl http://localhost:8088/v1/configure?data=3KB&app=home1&connections=450
  Response onConfigure(Request request) {
    final String function = 'API.onConfigure';
    final Uri uri = request.requestedUri;
    String message = 'empty';
    try {
      final String? destinationPortParam = uri.queryParameters[Global.paramDestinationPort];
      final String? destinationParam = uri.queryParameters[Global.paramDestination];
      final String? dataParam = uri.queryParameters[Global.paramData];
      final String? appParam = uri.queryParameters[Global.paramApp];
      service.destinationPort = destinationPortParam ?? service.destinationPort;
      service.destination = destinationParam ?? service.destination;
      service.data = dataParam ?? service.data;
      service.app = appParam ?? service.app;
      message = 'destination=${service.destination}:${service.destinationPort}, app=${service.app}, data=${service.data}';
    } catch (exc) {
      message = '$function: $exc';
    } finally {
      print('$uri: $function: $message');
    }
    return Response.ok(message + '\n');
  }

  /// open: curl http://localhost:8080/v1/open?connections=450&destination=localhost&port=2404
  Response onOpen(Request request) {
    final String function = 'API.onOpen';
    final Uri uri = request.requestedUri;
    String message = 'empty';
    try {
      final String? destinationPortParam = uri.queryParameters[Global.paramDestinationPort];
      final String? destinationParam = uri.queryParameters[Global.paramDestination];
      final String? connectionsParam = uri.queryParameters[Global.paramConnections];
      final String destinationPort = destinationPortParam ?? service.destinationPort;
      final String destination = destinationParam ?? service.destination;
      final String connections = connectionsParam ?? "0";
      message = 'connections=$connections, destination=$destination:$destinationPort';
      service.open(connections: connections, destination: destination, destinationPort: destinationPort);
    } catch (exc) {
      message = '$function: $exc';
    } finally {
      print('$uri: $function: $message');
    }
    return Response.ok(message + '\n');
  }

  /// close: curl http://localhost:8080/v1/close
  Response onClose(Request request) {
    final String function = 'API.onClose';
    final Uri uri = request.requestedUri;
    String message = 'empty';
    try {
      int count = service.close();
      message = 'disconnects=$count';
    } catch (exc) {
      message = '$function: $exc';
    } finally {
      print('$uri: $function: $message');
    }
    return Response.ok(message + '\n');
  }

  /// set: curl http://localhost:8088/v1/set?id=0&count=1&data=10KB&app=home
  Response onSet(Request request) {
    final String function = 'API.onSet';
    final Uri uri = request.requestedUri;
    String message = 'empty';
    try {
      final String? dataParam = uri.queryParameters[Global.paramData];
      final String data = dataParam ?? "(empty)";
      final int connections = service.connections();
      message = 'connections=$connections, data: length=${data.length}';
      service.set(data);
    } catch (exc) {
      message = '$function: $exc';
    } finally {
      print('$uri: $function: $message');
    }
    return Response.ok(message + '\n');
  }

  Response onGetDel(Request request) {
    final String function = 'API.onGetDel';
    final Uri uri = request.requestedUri;
    String message = 'empty';
    try {
      message = 'getdel: ';
    } catch (exc) {
      message = '$function: $exc';
    } finally {
      print('$uri: $function: $message');
    }
    return Response.ok(message + '\n');
  }

  Handler v1({
    String? connections,
    String? destination,
    String? destinationPort,
    String? app,
    String? data,
    String? epoch}) {
    final String function = 'API.v1';
    try {
      router.get(uri(Global.uriConfigure), onConfigure);
      router.get(uri(Global.uriOpen), onOpen);
      router.get(uri(Global.uriClose), onClose);
      router.get(uri(Global.uriSet), onSet);
      router.get(uri(Global.uriGetDel), onGetDel);

      const String ver1 = "v1";
      router.get(uri(Global.uriConfigure, version: ver1), onConfigure);
      router.get(uri(Global.uriOpen, version: ver1), onOpen);
      router.get(uri(Global.uriClose, version: ver1), onClose);
      router.get(uri(Global.uriSet, version: ver1), onSet);
      router.get(uri(Global.uriGetDel, version: ver1), onGetDel);

      final Handler index = createStaticHandler(Global.currentPath,
          defaultDocument: Global.indexName);
      final Handler favicon = createStaticHandler(Global.currentPath,
          defaultDocument: Global.faviconName);
      final Handler cascade =
          Cascade().add(index).add(favicon).add(router).handler;
      final Handler handler =
          Pipeline().addMiddleware(logRequests()).addHandler(cascade);
      return handler;
    } catch (exc) {
      print('$function: $exc');
    } finally {
      service.destination = destination ?? service.destination;
      service.destinationPort = destinationPort ?? service.destinationPort;
      service.data = data ?? service.data;
      service.app = app ?? service.app;
      service.epoch = epoch ?? service.epoch;
    }
    final Handler defaultHandler = Pipeline().addHandler((Request request) {
      return Response.ok('Request for ${request.url}');
    });
    return defaultHandler;
  }

  String uri(String path, {String? version}) {
    if (version == null) return join('/', path);
    return join('/', version, path);
  }
}
