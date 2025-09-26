import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/blocs/cart/cart_bloc.dart';
import 'package:food_ordering_app/blocs/cart/cart_event.dart';
import 'package:food_ordering_app/models/menu_items.dart';

void main() {
  group('CartBloc', () {
    late CartBloc cartBloc;
    final testItem = MenuItem(
      restaurantId: "1",
      id: "1",
      description: "na",
      name: 'Burger',
      price: 120,
      imagePath: 'assets/images/burger.png',
      isVeg: true,
    );

    setUp(() {
      cartBloc = CartBloc();
    });

    tearDown(() {
      cartBloc.close();
    });

    test('Initial state has empty cart', () {
      expect(cartBloc.state.items.isEmpty, true);
      expect(cartBloc.state.totalAmount, 0);
    });

    test('Adding item updates cart and total', () {
      cartBloc.add(AddToCart(testItem));

      expectLater(
        cartBloc.stream,
        emits(predicate((state) =>
            cartBloc.state.items.length == 1 &&
            cartBloc.state.totalAmount == 120)),
      );
    });

    test('Removing item makes cart empty', () {
      cartBloc.add(AddToCart(testItem));
      cartBloc.add(RemoveFromCart(testItem));

      expectLater(
        cartBloc.stream,
        emitsThrough(predicate((state) =>
            cartBloc.state.items.isEmpty && cartBloc.state.totalAmount == 0)),
      );
    });
  });
}
