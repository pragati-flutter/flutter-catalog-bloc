import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:catalog_app/features/products/data/models/product_models.dart';
import 'package:catalog_app/features/products/domain/entites/product_entity.dart';
import 'package:catalog_app/features/cart/domain/entites/cart_entity.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
abstract class CartItemModel with _$CartItemModel {
  const CartItemModel._();

  const factory CartItemModel({
    @Default(0) int quantity,
    @JsonKey(name: 'product')
    required ProductModel productEntity,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  // ✅ Convert CartEntity → CartItemModel
  factory CartItemModel.fromEntity(CartEntity entity) => CartItemModel(
    quantity: entity.quantity,
    productEntity: ProductModel(
      id: entity.productEntity.id,
      title: entity.productEntity.title,
      description: entity.productEntity.description,
      price: entity.productEntity.price,
      discountPercentage: entity.productEntity.discountPercentage,
      rating: entity.productEntity.rating,
      stock: entity.productEntity.stock,
      brand: entity.productEntity.brand,
      category: entity.productEntity.category,
      thumbnail: entity.productEntity.thumbnail,
      images: entity.productEntity.images ?? [],
    ),
  );

  // ✅ Convert CartItemModel → CartEntity
  CartEntity toEntity() => CartEntity(
    quantity: quantity,
    productEntity: productEntity.toEntity(),
  );

  Map<String, dynamic> toDbJson() {
    return {
      "id": productEntity.id,
      "title": productEntity.title,
      "price": productEntity.price,
      "images": jsonEncode(productEntity.images),
      "quantity": quantity,
    };
  }
}