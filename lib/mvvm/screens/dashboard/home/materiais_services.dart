import '../../../const/export.dart';

class MaterialShopScreen extends StatelessWidget {
  const MaterialShopScreen({super.key});

  @override
  Widget build(BuildContext context) {

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
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                // 🔍 Search Bar
                const SearchBarWidgetMain(hintText: "O que você está procurando?"),
                const SizedBox(height: 20),

                // 🛍 Scrollable product grids
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recentes Section
                        const Text(
                          'Recentes',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) => ProductCardM(
                            imageUrl:"assets/images/cement.png",
                            title: 'Título',
                            subtitle: 'Legenda',
                            price: '\$20',
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Top rated Section
                        const Text(
                          'Top rated',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) => ProductCardM(
                            imageUrl: "assets/images/lawn_mower.png",
                            title: 'Título',
                            subtitle: 'Legenda',
                            price: '\$20',
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Redução Section
                        const Text(
                          'Redução',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) => ProductCardM(
                            imageUrl: "assets/images/wooden_hammer.png",
                            title: 'Título',
                            subtitle: 'Legenda',
                            price: '\$20',
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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

  const ProductCardM({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    this.topPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CustomImageView(
              imagePath: imageUrl,
              width: 70,
              height: 65, // 👈 reduced height slightly
              fit: BoxFit.contain,
            ),
          ),
          // Product Info
          Expanded( // 👈 ensures content fits properly within each grid tile
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 7, left: 4, right: 4, bottom: 2),
              decoration: const BoxDecoration(color: Color(0xFFFBFAFA)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 👈 balances layout
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
    );
  }
}
