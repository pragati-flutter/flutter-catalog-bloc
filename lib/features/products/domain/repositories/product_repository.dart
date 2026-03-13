
import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/products/data/models/product_models.dart';

import '../entites/product_entity.dart';
import 'package:dartz/dartz.dart';
abstract class ProductRepository {
  Future<Either<Failure,List<ProductEntity>>> getProducts();
  Future<Either<Failure,List<ProductEntity>>>searchProduct(String query);
  Future<Either<Failure,ProductEntity>> getProductDetails(int id);
}
