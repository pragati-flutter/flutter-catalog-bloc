// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    _CartItemModel(
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      productEntity: ProductModel.fromJson(
        json['product'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$CartItemModelToJson(_CartItemModel instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'product': instance.productEntity,
    };
