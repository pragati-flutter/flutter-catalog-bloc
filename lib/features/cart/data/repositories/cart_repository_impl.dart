

import 'package:catalog_app/core/error/exceptions.dart';
import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:catalog_app/features/cart/data/models/cart_item_model.dart';  // ✅ fixed
import 'package:catalog_app/features/cart/domain/entites/cart_entity.dart';
import 'package:catalog_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/cart_local_datasources.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;
  CartRepositoryImpl(this.remoteDataSource,this.localDataSource);

  @override
  Either<Failure, void> addToCart(CartEntity cartItem) {
    final cartModel = CartItemModel.fromEntity(cartItem);
    try {

      remoteDataSource.addToCart(cartModel);

      localDataSource.addToCartItem(cartModel);




      return Right(null);
    }on NetworkException{
      localDataSource.addToCartItem(cartModel);
      return Right(null);
    }
    on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, List<CartEntity>> getAllCartItems() {
    try {
      final cartItemList = remoteDataSource.getCartItems();
      final entities = cartItemList.map((e) => e.toEntity()).toList();



      return Right(entities);
    } on NetworkException{
      final localCartItemList = await localDataSource.getCartItems();
      final entities = localCartItemList.map((e)=>e.toEntity()).toList();
      return Right(entities);

    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, void> removeToCart(int productId) {
    try {
      remoteDataSource.removeFromCart(productId);
      localDataSource.removeFromCart(productId);
      return Right(null);
    } on NetworkException{
      localDataSource.removeFromCart(productId);
      return Right(null);
    }

    on CacheException {
      return Left(CacheFailure());
    }
  }
}
