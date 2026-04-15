import 'package:catalog_app/core/di/service_locator.dart';
import 'package:catalog_app/features/products/data/datasources/product_local_data_source.dart';
import 'package:catalog_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:catalog_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:catalog_app/features/products/domain/repositories/product_repository.dart';
import 'package:catalog_app/features/products/domain/usecases/get_product_details.dart';
import 'package:catalog_app/features/products/domain/usecases/get_products.dart';
import 'package:catalog_app/features/products/domain/usecases/search_products.dart';
import 'package:catalog_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';


Future<void>initProductDi() async{

  sl.registerLazySingleton<ProductRemoteDataSource>(()=>ProductRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(()=>ProductLocalDataSourceImplementation(sl()));
  sl.registerLazySingleton<ProductRepository>(()=>ProductRepositoryImplementation(sl(), sl()));
  sl.registerLazySingleton(()=>GetProducts(sl()));
  sl.registerLazySingleton(()=>GetProductDetails(sl()));
  sl.registerLazySingleton(()=>SearchProducts(sl()));

  sl.registerLazySingleton(()=>ProductBloc(sl(), sl(), sl()));



}
