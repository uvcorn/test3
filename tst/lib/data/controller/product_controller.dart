import 'package:http/http.dart' as http;
import 'package:tst/data/models/product_model.dart';
import 'dart:convert';

class Urls {
  static String baseURL = 'http://35.73.30.144:2008/api/v1';
  static String createProduct = '$baseURL/CreateProduct';
  static String readProduct = '$baseURL/ReadProduct';
  static String updateProduct(String id) => '$baseURL/UpdateProduct/$id';
  static String deleteProduct(String id) => '$baseURL/DeleteProduct/$id';
}

class ProductController {
  List<Data> products = [];

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(Urls.readProduct));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ProductModel model = ProductModel.fromJson(data);
      products = model.data ?? [];
    }
  }

  Future<void> createProduct(
    String name,
    String img,
    int qty,
    int price,
    int totalPrice,
  ) async {
    final response = await http.post(
      Uri.parse(Urls.createProduct),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": price,
        "TotalPrice": totalPrice,
      }),
    );

    if (response.statusCode == 201) {
      fetchProducts();
    }
  }

  Future<void> updateProduct(
    String id,
    String name,
    String img,
    int qty,
    int price,
    int totalPrice,
  ) async {
    final response = await http.post(
      Uri.parse(Urls.updateProduct(id)),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": price,
        "TotalPrice": totalPrice,
      }),
    );

    if (response.statusCode == 201) {
      fetchProducts();
    }
  }

  Future<bool> deleteProducts(String id) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(id)));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
