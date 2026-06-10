
import '../models/product_model.dart';
import '../../../../core/network/dio_client.dart';

    class ProductRemoteDataSource {
       Future<List<ProductModel>> getProducts({
        required int skip,
        int limit = 20,
    }) async {
     final response =
      await DioClient.dio.get(
    '/products?limit=$limit&skip=$skip',
  );

          final List products =
            response.data['products'];

             return products
             .map(
             (e) => ProductModel.fromJson(e),
         ).toList();
       }
     }