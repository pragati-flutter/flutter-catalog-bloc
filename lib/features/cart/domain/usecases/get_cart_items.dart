import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/cart/domain/entites/cart_entity.dart';
import 'package:catalog_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class GetCartItem{
  final CartRepository cartRepository;
  GetCartItem(this.cartRepository);

  Either<Failure, List<CartEntity>>call(){
    return cartRepository.getAllCartItems();
  }
}