import 'package:catalog_app/core/error/exceptions.dart';
import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/cart/domain/entites/cart_entity.dart';
import 'package:catalog_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:catalog_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:catalog_app/features/products/domain/entites/product_entity.dart';
import 'package:catalog_app/features/products/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl implements CartRepository{
  final ProductRemoteDataSource remoteDataSource;
   CartRepositoryImpl(this.remoteDataSource);

  @override
  void addToCart() {
    // TODO: implement addToCart
  }

  @override
  List<CartEntity> getAllCartItems() {
    // TODO: implement getAllCartItems
    throw UnimplementedError();
  }

  @override
  void removeToCart() {
    // TODO: implement removeToCart
  }









}