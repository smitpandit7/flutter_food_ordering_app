import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/blocs/restuarant/restaurant_bloc.dart';
import 'package:food_ordering_app/blocs/restuarant/restaurant_event.dart';
import 'package:food_ordering_app/blocs/restuarant/restaurant_state.dart';

void main() {
  group('RestaurantBloc', () {
    late RestaurantBloc restaurantBloc;

    setUp(() {
      restaurantBloc = RestaurantBloc();
    });

    tearDown(() {
      restaurantBloc.close();
    });

    test('Initial state is RestaurantInitial', () {
      expect(restaurantBloc.state, isA<RestaurantInitial>());
    });

    test(
        'emits [RestaurantLoading, RestaurantLoaded] when LoadRestaurants is added',
        () async {
      restaurantBloc.add(LoadRestaurants());

      await expectLater(
        restaurantBloc.stream,
        emitsInOrder([
          isA<RestaurantLoading>(),
          isA<RestaurantLoaded>(),
        ]),
      );
    });
  });
}
