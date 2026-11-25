class Product {
  const Product({required this.name, required this.price, required this.category});

  final String name;
  final int price;
  final String category;
}

final List<String> categories = [
  'Food',
  'Hygiene',
  'Home cleaning',
  'Home services',
  'Transport',
  'Others',
];
