import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/features/user/repos/fake_user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'utils/utils.dart';
import 'app.dart';

/// Bootstrap our app with required dependencies
Future<MainApp> _bootstrap() async {
  final userRepository = FakeUserRepository();

  return MainApp(
    authRepository: FakeAuthRepository(userRepository),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setup `HydratedBloc` storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  Bloc.observer = AppBlocObserver();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(await _bootstrap());
}
