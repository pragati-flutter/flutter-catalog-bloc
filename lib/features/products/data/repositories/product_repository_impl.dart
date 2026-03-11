import 'package:catalog_app/core/error/exceptions.dart';
import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:catalog_app/features/products/domain/entites/product_entity.dart';
import 'package:catalog_app/features/products/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImplementation implements ProductRepository{
  final ProductRemoteDataSource remoteDataSource;
   ProductRepositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts()async {
    try{
     final productList = await remoteDataSource.getProducts();
     print("data layer product is given by...${productList}");
     return Right(productList);
    }on NetworkException{
     return Left(NetworkFailure());
    }on ServerException{
      return Left(ServerFailure());
    }


  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(int id) async {
  try{
    final product = await remoteDataSource.getProductDetails(id);
    return Right(product);
  }on NetworkException{
   return Left(NetworkFailure());
  }on ServerException{
   return Left(ServerFailure());
  }
  }







}