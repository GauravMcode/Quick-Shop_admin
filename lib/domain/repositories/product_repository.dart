import 'dart:convert';

import 'package:admin_shop/data/local/local_data.dart';
import 'package:admin_shop/data/remote/remote_data.dart';
import 'package:admin_shop/domain/models/product.dart';
import 'package:http/http.dart';

class ProductRepository {
  static Future<Map> addProduct(Product product) async {
    final body = product.toJson();
    final jwt = await JwtProvider.getJwt();
    final Response response = await DataProvider.postData('add-product/admin', body, jwt: jwt);
    final data = {'data': Product.fromMap(json.decode(response.body)['data']), 'status': response.statusCode};
    return data;
  }

  static Future<Map> getProduct(String id) async {
    final jwt = await JwtProvider.getJwt();
    final Response response = await DataProvider.getData('product/$id/admin', jwt: jwt);
    final data = {'data': Product.fromMap(json.decode(response.body)['data']), 'status': response.statusCode};
    return data;
  }

  static Future<Map> getAllProducts() async {
    final jwt = await JwtProvider.getJwt();
    final Response response = await DataProvider.getData('products/admin', jwt: jwt);
    final List products = json.decode(response.body)['data'] ?? [];
    final List<Product> data = products.map((e) => Product.fromMap(e)).toList();
    return {'data': data, 'status': response.statusCode};
  }

  static Future<String> deleteProduct(String id) async {
    final jwt = await JwtProvider.getJwt();
    final Response response = await DataProvider.deleteData('delete-product/$id/admin', id, jwt: jwt);
    final data = json.decode(response.body)['data'];
    return data;
  }
}















//String title, String description, String imageUrl, int price, int quantity, String adminId, {int sales = 0, int views = 0}