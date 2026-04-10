import 'package:catalog_app/core/error/exceptions.dart';
import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/products/data/datasources/product_local_data_source.dart';
import 'package:catalog_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:catalog_app/features/products/domain/entites/product_entity.dart';
import 'package:catalog_app/features/products/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImplementation implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  ProductRepositoryImplementation(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final productList = await remoteDataSource.getProducts();

      await localDataSource.cacheProducts(productList);

      final entities = productList.map((e) => e.toEntity()).toList();

      return Right(entities);
    } on NetworkException {
      final localProducts = await localDataSource.getProduct();
      final entities = localProducts.map((e) => e.toEntity()).toList();
      print("here is network exception found");
      return Right(entities);
    } on ServerException {
      print("here is server exception found");
      return Left(ServerFailure());
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
