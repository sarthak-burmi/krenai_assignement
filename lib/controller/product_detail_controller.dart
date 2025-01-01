import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:krenai_assignement/modal/product_detail.dart';

class ProductDetailsController extends GetxController {
  final Rx<ProductDetails?> productDetails = Rx<ProductDetails?>(null);
  final RxBool isLoading = true.obs;

  Future<void> fetchProductDetails(int productId) async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(
            'https://storeapi.wekreta.in/api/v4/product/detail?productId=$productId&sizeChartPreference=category&categoryName=&accessKey=7f1016e1-048f-11ef-a3f4-02c89aaa64a3'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        productDetails.value = ProductDetails.fromJson(jsonData);
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      print('Error fetching product details: $e');
      throw e;
    } finally {
      isLoading.value = false;
    }
  }
}
