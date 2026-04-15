import 'package:catalog_app/core/error/exceptions.dart';
import 'package:catalog_app/core/network/dio_client.dart';
import 'package:catalog_app/features/products/data/models/product_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel>getProductDetails(int id);
  Future<List<ProductModel>>searchProduct(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient dioClient;
  ProductRemoteDataSourceImpl(this.dioClient);
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dioClient.dio.get('/products');
      if (response.statusCode == 200) {
        final productList = (response.data['products'] as List)
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();


        if (kDebugMode) {
          print("product list images is given by ..${productList[1].images}");
        }
        return productList;
      } else {

        throw ServerException();
      }
    } on DioException {
      throw NetworkException();
    } catch (e, stackTrace) {

      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductDetails(int id) async {
    try {
      final response = await dioClient.dio.get('/product/$id');
      if (response.statusCode == 200) {
        final product = ProductModel.fromJson(response.data);

        return product;
      } else {
        throw ServerException();
      }
    } on DioException {
      throw NetworkException();
    } catch (e, stackTrace) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>>searchProduct(String query) async {
    try {

      final response = await dioClient.dio.get('products/search',queryParameters: {'q':query});
print("hey searching is cll $query");
      if (response.statusCode == 200) {
        print("response code i am...${response.statusCode}");
        final productList = (response.data['products'] as List)
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
        print("hello phone i am here  ..${productList[1].images}");
        return productList;
      } else {
        throw ServerException();
      }
    } on DioException {
      throw NetworkException();
    } catch (e, stackTrace) {
      throw ServerException();
    }
  }



}
