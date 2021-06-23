/// dangry designed by ilshookim
/// MIT License
///
/// https://github.com/ilshookim/dangry
///
import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';
import 'package:stack_trace/stack_trace.dart';

class Global {
  static final String defaultApp = 'DANGRY';
  static final String defaultHost = '0.0.0.0';

  static final String portOption = 'port';
  static final String portAbbrOption = 'p';
  static final String portEnvOption = '${defaultApp}_PORT';
  static final String defaultPortOption = '8088';
  static final String destinationPortOption = 'destinationPort';
  static final String destinationPortAbbrOption = 'r';
  static final String destinationPortEnvOption = '${defaultApp}_DISTINATION_PORT';
  static final String defaultDestinationPortOption = '9450';
  static final String destinationOption = 'destination';
  static final String destinationAbbrOption = 'e';
  static final String destinationEnvOption = '${defaultApp}_DISTINATION';
  static final String defaultDestinationOption = 'localhost';
  static final String connectionsOption = 'connections';
  static final String connectionsAbbrOption = 'c';
  static final String defaultConnectionsOption = '0';
  static final String connectionsEnvOption = '${defaultApp}_CONNECTIONS';
  static final String dataOption = 'data';
  static final String dataAbbrOption = 'd';
  static final String defaultDataOption = '10KB';
  static final String dataEnvOption = '${defaultApp}_DATA';
  static final String appOption = 'app';
  static final String appAbbrOption = 'a';
  static final String defaultAppOption = 'home';
  static final String appEnvOption = '${defaultApp}_APP';
  static final String epochOption = 'epoch';
  static final String epochAbbrOption = 'h';
  static final String defaultEpochOption = 'false';
  static final String epochEnvOption = '${defaultApp}_EPOCH';

  static final String uriConfigure = "configure";
  static final String uriOpen = "open";
  static final String uriClose = "close";
  static final String uriSet = "set";
  static final String uriGetDel = "getdel";
  static final String paramDestination = destinationOption;
  static final String paramDestinationPort = destinationPortOption;
  static final String paramConnections = connectionsOption;
  static final String paramData = dataOption;
  static final String paramApp = appOption;

  static final String indexName = 'index.html';
  static final String faviconName = 'favicon.ico';
  static final int exitCodeCommandLineUsageError = 64;
  static final String dsStoreFile = '.DS_Store';

  static final String currentPath = dirname(Platform.script.toFilePath());
  static final String yamlName = 'pubspec.yaml';
  static final String name = 'name';
  static final String version = 'version';
  static final String description = 'description';

  static Future<Map> pubspec() async {
    final String function = Trace.current().frames[0].member!;
    Map yaml = Map();
    try {
      final String path = join(current, yamlName);
      final File file = new File(path);
      final String text = await file.readAsString();
      yaml = loadYaml(text);
    } catch (exc) {
      print('$function: $exc');
    }
    return yaml;
  }
}

extension BoolParsing on String {
  bool parseBool() {
    final String lowerCase = this.toLowerCase();
    if (lowerCase.isEmpty || lowerCase == 'false') return false;
    return lowerCase == 'true' || lowerCase != '0';
  }
}
