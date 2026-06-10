import 'package:hive/hive.dart';

class WishlistService {
  static final Box box = Hive.box('wishlist');

  static bool isWishlisted(int productId, ) {
    return box.containsKey( productId,);
  }

  static void toggleWishlist( int productId,) {


    if (isWishlisted(productId)) {
      box.delete(productId);
      
    } else {
      box.put(productId, true);
    }
  }

  static List<int> getWishlistIds() {
    return box.keys.cast<int>().toList();
  }
}