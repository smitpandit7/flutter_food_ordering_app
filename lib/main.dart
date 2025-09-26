import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/blocs/restuarant/restaurant_bloc.dart';
import 'package:food_ordering_app/blocs/restuarant/restaurant_event.dart';
import 'package:food_ordering_app/blocs/cart/cart_bloc.dart';
import 'package:food_ordering_app/ui/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.notoSansTextTheme(),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RestaurantBloc()..add(LoadRestaurants()),
        ),
        BlocProvider(
          create: (_) => CartBloc(), // 👈 Global Cart Bloc
        ),
      ],
      child: MaterialApp(
        title: 'Food Order Workflow',
        theme: theme,
        home: QuickBiteView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
