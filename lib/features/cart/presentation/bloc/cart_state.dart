
part of 'cart_bloc.dart';

abstract class CartState extends Equatable{

}

class CartInitialState extends CartState{
  @override
  List<Object?> get props => [];

}

class CartLoadingState extends CartState{
  @override

  List<Object?> get props => [];

}

class CartLoadedState extends CartState{
  final List<CartEntity>products;
  CartLoadedState(this.products);

  @override

  List<Object?> get props => [products];

}

class CartAddedSuccessState extends CartState{
  final String message;
  CartAddedSuccessState(this.message);
  @override
  List<Object?> get props => [message];

}

class CartError extends CartState{
  final String message;
  CartError(this.message);

  @override
  List<Object?> get props => [message];

}