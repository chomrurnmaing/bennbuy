class ProductCategory {
  final int id;
  final String name;
  final String slug;
  final int parent;
  final String description;
  final String display;
  final Map image;
  final int menuOrder;
  final int count;

  ProductCategory({
    this.id,
    this.name,
    this.slug,
    this.parent,
    this.description,
    this.display,
    this.image,
    this.menuOrder,
    this.count
  });

  factory ProductCategory.fromJson(Map<String, dynamic> data) {
    return ProductCategory(
      id: data['id'],
      name: data['name'],
      slug: data['slug'],
      parent: data['parent'],
      description: data['description'],
      display: data['display'],
      image: data['image'],
      menuOrder: data['menu_order'],
      count: data['count'],
    );
  }
}