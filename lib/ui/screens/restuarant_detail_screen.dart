import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/blocs/cart/cart_bloc.dart';
import 'package:food_ordering_app/blocs/cart/cart_state.dart';
import 'package:food_ordering_app/blocs/menu/menu_bloc.dart';
import 'package:food_ordering_app/blocs/menu/menu_event.dart';
import 'package:food_ordering_app/blocs/menu/menu_state.dart';
import 'package:food_ordering_app/models/restuarant.dart';
import 'package:food_ordering_app/ui/screens/cart_screen.dart';
import 'package:food_ordering_app/ui/widgets/menu_card_.dart';
import 'package:food_ordering_app/ui/widgets/widget_circular_loader.dart';

import '../../blocs/cart/cart_event.dart';
import '../widgets/widget_bottom_cart_card.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate dynamic heights based on scroll
    double headerHeight = (280 - _scrollOffset).clamp(120.0, 280.0);
    double imageOpacity = (1.0 - (_scrollOffset / 200)).clamp(0.0, 1.0);
    bool isScrolled = _scrollOffset > 100;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MenuBloc()..add(LoadMenu(widget.restaurant.name)),
        ),
        BlocProvider.value(
          value: context.read<CartBloc>(), // already provided at root
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Stack(
          children: [
            // Main scrollable content
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Header section that shrinks on scroll
                SliverAppBar(
                  expandedHeight: 280,
                  pinned: true,
                  backgroundColor: Colors.white,
                  elevation: isScrolled ? 2 : 0,
                  leading: CircleAvatar(
                    backgroundColor:
                        isScrolled ? Colors.grey[100] : Colors.white,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: isScrolled ? Colors.black87 : Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: isScrolled
                                    ? Colors.grey[100]
                                    : Colors.white,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: isScrolled
                                        ? Colors.black87
                                        : Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CartPage(
                                            restaurantName:
                                                widget.restaurant.name),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              BlocBuilder<CartBloc, CartState>(
                                builder: (context, cartState) {
                                  if (cartState.items.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  return Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 16,
                                        minHeight: 16,
                                      ),
                                      child: Text(
                                        '${cartState.items.length}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Opacity(
                          opacity: imageOpacity,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: Image.asset(
                              widget.restaurant.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Gradient overlay when scrolling
                        if (isScrolled)
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: isScrolled
                        ? Text(
                            widget.restaurant.name,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                    titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  ),
                ),

                // Restaurant Info Section
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.grey[50],
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Restaurant name and description (hidden when scrolled up)
                        AnimatedOpacity(
                          opacity: isScrolled ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.restaurant.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Authentic Italian pizza made with fresh ingredients and traditional recipes passed down through generations.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),

                        // Tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildTag('Pizza', Colors.orange[100]!,
                                Colors.orange[800]!),
                            _buildTag('Italian', Colors.orange[100]!,
                                Colors.orange[800]!),
                            _buildTag('Family Friendly', Colors.orange[100]!,
                                Colors.orange[800]!),
                            _buildTag('Popular', Colors.orange[100]!,
                                Colors.orange[800]!),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Rating and delivery info
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.green[600], size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.restaurant.rating} (1247)',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 24),
                            Row(
                              children: [
                                Icon(Icons.access_time,
                                    color: Colors.grey[600], size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  '25-35 min',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Delivery fee info
                        Row(
                          children: [
                            Icon(Icons.info_outline,
                                color: Colors.grey[600], size: 18),
                            const SizedBox(width: 4),
                            Text(
                              'Delivery fee \$2.99 • Min order \$15',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Popular Items Section Header
                        const Text(
                          'Popular Items',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Menu Items List - This will expand as user scrolls
                BlocBuilder<MenuBloc, MenuState>(
                  builder: (context, state) {
                    if (state is MenuLoading) {
                      return const SliverFillRemaining(
                        child: Center(child: CustomLoadingWidget()),
                      );
                    } else if (state is MenuLoaded) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final menu = state.menuItems[index];

                            return BlocBuilder<CartBloc, CartState>(
                              builder: (context, cartState) {
                                int quantity = 0;
                                final item = cartState.items.firstWhere(
                                  (i) => i.item.id == menu.id,
                                  orElse: () =>
                                      CartItem(item: menu, quantity: 0),
                                );
                                quantity = item.quantity;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: WidgetMenuCard(
                                    menu,
                                    index == 0,
                                    quantity: quantity,
                                    onAddToCart: () {
                                      context
                                          .read<CartBloc>()
                                          .add(AddToCart(menu));
                                    },
                                    onIncrement: () {
                                      context
                                          .read<CartBloc>()
                                          .add(IncreaseQuantity(menu));
                                    },
                                    onDecrement: () {
                                      if (quantity == 1) {
                                        context
                                            .read<CartBloc>()
                                            .add(RemoveFromCart(menu));
                                      }
                                      context
                                          .read<CartBloc>()
                                          .add(DecreaseQuantity(menu));
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          childCount: state.menuItems.length,
                        ),
                      );
                    } else if (state is MenuError) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Text(state.message),
                        ),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),

            // Bottom Cart Bar
            BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                if (cartState.items.isEmpty) return const SizedBox.shrink();

                return WidgetBottomCartCard(
                  cartState: cartState,
                  restuarantName: widget.restaurant.name,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
