import 'package:flutter/material.dart';
import 'package:food_ordering_app/blocs/cart/cart_state.dart';
import 'package:food_ordering_app/ui/screens/cart_screen.dart';

class WidgetBottomCartCard extends StatefulWidget {
  final CartState? cartState;
  final String? restuarantName;

  const WidgetBottomCartCard({Key? key, this.cartState, this.restuarantName})
      : super(key: key);

  @override
  State<WidgetBottomCartCard> createState() => _WidgetBottomCartCardState();
}

class _WidgetBottomCartCardState extends State<WidgetBottomCartCard> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.orange[600],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CartPage(
                  restaurantName: widget.restuarantName.toString(),
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.cartState?.items.length} items in cart',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  Text(
                    '₹${widget.cartState?.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Text(
                        'View Cart',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white.withOpacity(0.9),
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
