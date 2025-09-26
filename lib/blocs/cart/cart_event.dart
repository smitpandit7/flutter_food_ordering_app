import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/models/menu_items.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final MenuItem item;
  const AddToCart(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final MenuItem item;
  const RemoveFromCart(this.item);

  @override
  List<Object?> get props => [item];
}

class IncreaseQuantity extends CartEvent {
  final MenuItem item;
  const IncreaseQuantity(this.item);

  @override
  List<Object?> get props => [item];
}

class DecreaseQuantity extends CartEvent {
  final MenuItem item;
  const DecreaseQuantity(this.item);

  @override
  List<Object?> get props => [item];
}

class ClearCart extends CartEvent {}
