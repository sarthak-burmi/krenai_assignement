import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:krenai_assignement/modal/prodduct_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(
          'https://storeapi.wekreta.in/api/v4/product/customer?id=0&secondaryKey=b13435eb-7643-11ef-a3d0-025a30235915&productName=&categoryName=kitchen%20%26%20dining&subCategoryName=cook%20wear&subSubCategoryName=&brandName=&isFeatured=0&search=&currentPage=1&itemsPerPage=40&sortBy=createdDate&sortOrder=desc&isFetchListing=0&searchTag=&accessKey=7f1016e1-048f-11ef-a3f4-02c89aaa64a3'));
      print('API Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status']) {
          var productList = data['object'] as List;
          products.value =
              productList.map((product) => Product.fromJson(product)).toList();
          // Save products to local storage
          saveProductsToLocal(products.value);
        }
      }
    } catch (e) {
      print('Error fetching products: $e');
      // Load products from local storage if there's an error
      loadProductsFromLocal();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveProductsToLocal(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productJsonList =
        products.map((product) => json.encode(product.toJson())).toList();
    await prefs.setStringList('products', productJsonList);
  }

  Future<void> loadProductsFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? productJsonList = prefs.getStringList('products');
    if (productJsonList != null) {
      products.value = productJsonList
          .map((jsonStr) => Product.fromJson(json.decode(jsonStr)))
          .toList();
    }
  }

  int get totalProducts => products.length;
}
