/// dangry designed by ilshookim
/// MIT License
///
/// https://github.com/ilshookim/dangry
///
import 'package:path/path.dart';
import 'package:shelf/shelf.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'global.dart';
import 'service.dart';

class API {
  final Service service = Service();
  final Router router = Router();

  /// configure: curl http://localhost:8088/v1/configure?data=3KB&app=home1&connections=450
  Response onConfigure(Request request) {
    final String function = Trace.current().frames[0].member!;
    final Uri uri = request.requestedUri;
    String message = 'empty';
    try {
      final String? destinationPortParam = uri.queryParameters[Global.destinationPortParam];
      final String? destinationParam = uri.queryParameters[Global.destinationParam];
      final String? connectionsParam = uri.queryParameters[Global.connectionsParam];
      final String? dataParam = uri.queryParameters[Global.dataParam];
      final String? appParam = uri.queryParameters[Global.appParam];
      service.destPort = destinationPortParam ?? service.destPort;
      service.dest = destinationParam ?? service.dest;
      service.conns = connectionsParam ?? service.conns;
      service.data = dataParam ?? service.data;
      service.app = appParam ?? service.app;
      message = 'connections=${service.conns}, destination=${service.dest}:${service.destPort}, app=${service.app}, data=${service.data}';
    } catch (exc) {
      message = '$function: $exc';
    } finally {
      print('$uri: $function: $message');
    }
    return Response.ok(message + '\n');
  }

  /// connections to create: curl http://localhost:8080/v1/service?connections=450&destination=localhost&port=2404
  Response onService(Request request) {
    final String function = Trace.current().frames[0].member!;
    final Uri uri = request.requestedUri;
    String message = 'empty';
    try {
      final String? destinationPortParam = uri.queryParameters[Global.destinationPortParam];
      final String? destinationParam = uri.queryParameters[Global.destinationParam];
      final String? connectionsParam = uri.queryParameters[Global.connectionsParam];
      final String destinationPort = destinationPortParam ?? service.destPort;
      final String destination = destinationParam ?? service.dest;
      final String connections = connectionsParam ?? service.conns;
      message = 'connections=$connections, destination=$destination:$destinationPort';
      service.connections(connections: connections, destination: destination, destinationPort: destinationPort);
    } catch (exc) {
      message = '$function: $exc';
    } finally {
      print('$uri: $function: $message');
    }
    return Response.ok(message + '\n');
  }

  /// set: curl http://localhost:8088/v1/set?id=0&count=1&data=10KB&app=home
  Response onSet(Request request) {
    final String function = Trace.current().frames[0].member!;
    final Uri uri = request.requestedUri;
    String message = 'empty';
    try {
      final String value = 'hello';
      service.set(value);
      message = 'set: $value';
    } catch (exc) {
      message = '$function: $exc';
    } finally {
      print('$uri: $function: $message');
    }
    return Response.ok(message + '\n');
  }

  Response onGetDel(Request request) {
    final String function = Trace.current().frames[0].member!;
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
    String? data}) {
    final String function = Trace.current().frames[0].member!;
    try {
      router.get(uri('configure'), onConfigure);
      router.get(uri('service'), onService);
      router.get(uri('getdel'), onGetDel);
      router.get(uri('set'), onSet);

      final String ver1 = "v1";
      router.get(uri('configure', version: ver1), onConfigure);
      router.get(uri('service', version: ver1), onService);
      router.get(uri('getdel', version: ver1), onGetDel);
      router.get(uri('set', version: ver1), onSet);

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
      service.conns = connections ?? service.conns;
      service.dest = destination ?? service.dest;
      service.destPort = destinationPort ?? service.destPort;
      service.data = data ?? service.data;
      service.app = app ?? service.app;
      service.start();
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
