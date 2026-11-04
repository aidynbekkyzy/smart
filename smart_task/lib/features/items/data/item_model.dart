class Item {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime date;
  final bool isFavorite;

  const Item({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    this.isFavorite = false,
  });

  Item copyWith({
    String? title,
    String? description,
    String? category,
    DateTime? date,
    bool? isFavorite,
  }) =>
      Item(
        id: id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        date: date ?? this.date,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
