part of 'cart_bloc.dart';
abstract class CartEvent extends Equatable{

}

class GetCartItems extends CartEvent{
  final List<CartEntity>getAllCartItems;
  GetCartItems(this.getAllCartItems);
  @override
  // TODO: implement props
  List<Object?> get props => [getAllCartItems];

}

class AddItemsToCartEvent extends  CartEvent{
  final CartEntity cartItem;

  AddItemsToCartEvent({required this.cartItem});
  @override
  // TODO: implement props
  List<Object?> get props => [cartItem];

}

class RemoveItemToCartEvent extends CartEvent{
  final int id;
 RemoveItemToCartEvent(this.id);

  @override
  List<Object?> get props => [id];

}