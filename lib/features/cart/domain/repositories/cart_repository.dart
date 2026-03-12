
import 'package:catalog_app/core/error/failure.dart';

import '../entites/cart_entity.dart';
import 'package:dartz/dartz.dart';
abstract class CartRepository {
  Either<Failure, List<CartEntity>> getAllCartItems();

  Either<Failure, void> addToCart(CartEntity cartItem);

  Either<Failure, void> removeToCart(int productId);


}
