import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:catalog_app/features/products/domain/entites/product_entity.dart';

part 'product_models.freezed.dart';
part 'product_models.g.dart';

/// 🔥 TOP-LEVEL FUNCTIONS (IMPORTANT)
List<String> imagesFromJson(dynamic value) {
  if (value == null) return [];

  if (value is String) {
    return List<String>.from(jsonDecode(value));
  } else if (value is List) {
    return List<String>.from(value);
  }

  return [];
}

dynamic imagesToJson(List<String> images) {
  return jsonEncode(images);
}

@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String description,
    @Default(0.0) double price,
    @Default(0.0) double discountPercentage,
    @Default(0.0) double rating,
    @Default(0) int stock,
    @Default('') String brand,
    @Default('') String category,
    @Default('') String thumbnail,

    /// 🔥 IMPORTANT: no @Default here
    @JsonKey(fromJson: imagesFromJson, toJson: imagesToJson)
    required List<String> images,

    /// 🔥 for offline image
    @Default('') String localImagePath,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// 🔄 Convert to Entity
  ProductEntity toEntity() => ProductEntity(
    id: id,
    title: title,
    description: description,
    price: price,
    discountPercentage: discountPercentage,
    rating: rating,
    stock: stock,
    brand: brand,
    category: category,
    thumbnail: thumbnail,
    images: images,
    localImagePath: localImagePath
  );

  /// 💾 For SQLite DB
  Map<String, dynamic> toDbJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "price": price,
      "images": jsonEncode(images), // store as string
      "localImagePath": localImagePath,
    };
  }
}