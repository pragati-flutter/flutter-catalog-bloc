import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/products/domain/entites/product_entity.dart';
import 'package:catalog_app/features/products/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProducts{
final ProductRepository productRepository;
GetProducts(this.productRepository);


Future<Either<Failure,List<ProductEntity>>>getAllProducts(){
  return productRepository.getProducts();


}

Future<Either<Failure,ProductEntity>>getProductDetails(int id){
  return productRepository.getProductDetails(id);


}


}