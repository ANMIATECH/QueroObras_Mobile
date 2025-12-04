import '../../../const/export.dart';

class MaterialShopScreen extends StatelessWidget {
  const MaterialShopScreen({super.key});

  // Mock data for the first section to maintain consistency with GridView.builder
  final List<Map<String, String>> recentProducts = const [
    {
      'imageUrl': "assets/images/cement.png",
      'title': 'Título 1',
      'subtitle': 'Legenda 1',
      'price': '\$20',
    },
    {
      'imageUrl': "assets/images/cement.png",
      'title': 'Título 2',
      'subtitle': 'Legenda 2',
      'price': '\$35',
    },
    {
      'imageUrl': "assets/images/cement.png",
      'title': 'Título 3',
      'subtitle': 'Legenda 3',
      'price': '\$15',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final pController = Get.find<ProductDetailsController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Material',
            style: TextStyle(
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
              const SearchBarWidgetMain(
                hintText: "O que você está procurando?",
              ),
              const SizedBox(height: 20),

              // Title (Fixed)
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Available Product',
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
                future: Future.wait([
                  pController.getAllProduct()
                ]),
                builder: (context, asyncSnapshot) {
                  return Expanded(
                    child: GridView.builder(
                      // We use a large number (e.g., 50) to ensure the grid overflows
                      // and scrolling can be tested.
                      itemCount: 50,
                      // shrinkWrap: true is removed.
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8, // Added small spacing for better look
                        mainAxisSpacing: 8, // Added small spacing for better look
                        childAspectRatio:
                            0.7, // Adjusted aspect ratio to fit the card content better
                      ),
                      itemBuilder: (context, index) => ProductCardM(
                        onTap: () {
                          // Navigate to product detail
                          Get.toNamed(AppRoutes.productDetail);
                        },
                        imageUrl: "assets/images/lawn_mower.png",
                        title: 'Product $index',
                        subtitle: 'Category',
                        price: '\$${20 + index}',
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
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
                        const Text(
                          'Carrinho',
                          style: TextStyle(
                            color: Color(0xFFF9761E),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
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