import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/wishlist_service.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

    class WishlistScreen extends ConsumerWidget {
    const WishlistScreen({super.key});

  @override
   Widget build( BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist',
        ),
      ),
      body: products.when(
        data: (data) {
          final wishlistIds = WishlistService.getWishlistIds();
          final wishlistProducts =data.where(
            (product) {
              return wishlistIds.contains(product.id);
            },
          ).toList();

          if (wishlistProducts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  Icon(Icons.favorite_border, size: 80),

                  SizedBox(height: 12),

                  Text('No products in wishlist'),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: wishlistProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemBuilder:
                (context, index) {
              final product = wishlistProducts[index];

              return ProductCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductDetailScreen( product: product),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () =>
            const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) =>
            Center(
          child: Text(e.toString()),
        ),
      ),
    );
  }
}