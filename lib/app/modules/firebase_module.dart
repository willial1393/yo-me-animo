import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @preResolve
  Future<FirebaseApp> init() async {
    final app = await Firebase.initializeApp();
    return app;
  }
}
