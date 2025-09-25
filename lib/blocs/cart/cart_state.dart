import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/models/menu_items.dart';

class CartState extends Equatable {
  final Map<MenuItem, int> items;
  const CartState({this.items = const {}});

  double get total =>
      items.entries.fold(0.0, (s, e) => s + e.key.price * e.value);

  int get totalItems => items.values.fold(0, (s, e) => s + e);

  CartState copyWith({Map<MenuItem, int>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override List<Object?> get props => [items];
}
