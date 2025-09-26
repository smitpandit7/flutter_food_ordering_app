import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/blocs/restuarant/restaurant_event.dart';
import 'package:food_ordering_app/blocs/restuarant/restaurant_bloc.dart';
import 'package:food_ordering_app/blocs/cart/cart_bloc.dart';
import 'package:food_ordering_app/ui/screens/home_screen.dart';

void main() {
  testWidgets('App loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => RestaurantBloc()..add(LoadRestaurants())),
          BlocProvider(create: (_) => CartBloc()),
        ],
        child: MaterialApp(home: QuickBiteView()),
      ),
    );

    // Wait for any async operations in bloc
    await tester.pumpAndSettle();

    // ✅ Check that the main screen widget exists
    expect(find.byType(QuickBiteView), findsOneWidget);

    // ✅ Optionally, check for a widget that is always in your app
    expect(find.byType(AppBar), findsOneWidget);
  });
}
