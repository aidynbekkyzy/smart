import 'item_model.dart';

/// Тапсырмалармен жұмыс істейтін сервис (CRUD, іздеу, таңдаулылар).
class ItemService {
  final List<Item> _items = [
    Item(
      id: '1',
      title: 'Дизайн презентациясын дайындау',
      description: 'Figma макеттерін жинап, клиентке арналған презентация жасау.',
      category: 'Жұмыс',
      date: DateTime(2026, 11, 2),
      isFavorite: true,
    ),
    Item(
      id: '2',
      title: 'Flutter практикалық жұмысын тапсыру',
      description: 'Қосымшаның навигациясы мен формаларын аяқтап, оқытушыға көрсету.',
      category: 'Оқу',
      date: DateTime(2026, 10, 28),
    ),
    Item(
      id: '3',
      title: 'Дәрігерге жазылу',
      description: 'Жылдық тексеруден өту үшін алдын ала жазылып қою.',
      category: 'Денсаулық',
      date: DateTime(2026, 11, 5),
    ),
    Item(
      id: '4',
      title: 'Достармен кездесу',
      description: 'Демалыс күні кафеде жиналу, орын брондау.',
      category: 'Жеке',
      date: DateTime(2026, 10, 31),
      isFavorite: true,
    ),
    Item(
      id: '5',
      title: 'Апталық есеп жазу',
      description: 'Командаға арналған апталық прогресс есебін жіберу.',
      category: 'Жұмыс',
      date: DateTime(2026, 10, 30),
    ),
    Item(
      id: '6',
      title: 'Ағылшын тілі сабағы',
      description: 'Speaking практикасы және жаңа сөздерді қайталау.',
      category: 'Оқу',
      date: DateTime(2026, 11, 1),
    ),
  ];

  List<Item> get items => List.unmodifiable(_items);

  List<Item> get favorites => _items.where((e) => e.isFavorite).toList();

  Item? byId(String id) {
    for (final i in _items) {
      if (i.id == id) return i;
    }
    return null;
  }

  String newId() => DateTime.now().microsecondsSinceEpoch.toString();

  void add(Item item) => _items.insert(0, item);

  void update(Item item) {
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index != -1) _items[index] = item;
  }

  void remove(String id) => _items.removeWhere((e) => e.id == id);

  void toggleFavorite(String id) {
    final item = byId(id);
    if (item != null) update(item.copyWith(isFavorite: !item.isFavorite));
  }

  List<Item> search(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return [];
    return _items
        .where((e) =>
            e.title.toLowerCase().contains(q) ||
            e.description.toLowerCase().contains(q) ||
            e.category.toLowerCase().contains(q))
        .toList();
  }
}
