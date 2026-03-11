
import 'package:catalog_app/core/error/failure.dart';

import '../entites/cart_entity.dart';
import 'package:dartz/dartz.dart';
abstract class CartRepository {
  List<CartEntity>getAllCartItems();
  void addToCart();
  void removeToCart();
}
