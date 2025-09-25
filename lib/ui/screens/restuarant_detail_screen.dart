import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/blocs/menu/menu_bloc.dart';
import 'package:food_ordering_app/blocs/menu/menu_event.dart';
import 'package:food_ordering_app/blocs/menu/menu_state.dart';
import 'package:food_ordering_app/models/restuarant.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

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

    return BlocProvider(
      create: (_) => MenuBloc()..add(LoadMenu(widget.restaurant.name)),
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
                    backgroundColor: isScrolled ? Colors.grey[100] : Colors.white,
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
                          CircleAvatar(
                            backgroundColor: isScrolled ? Colors.grey[100] : Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.share,
                                color: isScrolled ? Colors.black87 : Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            backgroundColor: isScrolled ? Colors.grey[100] : Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: isScrolled ? Colors.black87 : Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 8),
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: isScrolled ? Colors.grey[100] : Colors.white,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: isScrolled ? Colors.black87 : Colors.black,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Positioned(
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
                                  child: const Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
                            child: Image.network(
                              widget.restaurant.imageUrl,
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
                            _buildTag('Pizza', Colors.orange[100]!, Colors.orange[800]!),
                            _buildTag('Italian', Colors.orange[100]!, Colors.orange[800]!),
                            _buildTag('Family Friendly', Colors.orange[100]!, Colors.orange[800]!),
                            _buildTag('Popular', Colors.orange[100]!, Colors.orange[800]!),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Rating and delivery info
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.green[600], size: 18),
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
                                Icon(Icons.access_time, color: Colors.grey[600], size: 18),
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
                            Icon(Icons.info_outline, color: Colors.grey[600], size: 18),
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
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is MenuLoaded) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final menu = state.menuItems[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: _buildMenuItem(menu, index == 0),
                            );
                          },
                          childCount: state.menuItems.length,
                        ),
                      );
                    } else if (state is MenuError) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Text(
                            state.message,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),

                // Bottom padding to account for cart bar
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),

            // Bottom Cart Bar
            Positioned(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '3 items in cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Tony's Pizza Palace",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          '\$67.96',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            // Navigate to cart
                          },
                          child: Row(
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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

  Widget _buildMenuItem(dynamic menu, bool isPopular) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        menu.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (isPopular)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange[600],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'POPULAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  menu.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "₹${menu.price.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              menu.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}