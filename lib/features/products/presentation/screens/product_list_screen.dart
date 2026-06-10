import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/features/products/presentation/screens/product_detail_screen.dart';
import 'package:shopsphere/features/products/presentation/widgets/product_card.dart';
import 'package:shopsphere/features/products/presentation/widgets/product_shimmer.dart';
import 'wishlist_screen.dart';
import '../providers/product_pagination_provider.dart';


     class ProductListScreen extends ConsumerStatefulWidget {
      const ProductListScreen({super.key});

  @override
     ConsumerState<ProductListScreen> createState() =>
      _ProductListScreenState();
}

    class _ProductListScreenState extends ConsumerState<ProductListScreen> {

      final ScrollController _scrollController = ScrollController();
      String searchQuery = '';
      String selectedCategory = 'All';
      RangeValues selectedPriceRange =
      const RangeValues(0, 5000);


    @override
        void initState() {
        super.initState();

            _scrollController.addListener(() {
            if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {

         ref.read(productPaginationProvider.notifier).loadMore();
       }
     });
   }
    @override
      void dispose() {
      _scrollController.dispose();
      super.dispose();
    }

     void updateSearch(String value) {
      setState(() {
       searchQuery = value;
     });
   }


      void showPriceFilter() {
           showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
           context: context,
            builder: (context) {
             return StatefulBuilder(
              builder: (context, setModalState) {
                 return SafeArea(
                  top: false,
                  bottom: true,
                   child: Padding(
                    padding: const EdgeInsets.all(16),
                               child: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   const Text(
                    'Price Filter',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                                   ),
                   
                                   const SizedBox(height: 20),
                   
                                   Text(
                    '\$${selectedPriceRange.start.round()}'
                    ' - '
                    '\$${selectedPriceRange.end.round()}',
                                   ),
                   
                                   RangeSlider(
                    min: 0,
                    max: 5000,
                    values: selectedPriceRange,
                    onChanged: (value) {
                      setModalState(() {
                        selectedPriceRange = value;
                      });
                   
                      setState(() {});
                    },
                                   ),
                                 ],
                               ),
                             ),
                 );
        },
      );
    },
  );
}

  @override
  Widget build( BuildContext context) {
    final products = ref.watch(productPaginationProvider);

    return Scaffold(
          appBar: AppBar(
          centerTitle: true,
          title: const Text('ShopSphere'),
          actions: [
             IconButton(
              icon: const Icon(Icons.favorite),
               onPressed: () {
                Navigator.push(
                 context,
                MaterialPageRoute(
                builder: (_) => const WishlistScreen(),),
            );
          },
        ),
              IconButton(
               icon: const Icon(Icons.filter_alt),
                 onPressed: () {
                   showPriceFilter();
                },
             ),
           ],
         ),
      body:  products.when(
             loading: () => const ProductShimmer(),

             error: (error, stackTrace) =>
           Center(
            child: Text(error.toString()),
          ),

               data: (data) { 
                final categories = ['All', ...data.map((e) => e.category).toSet()
            ];

                  final filteredProducts = data.where(
                   (product) {
                  final matchesSearch = product.title
                   .toLowerCase()
                   .contains(
                   searchQuery.toLowerCase(),
                 );

                   final matchesCategory =
                    selectedCategory == 'All'
                    ? true
                    : product.category == selectedCategory;

                   final matchesPrice = product.price >= 
                   selectedPriceRange.start && product.price <= selectedPriceRange.end;

                return matchesSearch && matchesCategory && matchesPrice;
                },
                ).toList();

              return Column(
                     children: [
                  Padding(
                     padding: const EdgeInsets.all(12),
                     child: TextField(
                            onChanged: updateSearch,
                            decoration: InputDecoration(
                            hintText: 'Search products...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(12),
                            ),
                         ),
                      ),
                    ),

         SizedBox(
           height: 60,
           child: ListView.builder(
               scrollDirection: Axis.horizontal,
               itemCount: categories.length,
               itemBuilder: (context, index) {
            final category = categories[index];

        return Padding(
                   padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                   ),
                child: ChoiceChip(
                   label: Text(category),
                   selected: selectedCategory == category,
                   onSelected: (_) {
                 setState(() {
                      selectedCategory = category;
                 });
               },
             ),
           );
         },
       ),
     ),

      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: RefreshIndicator( onRefresh: () async {
           await ref.read(
                    productPaginationProvider.notifier,
                   ).refresh();
             await Future.delayed(
                  const Duration(seconds: 1),
                 );
               },
             child: filteredProducts.isEmpty
                ? const Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off,size: 80),
              SizedBox(height: 12),
            Text('No products found'),
             ],
           ),
         )
          :GridView.builder(
            controller: _scrollController,
            itemCount: filteredProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.65,
            ),
            itemBuilder:
                (context, index) {

              final product = filteredProducts[index];
              return ProductCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductDetailScreen(product: product),
                    ),
                  );
                },
              );
            },
          ),
          
          ),
        ),
      ),
    ],
  );
},
      
      ),
    );
  }
}