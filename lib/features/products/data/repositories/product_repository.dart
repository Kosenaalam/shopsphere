
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

   class ProductRepository {
     final ProductRemoteDataSource
      remoteDataSource;

         ProductRepository(this.remoteDataSource,);

       Future<List<ProductModel>> getProducts({
       required int skip,
       int limit = 20,
      }) {
   return remoteDataSource.getProducts(
    skip: skip,
    limit: limit,
   );
 }
}