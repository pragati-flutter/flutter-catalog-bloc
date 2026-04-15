import 'package:catalog_app/core/error/exceptions.dart';
import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/products/data/datasources/product_local_data_source.dart';
import 'package:catalog_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:catalog_app/features/products/domain/entites/product_entity.dart';
import 'package:catalog_app/features/products/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

class ProductRepositoryImplementation implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  ProductRepositoryImplementation(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      //  API call
      final productList = await remoteDataSource.getProducts();

      //  Save to local DB
      await localDataSource.cacheProducts(productList);
      print(" Data saved to DB");

      final entities = productList.map((e) => e.toEntity()).toList();

      final localProducts = await localDataSource.getProduct();
      print("local product is given by ${localProducts}");
      return Right(entities);

    } catch (e) {
      print("Loading from DB because of error: $e");

      final localProducts = await localDataSource.getProduct();
      print("local product is given by ${localProducts}");

      if (localProducts.isNotEmpty) {
        final entities = localProducts.map((e) => e.toEntity()).toList();
        return Right(entities);
      } else {
        return Left(ServerFailure()); // or CacheFailure
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(int id) async {
    try {
      final product = await remoteDataSource.getProductDetails(id);
      await localDataSource.cacheProducts([product]);
      return Right(product.toEntity());
    } on NetworkException {
      final localProducts = await localDataSource.getProduct();
      final product = localProducts.firstWhere(
            (element) => element.id == id,
      );
      final entites = product.toEntity();
      return Right(entites);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProduct(
    String query,
  ) async {
    try {
      print("data level query is given by ...${query}");
      final productList = await remoteDataSource.searchProduct(query);
      final entities = productList.map((e) => e.toEntity()).toList();

      return Right(entities);
    } on NetworkException {
      return Left(NetworkFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
