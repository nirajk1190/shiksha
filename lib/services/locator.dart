
import 'package:get_it/get_it.dart';
import 'package:shiksha/services/pushnotificationservice.dart';

import 'navigationservice.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => PushNotificationService());
}
