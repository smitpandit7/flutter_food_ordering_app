import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/data/dummy_restuarants.dart';
import 'menu_event.dart';
import 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<LoadMenu>((event, emit) async {
      emit(MenuLoading());
      await Future.delayed(const Duration(seconds: 1)); // simulate API call
      try {
        // find restaurant by id
        final restaurant = dummyRestaurants.firstWhere(
          (r) => r.name == event.restaurantId, // using name as id for dummy
          orElse: () => throw Exception("Restaurant not found"),
        );
        emit(MenuLoaded(restaurant.menuItem));
      } catch (e) {
        emit(const MenuError("Failed to load menu"));
      }
    });
  }
}
