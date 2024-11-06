import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/features/user/repos/fake_user_repository.dart';
import 'package:healing_guide_flutter/features/user/repos/user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'utils/utils.dart';
import 'app.dart';

/// Bootstrap our app with required dependencies
Future<void> _bootstrap() async {
  GetIt.I.registerLazySingleton<UserRepository>(() => FakeUserRepository());

  GetIt.I.registerSingleton<AuthRepository>(
    FakeAuthRepository(GetIt.I.get<UserRepository>()),
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
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  await _bootstrap();
  runApp(const MainApp());
}
