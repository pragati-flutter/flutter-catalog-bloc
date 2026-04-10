import 'package:catalog_app/core/database/database_helper.dart';
import 'package:catalog_app/features/cart/data/models/cart_item_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class CartLocalDataSource {
  Future<void> addToCartItem(CartItemModel cartItem);
  Future<void> removeFromCart(int id);
  Future<List<CartItemModel>> getCartItems();
}

class CartLocalDataSourceImplementation implements CartLocalDataSource {
   DatabaseHelper databaseHelper;

  CartLocalDataSourceImplementation(this.databaseHelper);

  @override
  Future<void> addToCartItem(CartItemModel cartItem) async{
    final db = await databaseHelper.database;
    await  db.insert('cart',
    cartItem.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }



  @override
  Future<List<CartItemModel>> getCartItems() async {
    final db = await databaseHelper.database;
    final response = await db.query('cart');
   return response.map((e)=>CartItemModel.fromJson(e)).toList();

  }

  @override
  Future<void> removeFromCart(int id) async {
    final db = await databaseHelper.database;
    await db.delete('cart',
    where: 'id = ?',
     whereArgs:  [id]
    );
  }
}
