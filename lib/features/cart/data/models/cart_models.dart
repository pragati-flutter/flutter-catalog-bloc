import 'package:catalog_app/features/products/data/models/product_models.dart';

import '../../domain/entites/cart_entity.dart';



class CartItemModel extends CartEntity {
  const CartItemModel({
    required super.quantity,
    required super.productEntity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      quantity: json['quantity'],
      productEntity: ProductModel.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': (productEntity as ProductModel).toJson(),
      'quantity': quantity,
    };
  }

  CartItemModel copyWith({
    int? quantity,
  }) {
    return CartItemModel(
      quantity: quantity ?? this.quantity,
      productEntity: productEntity,
    );
  }
}