

import 'package:catalog_app/core/database/database_helper.dart';
import 'package:catalog_app/core/di/service_locator.dart';

import '../network/dio_client.dart';

Future<void>initCoreDi() async{
  sl.registerLazySingleton<DioClient>(()=>DioClient());
  sl.registerLazySingleton<DatabaseHelper>(()=>DatabaseHelper());





}