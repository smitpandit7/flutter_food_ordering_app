import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/data/dummy_restuarants.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<LoadRestaurants>((event, emit) async {
      emit(RestaurantLoading());
      await Future.delayed(const Duration(seconds: 2));
      try {
        emit(RestaurantLoaded(dummyRestaurants));
      } catch (e) {
        emit(const RestaurantError("Failed to load restaurants"));
      }
    });
  }
}
