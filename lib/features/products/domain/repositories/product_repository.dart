
import 'package:catalog_app/core/error/failure.dart';

import '../entites/product_entity.dart';
import 'package:dartz/dartz.dart';
abstract class ProductRepository {
  Future<Either<Failure,List<ProductEntity>>> getProducts();
  /*Future<List<ProductEntity>> searchProducts(String query);
 */
  Future<Either<Failure,ProductEntity>> getProductDetails(int id);
}
