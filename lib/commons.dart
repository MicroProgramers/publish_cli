part of 'publish.dart';

class _Commons {
  static final String basePath = "./lib";
  static final String pubspecPath = './pubspec.yaml';
  static final String stringsPath =
      "./android/app/src/main/res/values/strings.xml";
  static final String manifestPath =
      "./android/app/src/main/AndroidManifest.xml";
  static final String appBuildPath = "./android/app/build.gradle";

  /// Default plugin versions
  static Map<String, dynamic> defaultConfig = {
    "plugins": {
      "firebase_auth": "^0.14.0+5",
      "google_sign_in": "^4.0.7",
      "provider": "^3.1.0",
      "google_maps": "^0.5.21+2",
      "firestore": "^0.12.9+4"
    },
    "google_services": "4.3.3"
  };

  /// Loads config either from the flutter_automation.yaml config file or default config
  static Map<String, dynamic> loadConfig() {
    if (!File("./flutter_automation.yaml").existsSync()) return defaultConfig;
    String configcontent = File("./flutter_automation.yaml").readAsStringSync();
    var configFile = loadYaml(configcontent);
    return Map<String, dynamic>.from(configFile);
  }

  static bool fileContainsString(String path, String pattern) {
    String file = getFileAsString(path);
    return file.contains(pattern);
  }

  static bool pluginExists(String plugin) {
    return fileContainsString(pubspecPath, plugin);
  }

  /// Adds provided dependencies to pubspec.yaml file
  static void addDependencise(String dependencies) {
    replaceFirstStringInfile(
        pubspecPath, "dev_dependencies:", "$dependencies\ndev_dependencies:");
  }

  /// replace string in a file at [path] from [from] to [to]
  static void replaceFirstStringInfile(String path, Pattern from, String to) {
    String contents = getFileAsString(path);
    contents = contents.replaceFirst(from, to);
    writeStringToFile(path, contents);
  }

  /// Reads a file at [path] as string
  static String getFileAsString(String path) {
    return File(path).readAsStringSync();
  }

  /// writes a string [contents] to a file at [path]
  static void writeStringToFile(String path, String contents) {
    File(path).writeAsStringSync(contents);
  }

  /// Reads a file at [path] as a list of lines
  static List<String> getFileAsLines(String path) {
    return File(path).readAsLinesSync();
  }
}