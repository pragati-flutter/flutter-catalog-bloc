import 'package:catalog_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class RemoveFromCart {
  final CartRepository cartRepository;

  RemoveFromCart(this.cartRepository);



  Either<Failure, void> call(int productId) {
    return cartRepository.removeToCart(productId);
  }
}
