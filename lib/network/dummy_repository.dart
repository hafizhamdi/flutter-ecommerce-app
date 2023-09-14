import 'package:flutter_ecommerce_app/network/client.dart';

class DummyRepository {
  final NetworkClient client;

  DummyRepository({required this.client});

  findAllProduct() async{
    var result = await client.get(endpoint: "/products");
    return result.body;
  }

  findProductById(int id) async {
    var result = await client.get(endpoint: "/products/$id");
    return result.body;
  }
  findProductByQuery(String query) async {
    var result = await client.get(endpoint: "/products/search?q=$query");
    return result.body;
  }
  findProductCategories() async {
    var result = await client.get(endpoint: "/products/categories");
    return result.body;
  }
  findProductByCategory(String category) async {
    var result = await client.get(endpoint: "/products/category/$category");
    return result.body;
  }
}