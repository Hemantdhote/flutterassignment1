import 'dart:convert';
import 'package:assignment1/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
   Future<List<Product>> fetchProducts() async {
    String url = 'https://dummyjson.com/products?limit=20';

    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      var productList = data['products'];

      List<Product> products = [];

      for (var item in productList) {
        Product product = Product.fromJson(item);
        products.add(product);
      } 
      return products;
    }else{
      throw Exception("someting went wrong");
    }

   }
}