import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/blocs/restuarant/restaurant_bloc.dart';
import 'package:food_ordering_app/blocs/restuarant/restaurant_state.dart';
import 'package:food_ordering_app/ui/screens/restuarant_detail_screen.dart';
import 'package:food_ordering_app/ui/widgets/restuarant_card.dart';

class QuickBiteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'QuickBite',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '123 Main St, Your City',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔎 Search bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search restaurants or dishes...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),

          // 🔹 Restaurant List from BLoC
          Expanded(
            child: BlocBuilder<RestaurantBloc, RestaurantState>(
              builder: (context, state) {
                if (state is RestaurantLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RestaurantLoaded) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.restaurants.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final restaurant = state.restaurants[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  RestaurantDetailPage(restaurant: restaurant),
                            ),
                          );
                        },
                        child: RestaurantCard(
                          isVeg: restaurant.isVeg,
                          name: restaurant.name,
                          rating: restaurant.rating,
                          deliveryTime:
                              "25-35 min", // temporary, you can extend model
                          deliveryFee: "₹30",
                          minOrder: "₹150",
                          imagePath: restaurant.imageUrl,
                        ),
                      );
                    },
                  );
                } else if (state is RestaurantError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
