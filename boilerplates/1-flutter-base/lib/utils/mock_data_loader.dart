import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product_model.dart';

/// MockDataLoader handles loading local JSON files as mock data.
/// It simulates API calls and is used for prototyping and testing.
class MockDataLoader {
  /// Loads `products.json` and returns a list of ProductModel objects
  static Future<List<ProductModel>> loadMockProducts() async {
    final String jsonString = await rootBundle.loadString('lib/assets/mock_data/products.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  /// Loads `categories.json` (for example) and returns a list of category strings
  static Future<List<String>> loadMockCategories() async {
    final String jsonString = await rootBundle.loadString('lib/assets/mock_data/categories.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return List<String>.from(jsonList);
  }

  /// A generic loader (if you want to write dynamic parsing logic)
  static Future<List<dynamic>> loadRawJson(String path) async {
    final String jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString) as List<dynamic>;
  }
}
