class Shoe {
  final String id;
  final String name;
  final String brand;
  final List<int> size;
  final int price;
  final int stock;
  final List<String> colors;
  final String imageUrl;

  Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.size,
    required this.price,
    required this.stock,
    required this.colors,
    required this.imageUrl,
  });

  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
      id: json['_id'],
      name: json['name'],
      brand: json['brand'],
      size: List<int>.from(json['size']),
      price: json['price'],
      stock: json['stock'],
      colors: List<String>.from(json['colors']),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'brand': brand,
      'size': size,
      'price': price,
      'stock': stock,
      'colors': colors,
      'imageUrl': imageUrl,
    };
  }
}
