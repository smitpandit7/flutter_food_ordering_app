import 'package:equatable/equatable.dart';
import 'package:food_ordering_app/models/menu_items.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object?> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuItem> menuItems;

  const MenuLoaded(this.menuItems);

  @override
  List<Object?> get props => [menuItems];
}

class MenuError extends MenuState {
  final String message;

  const MenuError(this.message);

  @override
  List<Object?> get props => [message];
}
