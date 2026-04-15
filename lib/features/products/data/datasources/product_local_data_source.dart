import 'dart:convert';

import 'package:catalog_app/core/database/database_helper.dart';
import 'package:catalog_app/features/products/data/models/product_models.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/utils/image_helper.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> productList);
  Future<List<ProductModel>> getProduct();
}

class ProductLocalDataSourceImplementation implements ProductLocalDataSource {
  DatabaseHelper databaseHelper;
  ProductLocalDataSourceImplementation(this.databaseHelper);
  @override
  Future<void> cacheProducts(List<ProductModel> productList) async {
    final db = await databaseHelper.database;
    for (var product in productList) {


      String? localPath;

      if (product.images.isNotEmpty) {
        localPath = await ImageHelper.downloadAndSaveImage(
          url: product.images[0],
          id: product.id,
        );
      }

      final updatedProduct = product.copyWith(
        localImagePath: localPath!,
      );

      await db.insert(
        'products',
        updatedProduct.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );


    }
  }

  @override
  Future<List<ProductModel>> getProduct() async {
    debugPrint("hey i am calledx");
    final db = await databaseHelper.database;
    final response = await db.query('products');

    debugPrint("product is given by....${response}");

    return response.map((e) {
      final map = Map<String, dynamic>.from(e); // ✅ COPY

      map['images'] = map['images'] is String
          ? jsonDecode(map['images'] as String)
          : map['images'];

      return ProductModel.fromJson(map);
    }).toList();
  }
}
