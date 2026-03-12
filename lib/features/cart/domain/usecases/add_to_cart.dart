import 'package:catalog_app/features/cart/domain/entites/cart_entity.dart';
import 'package:catalog_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class AddToCart{
  final CartRepository cartRepository;
  AddToCart(this.cartRepository);



  Either<Failure, void> call(CartEntity cartItem){
    return cartRepository.addToCart(cartItem);
  }


}