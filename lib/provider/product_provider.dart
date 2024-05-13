import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api_client/api_client.dart';
import '../constants/api_config.dart';
import '../models/product_model.dart';

enum AppState { loading, complete, loadMore, noNextPage, error }

class ProductProvider extends ChangeNotifier {
  ProductProvider() {
    getProduct();
  }

  bool hasNextPage = true;
  int page = 1;
  List<Product> productList = [];

  final _apiClient = Api();
  String _errorMessage = '';
  AppState _state = AppState.loading;

  AppState get state => _state;

  String get errorMessage => _errorMessage;

  Future<void> getProduct() async {
    try {
      _state = AppState.loading;
      notifyListeners();
      productList.clear();
      page = 1;
      hasNextPage = true;
      List<dynamic>? productTemp = await productAPICall();
      productTemp.map((e) => productList.add(Product.fromJson(e))).toList();
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

  Future<List<dynamic>> productAPICall() async {
    try {
      var url = ApiConfig.baseUrl + ApiEndPoint.product;
      final response = await _apiClient.client<dynamic>(
        RequestOptions(
          method: 'POST',
          path: url,
          data: FormData.fromMap({'page': page}),
          headers: <String, String>{
            'appid': '2IPbyrCUM7s5JZhnB9fxFAD6',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data['list'];
      }
    } catch (error) {
      _errorMessage = error.toString();
      _state = AppState.error;
    }
    return [];
  }

  Future<void> loadMoreProduct(ScrollController scrollController) async {
    if (hasNextPage == true &&
        state == AppState.complete &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
      _state = AppState.loadMore;
      notifyListeners();
      page += 1;
      try {
        List<dynamic> products = await productAPICall();
        _state = AppState.complete;
        if (products.isNotEmpty) {
          products.map((e) => productList.add(Product.fromJson(e))).toList();
          notifyListeners();
        } else {
          hasNextPage = false;
          notifyListeners();
        }
      } catch (err) {
        debugPrint('Something went wrong!');
      }
    }
  }
}
