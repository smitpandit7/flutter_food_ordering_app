import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/models/menu_items.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final MenuItem item;
  final int quantity;
  const AddToCart(this.item, {this.quantity = 1});
  @override List<Object?> get props => [item, quantity];
}

class RemoveFromCart extends CartEvent {
  final MenuItem item;
  const RemoveFromCart(this.item);
  @override List<Object?> get props => [item];
}

class UpdateQuantity extends CartEvent {
  final MenuItem item;
  final int quantity;
  const UpdateQuantity(this.item, this.quantity);
  @override List<Object?> get props => [item, quantity];
}

class ClearCart extends CartEvent {}
