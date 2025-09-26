import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/blocs/cart/cart_bloc.dart';
import 'package:food_ordering_app/ui/screens/cart_screen.dart';

void main() {
  testWidgets('Cart screen shows empty message', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => CartBloc(),
          child: const CartScreen(
            restaurantName: "NA",
          ),
        ),
      ),
    );

    expect(find.text('Your cart is empty'), findsOneWidget);
  });
}
