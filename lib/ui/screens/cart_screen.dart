import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/blocs/cart/cart_bloc.dart';
import 'package:food_ordering_app/blocs/cart/cart_event.dart';
import 'package:food_ordering_app/blocs/cart/cart_state.dart';
import 'package:food_ordering_app/ui/screens/checkout_screen.dart';

class CartPage extends StatelessWidget {
  final String restaurantName;

  const CartPage({Key? key, required this.restaurantName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Your Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            );
          }

          return Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange[100],
                      child: Icon(Icons.restaurant, color: Colors.orange),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurantName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              SizedBox(width: 4),
                              Text(
                                '4.8 • 25-35 min',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'On time',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: state.items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final cartItem = state.items[index];
                    final menu = cartItem.item;

                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          menu.imagePath,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        menu.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        "₹${menu.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline,
                                color: Colors.grey[700]),
                            onPressed: () {
                              if (cartItem.quantity == 1) {
                                context
                                    .read<CartBloc>()
                                    .add(RemoveFromCart(menu));
                              }
                              context
                                  .read<CartBloc>()
                                  .add(DecreaseQuantity(menu));
                            },
                          ),
                          Text(
                            '${cartItem.quantity}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle,
                                color: Colors.orange),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(IncreaseQuantity(menu));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // ✅ Checkout Button
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CheckoutPage(
                                  restaurantName: restaurantName,
                                  // totalAmount: state.totalAmount,
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Proceed to Checkout • ₹${state.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
