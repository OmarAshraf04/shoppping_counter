class Products {
  int id;
  String title;
  int price;
  String thumbnail;
  int stock;


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
