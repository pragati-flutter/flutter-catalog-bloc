import 'package:catalog_app/features/products/domain/usecases/get_product_details.dart';
import 'package:catalog_app/features/products/domain/usecases/get_products.dart';
import 'package:catalog_app/features/products/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/products/di/product_dependencies.dart';
import '../../features/products/presentation/bloc/product_bloc.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';

class AppRoutes {

  static const String products = '/';
  static const String productDetails = '/product-details';

  static Route<dynamic> generateRoute(RouteSettings setting) {

    switch (setting.name) {

      case products:

        return MaterialPageRoute(
          builder: (context) => ProductDependencies(
            child: BlocProvider(
              create: (context) => ProductBloc(
                context.read<GetProducts>(),
                context.read<GetProductDetails>(),
              )..add(GetProductEvent()),
              child: const ProductPage(),
            ),
          ),
        );


      case productDetails:

        final productId = setting.arguments as int;

        return MaterialPageRoute(
          builder: (context) => ProductDependencies(
            child: BlocProvider(
              create: (context) => ProductBloc(
                context.read<GetProducts>(),
                context.read<GetProductDetails>(),
              )..add(GetProductDetailEvent(productId)),
              child: ProductDetailPage(),
            ),
          ),
        );


      default:

        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("route ${setting.name} not found"),
            ),
          ),
        );
    }
  }
}