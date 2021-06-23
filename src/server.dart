/// dangry designed by ilshookim
/// MIT License
///
/// https://github.com/ilshookim/dangry
///
/// working directory:
/// /app         <- working directory (default)
///
import 'dart:io';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:stack_trace/stack_trace.dart';

import 'global.dart';
import 'api.dart';

void main(List<String> arguments) async {
  final String function = Trace.current().frames[0].member!;
  try {
    /// ARGS
    /// 
    /// port            : default api port          ex) 8088
    /// connections     : default connections       ex) 0
    /// destination     : default destination       ex) localhost
    /// destinationPort : default destination port  ex) 9450
    /// app             : default app               ex) home
    /// data            : default data              ex) 3KB, 10KB, 20KB, 30KB
    /// 
    final ArgParser argParser = ArgParser()
      ..addOption(Global.portOption, abbr: Global.portAbbrOption)
      ..addOption(Global.connectionsOption, abbr: Global.connectionsAbbrOption)
      ..addOption(Global.destinationOption, abbr: Global.destinationAbbrOption)
      ..addOption(Global.destinationPortOption, abbr: Global.destinationPortAbbrOption)
      ..addOption(Global.appOption, abbr: Global.appAbbrOption)
      ..addOption(Global.dataOption, abbr: Global.dataAbbrOption);
    final ArgResults argResults = argParser.parse(arguments);
    final String portOption = argResults[Global.portOption] ?? Platform.environment[Global.portEnvOption] ?? Global.defaultPortOption;
    final String connectionsOption = argResults[Global.connectionsOption] ?? Platform.environment[Global.connectionsEnvOption] ?? Global.defaultConnectionsOption;
    final String destinationOption = argResults[Global.destinationOption] ?? Platform.environment[Global.destinationEnvOption] ?? Global.defaultDestinationOption;
    final String destinationPortOption = argResults[Global.destinationPortOption] ?? Platform.environment[Global.destinationPortEnvOption] ?? Global.defaultDestinationPortOption;
    final String appOption = argResults[Global.appOption] ?? Platform.environment[Global.appEnvOption] ?? Global.defaultAppOption;
    final String dataOption = argResults[Global.dataOption] ?? Platform.environment[Global.dataEnvOption] ?? Global.defaultDataOption;

    /// API
    /// 
    /// configure:  curl http://localhost:8088/v1/configure?data=3KB&app=home1&connections=450
    /// open:       curl http://localhost:8080/v1/open?connections=450&destination=localhost&port=2404
    /// close:      curl http://localhost:8080/v1/close
    /// set:        curl http://localhost:8088/v1/set?id=0&count=1&data=10KB&app=home
    /// getdel:     curl http://localhost:8088/v1/getdel?id=0&count=1&app=home
    /// 
    final String host = Global.defaultHost;
    final int port = int.tryParse(portOption)!;
    final Handler handler = API().v1(
      destinationPort: destinationPortOption,
      destination: destinationOption,
      data: dataOption,
      app: appOption,
    );
    final HttpServer server = await serve(handler, host, port);

    final Map pubspec = await Global.pubspec();
    final String name = pubspec[Global.name];
    final String version = pubspec[Global.version];
    final String description = pubspec[Global.description];
    print('$name $version - $description serving at http://${server.address.host}:${server.port}');
    print('options: connections=$connectionsOption, destination=$destinationOption:$destinationPortOption, app=$appOption, data=$dataOption');
  } catch (exc) {
    print('$function: $exc');
  }
}
