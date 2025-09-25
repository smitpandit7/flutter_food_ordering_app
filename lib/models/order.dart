import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/models/menu_items.dart';

class Order extends Equatable {
  final String id;
  final String restaurantId;
  final Map<MenuItem, int> items;
  final double total;
  final DateTime placedAt;
  final String status;

  const Order({
    required this.id,
    required this.restaurantId,
    required this.items,
    required this.total,
    required this.placedAt,
    required this.status,
  });

  @override
  List<Object?> get props => [id, restaurantId, items, total, placedAt, status];
}
