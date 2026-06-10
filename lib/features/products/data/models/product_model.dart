   class ProductModel {
        final int id;
        final String title;
        final String description;
        final double price;
        final double rating;
        final String category;
        final String thumbnail;

        ProductModel({
        required this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.rating,
        required this.category,
        required this.thumbnail,
      });

      factory ProductModel.fromJson(
        Map<String, dynamic> json,
     ) {
      return ProductModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price:
        (json['price'] as num).toDouble(),
        rating:
        (json['rating'] as num).toDouble(),
        category: json['category'],
        thumbnail: json['thumbnail'],
    );
  }
}