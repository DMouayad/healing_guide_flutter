import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:healing_guide_flutter/api/http_helper.dart';
import 'package:healing_guide_flutter/api/rest_client.dart';
import 'package:healing_guide_flutter/features/medical_specialty/repositories.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'features/auth/repositories.dart';
import 'features/user/repos/fake_user_repository.dart';
import 'features/user/repos/user_repository.dart';
import 'features/search/repositories.dart';
import 'utils/utils.dart';
import 'app.dart';

/// Bootstrap our app with required dependencies
Future<void> _bootstrap() async {
  GetIt.I.registerLazySingleton<UserRepository>(() => FakeUserRepository());

  GetIt.I.registerSingleton<AuthRepository>(
    ApiAuthRepository(GetIt.I.get<UserRepository>()),
  );
  GetIt.I.registerSingleton<MedicalSpecialtyRepository>(
      ApiMedicalSpecialtyRepository());
  GetIt.I.registerSingleton<SearchRepository>(FakeSearchRepository());

  RestClient.init(HttpHelper.getClient());
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
