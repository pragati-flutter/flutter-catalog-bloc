import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/cart/data/models/cart_models.dart';
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

  CartBloc() : super((CartInitialState())) {
    on<GetCartItems>(_onGetCartItemsEvent);

  }

  Future<void> _onGetCartItemsEvent(
    GetCartItems event,
    Emitter<CartState> emit ,
  ) async {

  }

  Future<void>_onAddCartItemEvent(
      AddItemsToCartEvent event,
      Emitter<CartState>emit,
      )async {

  }

  Future<void>_onRemoveCartItemEvent(
      AddItemsToCartEvent event,
      Emitter<CartState> emit
      )async{

  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return "No Internet Connection";
    } else if (failure is ServerFailure) {
      return "Server Error";
    } else {
      return "Unexpected Error";
    }
  }
}
