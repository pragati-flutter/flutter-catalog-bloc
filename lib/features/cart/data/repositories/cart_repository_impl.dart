/*
import 'package:catalog_app/core/error/exceptions.dart';
import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:catalog_app/features/cart/data/models/cart_models.dart';
import 'package:catalog_app/features/cart/domain/entites/cart_entity.dart';
import 'package:catalog_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:catalog_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:catalog_app/features/products/domain/entites/product_entity.dart';
import 'package:catalog_app/features/products/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;
  CartRepositoryImpl(this.localDataSource);

  @override
  Either<Failure, void> addToCart(CartEntity cartItem) {
    try{
      final cartEntity = CartItemModel.fromEntity(cartItem);
      localDataSource.addToCart(cartEntity);
      return Right(null);
    }on CacheException{
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, List<CartEntity>> getAllCartItems() {
  try{
    final cartItemList = localDataSource.getCartItems();
    return Right(cartItemList);

  }on CacheException{
    return Left(CacheFailure());
  }
  }

  @override
  Either<Failure, void> removeToCart(int productId) {
   try{
     localDataSource.removeFromCart(productId);
     return Right(null);
   }on CacheException{
     return Left(CacheFailure());
   }
  }


}
*/


import 'package:catalog_app/core/error/exceptions.dart';
import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:catalog_app/features/cart/data/models/cart_item_model.dart';  // ✅ fixed
import 'package:catalog_app/features/cart/domain/entites/cart_entity.dart';
import 'package:catalog_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:catalog_app/features/products/data/models/product_models.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;
  CartRepositoryImpl(this.localDataSource);

  @override
  Either<Failure, void> addToCart(CartEntity cartItem) {
    try {
      final cartModel = CartItemModel.fromEntity(cartItem); // ✅ safe conversion
      localDataSource.addToCart(cartModel);


      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, List<CartEntity>> getAllCartItems() {
    try {
      final cartItemList = localDataSource.getCartItems();
      final entities = cartItemList.map((e) => e.toEntity()).toList();
      return Right(entities);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, void> removeToCart(int productId) {
    try {
      localDataSource.removeFromCart(productId);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
