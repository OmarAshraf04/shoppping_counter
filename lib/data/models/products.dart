class Products {
  final int id;
  final String title;
  final int price;
  final String thumbnail;
  final int stock;


  Products({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.price,
    required this.stock,

  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      price: json['price'],
      stock: json['stock'],
    );
  }
}
