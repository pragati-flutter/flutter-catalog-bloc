import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/cart/data/models/cart_models.dart';
import 'package:catalog_app/features/cart/domain/usecases/add_to_cart.dart';
import 'package:catalog_app/features/cart/domain/usecases/get_cart_items.dart';
import 'package:catalog_app/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:catalog_app/features/products/data/models/product_models.dart';
import 'package:catalog_app/features/products/domain/usecases/get_product_details.dart';
import 'package:catalog_app/features/products/domain/usecases/get_products.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entites/cart_entity.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final GetCartItem getCartItems;

  CartBloc(this.addToCart, this.removeFromCart, this.getCartItems)
      : super((CartInitialState())) {
    on<GetCartItems>(_onGetCartItemsEvent);
    on<AddItemsToCartEvent>(_onAddCartItemEvent);
    on<RemoveItemToCartEvent>(_onRemoveCartItemEvent);
  }

  Future<void> _onGetCartItemsEvent(GetCartItems event,
      Emitter<CartState> emit,) async {
    try {
      emit(CartLoadingState());

      final result = getCartItems();
      print("result is ....${result}");
      result.fold(
            (failure) => emit(CartError('Cache Error ')),
            (getCartItems) => emit(CartLoadedState(getCartItems)),
      );
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddCartItemEvent(AddItemsToCartEvent event,
      Emitter<CartState> emit,) async {
    try {
      emit(CartLoadingState());
      final result = addToCart(event.cartItem);
      result.fold((failure) => emit(CartError('Cache error')), (_) =>
          emit(CartAddedSuccessState("cart added successfully")));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveCartItemEvent(RemoveItemToCartEvent event,
      Emitter<CartState> emit,) async {
    try {
      emit(CartLoadingState());
      final result = removeFromCart(event.id);
      result.fold((failure) => emit(CartError('Cache Error')), (_) =>
          emit(CartAddedSuccessState("cart added successfully")));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
