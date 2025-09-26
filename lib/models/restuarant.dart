import 'package:food_ordering_app/models/menu_items.dart';

class Restaurant {
  final String name;
  final bool isVeg;
  final double rating;
  final String imagePath;
  final List<MenuItem> menuItem;

  Restaurant({
    required this.name,
    required this.isVeg,
    required this.rating,
    required this.menuItem,
    required this.imagePath,
  });
}
