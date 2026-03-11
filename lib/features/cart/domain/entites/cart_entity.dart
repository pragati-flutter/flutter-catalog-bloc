import 'package:catalog_app/features/products/domain/entites/product_entity.dart';
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
   final ProductEntity productEntity;
   final int quantity;
  const CartEntity({
    required this.productEntity,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
   productEntity,
    quantity
  ];
}
