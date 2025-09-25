import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/models/menu_items.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();
  @override List<Object?> get props => [];
}

class PlaceOrder extends CheckoutEvent {
  final String restaurantId;
  final Map<MenuItem, int> items;
  const PlaceOrder({required this.restaurantId, required this.items});
  @override List<Object?> get props => [restaurantId, items];
}
