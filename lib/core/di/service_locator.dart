import 'package:catalog_app/core/di/core_di.dart';
import 'package:catalog_app/core/di/product_di.dart';
import 'package:get_it/get_it.dart';

import 'cart_di.dart';

final sl = GetIt.instance;

Future<void>initDependencies() async{
  await initCoreDi();
  await initProductDi();
  await initCartDi();

}