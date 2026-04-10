import 'package:catalog_app/core/database/database_helper.dart';
import 'package:catalog_app/features/products/data/models/product_models.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';

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
      await db.insert(
        'product',
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<List<ProductModel>> getProduct() async {
    final db = await databaseHelper.database;
    final response = await db.query('product');
    return response.map((e) => ProductModel.fromJson(e)).toList();
  }
}
