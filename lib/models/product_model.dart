class Product{
  final int id;
  final String title;
  final String image;
  final double price;
  final double rating;

  Product({
    this.id=0,
    required this.title,
    required this.image,
    required this.price,
    required this.rating
  });

  Product.fromJson(Map<String, dynamic> data): 
        id = data['id'] ?? 0,
        title = data['title'] ?? '',
        image = data['thumbnail'] ?? '',
        price = (data['price'] ?? 0).toDouble(),
        rating = (data['rating'] ?? 0).toDouble();
}