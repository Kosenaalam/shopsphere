import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../../../core/utils/wishlist_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({
         super.key,
         required this.product,
       });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
            title: Text(product.title),
           ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: product.thumbnail,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style:
                        const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12,),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber,),

                      const SizedBox(width: 4),
                      Text(product.rating.toString()),
                    ],
                  ),

                  const SizedBox( height: 12),

                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12 ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration:
                        BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(product.category),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Description',
                    style:TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),

                 SafeArea(
                   child: SizedBox(
                    width: double.infinity,
                    height: 55,
                                 child: ElevatedButton.icon(
                                  onPressed: () {
                                   WishlistService.toggleWishlist(product.id);
                   
                                 (context as Element).markNeedsBuild();
                             },
                                icon: Icon(
                                WishlistService.isWishlisted(
                                product.id,
                              )
                               ? Icons.favorite
                               : Icons.favorite_border,
                            ),
                              label: Text(
                              WishlistService.isWishlisted(product.id)
                             ? 'Remove From Wishlist'
                             : 'Add To Wishlist',
                           ),
                         ),
                       ),
                 ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}