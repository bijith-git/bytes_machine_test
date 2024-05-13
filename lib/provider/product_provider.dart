import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api_client/api_client.dart';
import '../constants/api_config.dart';
import '../models/product_model.dart';

enum AppState { loading, complete, error }

class ProductProvider extends ChangeNotifier {
  ProductProvider() {
    getUsers();
  }

  List<Product> productList = [];

  final _apiClient = Api();
  String _errorMessage = '';
  AppState _state = AppState.loading;

  AppState get state => _state;

  String get errorMessage => _errorMessage;

  void getUsers() async {
    try {
      _state = AppState.loading;
      notifyListeners();
      var url = ApiConfig.baseUrl + ApiEndPoint.product;
      final response = await _apiClient.client<dynamic>(
        RequestOptions(
          method: 'POST',
          path: url,
          data: FormData.fromMap({'page': 1}),
          headers: <String, String>{
            'appid': '2IPbyrCUM7s5JZhnB9fxFAD6',
          },
        ),
      );
      response.data['list']
          .map((e) => productList.add(Product.fromJson(e)))
          .toList();
      _state = AppState.complete;
    } catch (error) {
      _errorMessage = error.toString();
      _state = AppState.error;
      if (error is DioException) {
        debugPrint(error.response?.data);
      }
    } finally {
      notifyListeners();
    }
  }
}
