import 'package:catalog_app/features/products/domain/usecases/get_product_details.dart';
import 'package:catalog_app/features/products/domain/usecases/search_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/dio_client.dart';

import '../data/datasources/product_remote_data_source.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/usecases/get_products.dart';

class ProductDependencies extends StatelessWidget {
  final Widget child;

  const ProductDependencies({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRemoteDataSource>(
          create: (_) => ProductRemoteDataSourceImpl(DioClient()),
        ),

        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepositoryImplementation(
            context.read<ProductRemoteDataSource>(),
          ),
        ),



        RepositoryProvider<GetProducts>(
          create: (context) =>
              GetProducts(context.read<ProductRepository>()),
        ),

        RepositoryProvider<GetProductDetails>(
          create: (context) =>
              GetProductDetails(context.read<ProductRepository>()),
        ),
        RepositoryProvider<SearchProducts>(
          create: (context) =>
              SearchProducts(context.read<ProductRepository>()),
        ),
      ],
      child: child,
    );
  }
}


