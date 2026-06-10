import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/product_remote_datasource.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

final productPaginationProvider = AsyncNotifierProvider< ProductPaginationNotifier, List<ProductModel>>(
    ProductPaginationNotifier.new,
 );

     class ProductPaginationNotifier extends AsyncNotifier<
        List<ProductModel>> {

        int skip = 0;
        bool hasMore = true;

  @override
  Future<List<ProductModel>> build() async {
    return loadInitialProducts();
  }

  Future<List<ProductModel>>
      loadInitialProducts() async {
      skip = 0;

    final repository = ProductRepository(
      ProductRemoteDataSource(),
    );

        final products =
           await repository.getProducts(
           skip: skip,
        );
           skip += 20;

           return products;
        }

      Future<void> loadMore() async {
      if (!hasMore) return;

       final current = state.value ?? [];

            final repository =
            ProductRepository(
             ProductRemoteDataSource(),
         );

              final newProducts =
               await repository.getProducts(
               skip: skip,
             );

            if (newProducts.isEmpty) {
             hasMore = false;
             return;
           }
            skip += 20;

          state = AsyncData([
                ...current,
                ...newProducts,
             ]);
           }

     Future<void> refresh() async {
      state = const AsyncLoading();
      state = AsyncData(
      await loadInitialProducts(),
    );
  }
}