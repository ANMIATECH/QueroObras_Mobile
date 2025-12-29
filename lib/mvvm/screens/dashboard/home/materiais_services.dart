import '../../../const/export.dart';

class MaterialShopScreen extends StatelessWidget {
  const MaterialShopScreen({
    super.key,
    required this.appbarName,
    this.showAppBar = true, // 👈 default: AppBar is visible
  });
  final String appbarName;

  final bool showAppBar;
  @override
  Widget build(BuildContext context) {
    final pController = Get.find<ProductDetailsController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: showAppBar,
        title: Text(
          appbarName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            fontFamily: 'Josefin Sans',
            height: 1,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // The main column holds the fixed header elements and the expanded, scrollable grid.
          children: [
            // 🔍 Search Bar (Fixed at the top)
            SearchBarWidgetMain(
              hintText: "O que você está procurando?",
              onChanged: pController.updateSearchTerm,
              autofocus: true,
            ),
            const SizedBox(height: 20),
    
            // Title (Fixed)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Produto Disponível',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Josefin Sans',
                ),
              ),
            ),
            const SizedBox(height: 10),
    
            // 🛍 Scrollable product grid
            // Key Fix: Expanded allows the GridView to take all available space,
            // and since it is a scrollable widget itself, it will handle the scrolling.
            // We remove SingleChildScrollView and shrinkWrap: true.
            FutureBuilder(
              future: Future.wait([pController.getAllProduct()]),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting &&
                    pController.product.value.items == null) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Expanded(
                  child: Obx(() {
                    // Use the filtered list count for checks and building.
    
                    // Show initial loading screen (based on master list status)
                    if (pController.isLoading.value &&
                        pController.masterItemList.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final displayList = pController
                        .filteredItemList; // Correct list to display
                    // Show "No results" if the filtered list is empty after initial load
                    if (!pController.isLoading.value && displayList.isEmpty) {
                      return Center(
                        child: Text(
                          pController.searchTerm.isEmpty
                              ? 'No products available.'
                              : 'No products found matching "${pController.searchTerm.value}".',
                        ),
                      );
                    }
                    // Use the filtered list count for checks and building.
    
                    // ... (Loading and No Results checks are correct)
    
                    return RefreshIndicator(
                      onRefresh: () =>
                          pController.getAllProduct(isInitial: true),
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          // Check if the user is scrolling near the bottom
                          if (scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent * 0.9 &&
                              !pController.isPaginating.value &&
                              pController.hasMoreData.value &&
                              pController.searchTerm.isEmpty) {
                            // 👈 IMPORTANT: Only load more pages if NOT searching
                            pController.loadNextPage();
                          }
                          return true;
                        },
                        child: GridView.builder(
                          // 1. FIX: Use displayList.length for the item count
                          itemCount:
                              displayList
                                  .length + // <-- CHANGED from pController.itemList.length
                              (pController.hasMoreData.value &&
                                      pController.searchTerm.isEmpty
                                  ? 1
                                  : 0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.7,
                              ),
                          itemBuilder: (context, index) {
                            // 2. FIX: Check index against displayList.length
                            if (index < displayList.length) {
                              // <-- CHANGED from pController.itemList.length
                              var dd = displayList[index];
                              return ProductCardM(
                                // ... (ProductCardM content)
                                title: '${dd.name}',
                                subtitle: '${dd.type}',
                                price: '\$ ${dd.price}',
                                imageUrl: "${dd.files.first.path}",
                                onTap: () {
                                  // Navigate to product detail
                                  Get.to(() => ProductDetailsScreen(dd: dd));
                                },
                              );
                            } else {
                              // This is the last item: show the pagination loader or an empty space
                              // The Obx logic here is mostly fine, but let's clean up the unused itemList references.
                              return Obx(
                                () => pController.isPaginating.value
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : displayList
                                              .isNotEmpty && // <-- Use displayList
                                          !pController.hasMoreData.value
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text(
                                            "You've reached the end of the list.",
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCardM extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final double? topPadding;
  final VoidCallback? onTap;

  const ProductCardM({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    this.topPadding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(8),
        ),
        // 💡 FIX: Removed mainAxisSize.min.
        // The default (max) ensures the Column fills the GridView cell's constrained height,
        // allowing the inner Expanded to calculate correctly.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CustomImageView(
                imagePath: imageUrl,
                width: 70,
                height: 65,
                fit: BoxFit.contain,
              ),
            ),

            // Product Info
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 7,
                  left: 4,
                  right: 4,
                  bottom: 2,
                ),
                decoration: const BoxDecoration(color: Color(0xFFFBFAFA)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        Text(
                          subtitle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        // const Text(
                        //   'Carrinho',
                        //   style: TextStyle(
                        //     color: Color(0xFFF9761E),
                        //     fontSize: 11,
                        //     fontWeight: FontWeight.w700,
                        //     fontFamily: 'Josefin Sans',
                        //   ),
                        // ),
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
}


  // Recentes Section
                        // const Text(
                        //   'Recentes',
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w700,
                        //     fontFamily: 'Josefin Sans',
                        //   ),
                        // ),
                        // const SizedBox(height: 10),

                        // // Using GridView.builder for consistency
                        // GridView.builder(
                        //   itemCount: recentProducts.length, // Dynamic count
                        //   shrinkWrap: true,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   gridDelegate:
                        //       const SliverGridDelegateWithFixedCrossAxisCount(
                        //         crossAxisCount: 3,
                        //         crossAxisSpacing: 5,
                        //         mainAxisSpacing: 0,
                        //         childAspectRatio: 0.8,
                        //       ),
                        //   itemBuilder: (context, index) {
                        //     final product = recentProducts[index];
                        //     return ProductCardM(
                        //       onTap: () {
                        //         Get.toNamed(AppRoutes.productDetail);
                        //       },
                        //       imageUrl: product['imageUrl']!,
                        //       title: product['title']!,
                        //       subtitle: product['subtitle']!,
                        //       price: product['price']!,
                        //     );
                        //   },
                        // ),
                        // const SizedBox(height: 20),

                        // Top rated Section


                         // // Redução Section
                        // const Text(
                        //   'Redução',
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w700,
                        //     fontFamily: 'Josefin Sans',
                        //   ),
                        // ),
                        // const SizedBox(height: 10),
                        // GridView.builder(
                        //   itemCount: 3,
                        //   shrinkWrap: true,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   gridDelegate:
                        //       const SliverGridDelegateWithFixedCrossAxisCount(
                        //         crossAxisCount: 3,
                        //         crossAxisSpacing: 10,
                        //         mainAxisSpacing: 10,
                        //         childAspectRatio: 0.8,
                        //       ),
                        //   itemBuilder: (context, index) => ProductCardM(
                        //     onTap: () {
                        //       // Get.toNamed(RouteNameV1.productDetail);
                        //     },
                        //     imageUrl: "assets/images/wooden_hammer.png",
                        //     title: 'Título',
                        //     subtitle: 'Legenda',
                        //     price: '\$20',
                        //   ),
                        // ),
                        // const SizedBox(height: 40),