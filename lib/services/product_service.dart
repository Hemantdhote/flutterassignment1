import 'package:http/http.dart' as http;

class ProductService {
  Future<String> fetchProducts() async {
    String url = 'https://dummyjson.com/products?limit=20';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("someting went wrong");
    }
  }
}
