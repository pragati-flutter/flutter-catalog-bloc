

import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entites/product_entity.dart';
import '../../domain/usecases/get_product_details.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/search_products.dart';
part 'product_state.dart';
part 'product_event.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final GetProductDetails getProductDetails;
  final SearchProducts searchProducts;

  ProductBloc(
      this.getProducts,
      this.getProductDetails,
      this.searchProducts,
      ) : super(ProductInitialState()) {
    on<GetProductEvent>(_onGetProductEvent);
    on<GetProductDetailEvent>(_onGetProductDetailEvent);
    on<SearchProductEvent>(_onSearchProductEvent);
  }

  Future<void> _onGetProductEvent(
      GetProductEvent event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoadingState());
    final result = await getProducts.getAllProducts();
    debugPrint('result is given by ...${result}');

    result.fold(
          (failure) => emit(ProductError(_mapFailureToMessage(failure))),
          (products) => emit(ProductLoadedState(products)),
    );
  }

  Future<void> _onGetProductDetailEvent(
      GetProductDetailEvent event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoadingState());

    final result = await getProductDetails.getProductDetails(event.id);

    result.fold(
          (failure) => emit(ProductError(_mapFailureToMessage(failure))),
          (product) => emit(ProductDetailLoadedState(product)),
    );
  }

  Future<void> _onSearchProductEvent(
      SearchProductEvent event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoadingState());

    final result = await searchProducts(event.query);

    result.fold(
          (failure) => emit(SearchProductError(_mapFailureToMessage(failure))),
          (products) => emit(ProductLoadedState(products)),
    );
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