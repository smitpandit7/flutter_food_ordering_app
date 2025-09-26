import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/models/menu_items.dart';

class CartItem {
  final MenuItem item;
  final int quantity;

  const CartItem({required this.item, required this.quantity});

  CartItem copyWith({MenuItem? item, int? quantity}) {
    return CartItem(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => item.price * quantity;
}

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  double get totalAmount =>
      items.fold(0, (sum, cartItem) => sum + cartItem.totalPrice);

  @override
  List<Object?> get props => [items];
}
