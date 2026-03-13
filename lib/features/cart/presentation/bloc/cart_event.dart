part of 'cart_bloc.dart';
abstract class CartEvent extends Equatable{

}

class GetCartItems extends CartEvent{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AddItemsToCartEvent extends  CartEvent{
  final CartEntity cartItem;

  AddItemsToCartEvent({required this.cartItem});
  @override

  List<Object?> get props => [cartItem];

}

class RemoveItemToCartEvent extends CartEvent{
  final List<CartEntity>entity;
  final int id;
 RemoveItemToCartEvent(this.id,this.entity);

  @override
  List<Object?> get props => [id,entity];

}