import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/product_remote_datasource.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

final productProvider = FutureProvider<List<ProductModel>>(
    (ref) async {
     final repository =
        ProductRepository(
      ProductRemoteDataSource(),
    );

    return repository.getProducts(skip: 0);
  },
);