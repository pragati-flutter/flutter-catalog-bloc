
part of 'product_bloc.dart';

abstract class ProductState extends Equatable{

}

class ProductInitialState extends ProductState{
  @override
  List<Object?> get props => [];

}

class ProductLoadingState extends ProductState{
  @override

  List<Object?> get props => [];

}

class ProductLoadedState extends ProductState{
  final List<ProductEntity>products;
  ProductLoadedState(this.products);

  @override

  List<Object?> get props => [products];

}

class ProductDetailLoadedState extends ProductState{
  final ProductEntity product;
  ProductDetailLoadedState(this.product);
  @override
  List<Object?> get props => [product];

}

class ProductError extends ProductState{
  final String message;
  ProductError(this.message);

  @override
  List<Object?> get props => [message];

}