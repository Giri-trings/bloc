class ProductsDataModel {
  final int id;
  final String name;
  final String price;
  final dynamic category;
  final String imageUrl;

  ProductsDataModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}
