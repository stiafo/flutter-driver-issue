import "package:firebase_core/firebase_core.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";

import "core/configuration/configuration_test.dart" as configuration;

/*
    We combine the execution of all integration tests into one main file for
    enhanced performance. This way, Flutter will only create one binary for all our
    files.

    Side note: This will mean that there is not a clean state between tests.
    The tests must run in the correct order, or clean up after themselves.
*/
Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  configuration.main();
}
