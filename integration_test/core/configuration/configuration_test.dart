import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:apps/firebase_options_dev.dart' as dev_options;
import 'package:apps/firebase_options_e2e.dart' as e2e_options;

void main() {
  testWidgets("Fetch and load all configs", (tester) async {
    for (var option in allFirebaseOptions) {
      var config = await getConfigurationForFlavor(option.options);
      expect((config["testValue"] as RemoteConfigValue).asString(),
          option.testValue);
    }
  });
}

const firebaseAppTestName = "RemoteConfigTest";

typedef FirebaseTestConfig = ({String testValue, FirebaseOptions options});

final allFirebaseOptions = <FirebaseTestConfig>[
  (
    testValue: "test5678",
    options: dev_options.DefaultFirebaseOptions.currentPlatform,
  ),
  (
    testValue: "test1234",
    options: e2e_options.DefaultFirebaseOptions.currentPlatform,
  ),
];

getConfigurationForFlavor(FirebaseOptions options) async {
  final prevFirebaseApp =
      Firebase.apps.where((app) => app.name == firebaseAppTestName).firstOrNull;
  if (prevFirebaseApp != null) {
    await prevFirebaseApp.delete();
  }
  var firebaseApp =
      await Firebase.initializeApp(name: firebaseAppTestName, options: options);

  final remoteConfig = FirebaseRemoteConfig.instanceFor(app: firebaseApp);
  await remoteConfig.fetchAndActivate();
  final configData = remoteConfig.getAll();

  return configData;
}
