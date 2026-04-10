
import 'package:catalog_app/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:catalog_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:catalog_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:catalog_app/features/cart/domain/usecases/add_to_cart.dart';
import 'package:catalog_app/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:catalog_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:catalog_app/features/cart/presentation/pages/cart_page.dart';
import 'package:catalog_app/features/products/domain/usecases/get_product_details.dart';
import 'package:catalog_app/features/products/domain/usecases/get_products.dart';
import 'package:catalog_app/features/products/domain/usecases/search_products.dart';
import 'package:catalog_app/features/products/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/di/cart_dependencies.dart';
import '../../features/cart/domain/usecases/get_cart_items.dart';
import '../../features/products/di/product_dependencies.dart';
import '../../features/products/presentation/bloc/product_bloc.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';

class AppRoutes {
  static const String products = '/';
  static const String productDetails = '/product-details';
  static const String cartPage = '/cart_page';


  static final CartLocalDataSource _cartLocalDataSource =
  CartLocalDatasourceImplementation();
  static final CartRepository _cartRepository =
  CartRepositoryImpl(_cartLocalDataSource);
  static final CartBloc cartBloc = CartBloc(
    AddToCart(_cartRepository),
    RemoveFromCart(_cartRepository),
    GetCartItem(_cartRepository),
  );

  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case products:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cartBloc, // reuse same instance
            child: ProductDependencies(
              child: BlocProvider(
                create: (context) => ProductBloc(
                  context.read<GetProducts>(),
                  context.read<GetProductDetails>(),
                  context.read<SearchProducts>(),
                )..add(GetProductEvent()),
                child: const ProductPage(),
              ),
            ),
          ),
        );

      case productDetails:
        final productId = setting.arguments as int;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cartBloc, // reuse same instance
            child: ProductDependencies(
              child: BlocProvider(
                create: (context) => ProductBloc(
                  context.read<GetProducts>(),
                  context.read<GetProductDetails>(),
                  context.read<SearchProducts>()
                )..add(GetProductDetailEvent(productId)),
                child: ProductDetailPage(),
              ),
            ),
          ),
        );

      case cartPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cartBloc,
            child: CartPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text("route ${setting.name} not found")),
          ),
        );
    }
  }
}
