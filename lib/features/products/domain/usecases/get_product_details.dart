import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/products/domain/entites/product_entity.dart';
import 'package:catalog_app/features/products/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductDetails{
final ProductRepository productRepository;
GetProductDetails(this.productRepository);

Future<Either<Failure,ProductEntity>>getProductDetails(int id)async{
return productRepository.getProductDetails(id);
}

}