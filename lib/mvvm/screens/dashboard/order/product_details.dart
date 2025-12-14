import 'package:queroobras_mobile/mvvm/const/export.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.dd});
  final Item dd;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          controller.quantity.value = 1;
        },
        child: SafeArea(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              children: [
                // Header
                Container(
                  height: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 33),
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // Main content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: PageView(
                            children: List.generate(
                              dd.files?.length ?? [].length,
                              (index) {
                                var dds = dd.files?[index];
                                return Container(
                                  height: 406,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: CustomImageView(
                                      imagePath: "${dds?.path}",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Product Image
                        const SizedBox(height: 20),

                        // Product Info and Quantity
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${dd.name}',
                                    style: TextStyle(
                                      fontFamily: 'Josefin Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      height: 1.5,
                                    ),
                                  ),
                                  Text(
                                    '${dd.type}',
                                    style: TextStyle(
                                      fontFamily: 'Josefin Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0x4D000000),
                                      height: 1.71,
                                    ),
                                  ),
                                  SizedBox(height: 11),
                                  Text(
                                    '\$${dd.price}',
                                    style: TextStyle(
                                      fontFamily: 'Josefin Sans',
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFF9761E),
                                      height: 0.67,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Stock and Quantity
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 126,
                                  height: 48,
                                  child: Text(
                                    'Available in stock : ${dd.quantity} quantity',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'Josefin Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      height: 1.71,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                // Reactive Quantity Control
                                Obx(
                                  () => QuantityControl(
                                    quantity: controller.quantity.value,
                                    onIncrement: () =>
                                        controller.incrementQuantity(
                                          num.parse("${dd.quantity}"),
                                        ),
                                    onDecrement: controller.decrementQuantity,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Description
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '${dd.description}',
                              style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFA2A2A2),
                                height: 1.71,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Similar Products
                        // const Text(
                        //   'Similar product',
                        //   style: TextStyle(
                        //     fontFamily: 'Josefin Sans',
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w700,
                        //     color: Colors.black,
                        //     height: 1.2,
                        //   ),
                        // ),
                        // const SizedBox(height: 10),

                        // SizedBox(
                        //   height: 80,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: 4, // count of 4
                        //     itemBuilder: (context, index) {
                        //       return Row(
                        //         children: [
                        //           ProductCard(
                        //             imageUrl: 'assets/images/scie_a.png',
                        //             title: 'Título $index',
                        //             subtitle: 'Legenda',
                        //             price: '\$20',
                        //           ),
                        //           const SizedBox(width: 11),
                        //         ],
                        //       );
                        //     },
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Row(
                            children: [
                              // Chat Button
                              Container(
                                width: 45,
                                height: 49,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF16577F),
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomImageView(
                                    width: 24,
                                    height: 24,
                                    imagePath: "assets/images/message.svg",
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),

                              // Add to Cart Button
                              Expanded(
                                child: Obx(
                                  () => CustomButton(
                                    text: CustomText.enter,
                                    isLoading: controller.isLoading.value,
                                    onPressed: () async {
                                      controller.addToCart(
                                        itemSlug: "${dd.slug}",
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Action Buttons
    );
  }
}

class QuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityControl({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Decrement Button
        GestureDetector(
          onTap: onDecrement,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Center(
              child: Icon(Icons.remove, size: 16, color: Color(0xFF16577F)),
            ),
          ),
        ),

        const SizedBox(width: 14),

        // Quantity Display
        Text(
          quantity.toString(),
          style: const TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            height: 1.2,
          ),
        ),

        const SizedBox(width: 14),

        // Increment Button
        GestureDetector(
          onTap: onIncrement,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Center(
              child: Icon(Icons.add, size: 16, color: Color(0xFF16577F)),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 215,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 96,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Transform.rotate(
                angle: -1.047, // -60 degrees in radians
                child: CustomImageView(
                  imagePath: imageUrl,
                  width: 96,
                  height: 48,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Product Info
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFBFAFA),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(9, 5, 0, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Subtitle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0x4D000000),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Price and Cart
                  Row(
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(width: 20),

                      const Text(
                        'Carrinho',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF9761E),
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
    );
  }
}
