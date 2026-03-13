import 'package:catalog_app/core/error/exceptions.dart';
import 'package:catalog_app/core/network/dio_client.dart';
import 'package:catalog_app/features/cart/data/models/cart_models.dart';
import 'package:catalog_app/features/products/data/models/product_models.dart';
import 'package:dio/dio.dart';

abstract class CartLocalDataSource {
  List<CartItemModel> getCartItems();
  void addToCart(CartItemModel cartItem);
  void removeFromCart(int productId);
}

class CartLocalDatasourceImplementation implements CartLocalDataSource {
  final List<CartItemModel> _cartItemList = [];

  @override
  void addToCart(CartItemModel cartItem) {
    try {
      final index = _cartItemList.indexWhere(
        (e) => e.productEntity.id == cartItem.productEntity.id,
      );

      if (index != -1) {
        _cartItemList[index] = _cartItemList[index].copyWith(
          quantity: _cartItemList[index].quantity + 1,
        );
      } else {
        _cartItemList.add(cartItem);
      }
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  List<CartItemModel> getCartItems() {
    try {
      return _cartItemList;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  void removeFromCart(int productId) {
    try {
      final index = _cartItemList.indexWhere(
        (e) => e.productEntity.id == productId,
      );
      if (_cartItemList[index].quantity != 1) {
        _cartItemList[index] = _cartItemList[index].copyWith(
          quantity: _cartItemList[index].quantity - 1,
        );
      } else {
        _cartItemList.removeWhere((e) => e.productEntity.id == productId);
        print("now i should remove this item ");
      }
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
