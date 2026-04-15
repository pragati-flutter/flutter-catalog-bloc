import 'package:catalog_app/core/di/service_locator.dart';
import 'package:catalog_app/features/cart/data/datasources/cart_local_datasources.dart';
import 'package:catalog_app/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:catalog_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:catalog_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:catalog_app/features/cart/domain/usecases/add_to_cart.dart';
import 'package:catalog_app/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:catalog_app/features/cart/presentation/bloc/cart_bloc.dart';

import '../../features/cart/domain/usecases/get_cart_items.dart';

Future<void> initCartDi() async {
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDatasourceImplementation(),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImplementation(sl()),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(()=>AddToCart(sl()));
  sl.registerLazySingleton(()=>RemoveFromCart(sl()));
  sl.registerLazySingleton(()=>GetCartItem(sl()));
  sl.registerLazySingleton<CartBloc>(() => CartBloc(sl(), sl(), sl()));
}
