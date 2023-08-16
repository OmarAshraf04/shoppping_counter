class Products {
  final int id;
  final String title;
  final int price;
  final String thumbnail;
  final int stock;
  // final double rating;
  // final String description;


  Products({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.price,
    required this.stock,
    // required this.rating,
    // required this.description,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      price: json['price'],
      stock: json['stock'],
      // rating: json['rating'],
      // description: json['description']
    );
  }
}
