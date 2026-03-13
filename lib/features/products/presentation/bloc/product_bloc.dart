import 'package:catalog_app/core/error/failure.dart';
import 'package:catalog_app/features/products/data/models/product_models.dart';
import 'package:catalog_app/features/products/domain/usecases/get_product_details.dart';
import 'package:catalog_app/features/products/domain/usecases/get_products.dart';
import 'package:catalog_app/features/products/domain/usecases/search_products.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entites/product_entity.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final GetProductDetails getProductDetails;
  final SearchProducts searchProducts;
  ProductBloc(this.getProducts,this.getProductDetails,this.searchProducts) : super(ProductInitialState()) {
    on<GetProductEvent>(_onGetProductEvent);
    on<GetProductDetailEvent>(_onGetProductDetailEvent);
    on<SearchProductEvent>(_onSearchProductEvent);
  }

  Future<void> _onGetProductEvent(
    GetProductEvent event,
    Emitter<ProductState> emit ,
  ) async {
    try {
      emit(ProductLoadingState());

      final result = await getProducts.getAllProducts();
      print("result is given by...$result");
      result.fold(
        (failure) => emit(ProductError(_mapFailureToMessage(failure))),
        (products) => emit(ProductLoadedState(products)),
      );
    } catch (e) {
      emit(ProductError("Unexpected Error"));
    }
  }

  Future<void> _onGetProductDetailEvent(
    GetProductDetailEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoadingState());
      final result = await getProductDetails.getProductDetails(event.id);
      result.fold(
        (failure) => emit(ProductError(_mapFailureToMessage(failure))),
        (product) => emit(ProductDetailLoadedState(product)),

      );
    } catch (e) {
      emit(ProductError('Unexpected error'));
    }
  }



  Future<void> _onSearchProductEvent(
      SearchProductEvent event,
      Emitter<ProductState> emit,
      ) async {
    try {
      emit(ProductLoadingState());
      print("event query is given by ...${event.query}");
      final result = await searchProducts(event.query);
      result.fold(
            (failure) => emit(SearchProductError(_mapFailureToMessage(failure))),
            (product) => emit(ProductLoadedState(product)),
      );
    } catch (e) {
      emit(ProductError('Unexpected error'));
    }
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
