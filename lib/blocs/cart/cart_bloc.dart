import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/models/menu_items.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_onAdd);
    on<RemoveFromCart>(_onRemove);
    on<UpdateQuantity>(_onUpdate);
    on<ClearCart>((e, emit) => emit(CartState(items: {})));
  }

  void _onAdd(AddToCart event, Emitter<CartState> emit) {
    final newMap = Map<MenuItem, int>.from(state.items);
    final current = newMap[event.item] ?? 0;
    newMap[event.item] = current + event.quantity;
    emit(state.copyWith(items: newMap));
  }

  void _onRemove(RemoveFromCart event, Emitter<CartState> emit) {
    final newMap = Map<MenuItem, int>.from(state.items);
    newMap.remove(event.item);
    emit(state.copyWith(items: newMap));
  }

  void _onUpdate(UpdateQuantity event, Emitter<CartState> emit) {
    final newMap = Map<MenuItem, int>.from(state.items);
    if (event.quantity <= 0) newMap.remove(event.item);
    else newMap[event.item] = event.quantity;
    emit(state.copyWith(items: newMap));
  }
}
