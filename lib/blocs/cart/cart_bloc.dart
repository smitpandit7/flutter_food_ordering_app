import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/blocs/cart/cart_event.dart';
import 'package:food_ordering_app/blocs/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final existingItemIndex =
        state.items.indexWhere((e) => e.item.id == event.item.id);

    if (existingItemIndex != -1) {
      final updatedItems = List<CartItem>.from(state.items);
      final updatedCartItem = updatedItems[existingItemIndex].copyWith(
        quantity: updatedItems[existingItemIndex].quantity + 1,
      );
      updatedItems[existingItemIndex] = updatedCartItem;
      emit(CartState(items: updatedItems));
    } else {
      emit(CartState(
          items: [...state.items, CartItem(item: event.item, quantity: 1)]));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems =
        state.items.where((e) => e.item.id != event.item.id).toList();
    emit(CartState(items: updatedItems));
  }

  void _onIncreaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) {
    final updatedItems = state.items.map((cartItem) {
      if (cartItem.item.id == event.item.id) {
        return cartItem.copyWith(quantity: cartItem.quantity + 1);
      }
      return cartItem;
    }).toList();

    emit(CartState(items: updatedItems));
  }

  void _onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) {
    final updatedItems = state.items
        .map((cartItem) {
          if (cartItem.item.id == event.item.id && cartItem.quantity > 1) {
            return cartItem.copyWith(quantity: cartItem.quantity - 1);
          }
          return cartItem;
        })
        .where((cartItem) => cartItem.quantity > 0)
        .toList();

    emit(CartState(items: updatedItems));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartState(items: []));
  }
}
