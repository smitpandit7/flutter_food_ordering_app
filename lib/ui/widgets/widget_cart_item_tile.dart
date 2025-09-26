import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/menu_items.dart';

class CartItemTile extends StatelessWidget {
  final MenuItem item;
  final int quantity;
  final VoidCallback onRemove;
  final void Function(int) onUpdate;
  const CartItemTile({required this.item, required this.quantity, required this.onRemove, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(item.name),
        subtitle: Text('₹${item.price.toStringAsFixed(0)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () => onUpdate(quantity - 1), icon: Icon(Icons.remove)),
            Text('$quantity'),
            IconButton(onPressed: () => onUpdate(quantity + 1), icon: Icon(Icons.add)),
            IconButton(onPressed: onRemove, icon: Icon(Icons.delete_outline)),
          ],
        ),
      ),
    );
  }
}
