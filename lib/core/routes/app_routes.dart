/*
import 'package:catalog_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:catalog_app/features/cart/presentation/pages/cart_page.dart';

import 'package:catalog_app/features/products/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalog_app/core/di/service_locator.dart';


import '../../features/products/presentation/bloc/product_bloc.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';

class AppRoutes {
  static const String products = '/';
  static const String productDetails = '/product-details';
  static const String cartPage = '/cart_page';

  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {

      case products:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => sl<CartBloc>(),
              ),
              BlocProvider(
                create: (_) => sl<ProductBloc>()
                  ..add(GetProductEvent()),
              ),
            ],
            child: const ProductPage(),
          ),
        );

      case productDetails:
        final productId = setting.arguments as int;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => sl<CartBloc>(),
              ),
              BlocProvider(
                create: (_) => sl<ProductBloc>()
                  ..add(GetProductDetailEvent(productId)),
              ),
            ],
            child: ProductDetailPage(),
          ),
        );

      case cartPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => sl<CartBloc>(),
            child: CartPage(),
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
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalog_app/core/di/service_locator.dart';

import '../../features/products/presentation/bloc/product_bloc.dart';
import '../../features/products/presentation/pages/product_page.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/cart/presentation/pages/cart_page.dart';

class AppRoutes {
  static const String products = '/';
  static const String productDetails = '/product-details';
  static const String cartPage = '/cart_page';

  static final CartBloc _cartBloc = sl<CartBloc>();

  static final ProductBloc _productBloc = sl<ProductBloc>()
    ..add(GetProductEvent()); // load once

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

    /// ---------------- PRODUCTS PAGE ----------------
      case products:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _cartBloc),
              BlocProvider.value(value: _productBloc),
            ],
            child: const ProductPage(),
          ),
        );

    /// ---------------- PRODUCT DETAILS ----------------
      case productDetails:
        final productId = settings.arguments as int;

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _cartBloc),
              BlocProvider.value(value: _productBloc),
            ],
            child: ProductDetailPage( ),
          ),
        );

    /// ---------------- CART PAGE ----------------
      case cartPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _cartBloc,
            child: const CartPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Route not found")),
          ),
        );
    }
  }
}