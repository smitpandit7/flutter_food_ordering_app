import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String restaurantId;
  final String name;
  final String description;
  final bool isVeg;
  final double price;
  final String imagePath;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.isVeg,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  @override
  List<Object?> get props =>
      [id, restaurantId, name, description, price, imagePath];
}
