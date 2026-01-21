import '../../../const/export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(22, 87, 127, 0.1), // rgba(22, 87, 127, 0.1)
              Color(0xFFFFFFFF), // #FFFFFF
            ],
            stops: [0.0, 1.0387], // 103.87% converted to 1.0387
          ),
        ),
        child: Column(
          children: [
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 53,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CustomImageView(
                          imagePath: CustomImage.newLogo,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Search Bar Section
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(217),
                                color: const Color(0xFFEEEEEE),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 19,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search_outlined,
                                    color: Color(0xFF7F7F7F),
                                  ),
                                  const SizedBox(width: 19),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        String? token = StorageDesign.readItem(
                                          StorageDesign.token,
                                        );

                                        if (token == null || token.isEmpty) {
                                          // User NOT logged in → go to Login
                                          Get.toNamed(AppRoutes.login);
                                        } else {
                                          Get.toNamed(AppRoutes.materiaisServiceProvider);
                                        }
                                        },
                                      child: TextField(
                                        enabled: false,
                                        decoration: const InputDecoration(
                                          hintText:
                                              'O que você está procurando?',
                                          hintStyle: TextStyle(
                                            color: Color(0xFF7F7F7F),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Josefin Sans',
                                            height: 1.5,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Josefin Sans',
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          GestureDetector(
                            onTap: () {
                              String? token = StorageDesign.readItem(
                                StorageDesign.token,
                              );

                              if (token == null || token.isEmpty) {
                                // User NOT logged in → go to Login
                                Get.toNamed(AppRoutes.login);
                              } else {
                                Get.toNamed(AppRoutes.notificationCpnScreen);
                              }

                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFEEEEEE,
                                ), // background color
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Center(
                                child: CustomImageView(
                                  imagePath: CustomImage.notification,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),

                          GestureDetector(
                            onTap: () {
                              String? token = StorageDesign.readItem(
                                StorageDesign.token,
                              );

                              if (token == null || token.isEmpty) {
                                // User NOT logged in → go to Login
                                Get.toNamed(AppRoutes.login);
                              } else {
                                Navigator.of(
                                  context,
                                ).pushNamed(AppRoutes.checkout);                              }
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  clipBehavior: Clip
                                      .none, // Allows the badge to sit outside the icon bounds
                                  children: [
                                    const Icon(Icons.shopping_cart, size: 28),
                                    Positioned(
                                      right: -4,
                                      top: -4,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red, // Badge color
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ), // Adds contrast
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 18,
                                          minHeight: 18,
                                        ),
                                        child: FutureBuilder(
                                          future: controller.getCart(),
                                          builder: (context, asyncSnapshot) {
                                            if (asyncSnapshot.connectionState ==
                                                    ConnectionState.waiting &&
                                                controller
                                                        .cart
                                                        .value
                                                        .data
                                                        ?.items ==
                                                    null) {
                                              return SizedBox.shrink();
                                            }
                                            if (asyncSnapshot.hasError) {
                                              return Text(
                                                'Error: ${asyncSnapshot.error}',
                                              );
                                            }
                                            return Obx(() {
                                              return Text(
                                                '${controller.cart.value.data?.items?.length ?? 0}', // Replace with your variable: '${cartCount}'
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              );
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // const SizedBox(height: 25),

                      // // Recent Search Section
                      // Text(
                      //   'Busca recente',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 16,
                      //     fontFamily: 'Josefin Sans',
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),

                      // const SizedBox(height: 20),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: [
                      //       RecentSearchChip(
                      //         text: 'Eletricista',
                      //         onRemove: () {},
                      //       ),
                      //       const SizedBox(width: 8),
                      //       RecentSearchChip(
                      //         text: 'Encanador',
                      //         onRemove: () {},
                      //       ),
                      //       const SizedBox(width: 8),
                      //       RecentSearchChip(
                      //         text: 'Eletricista',
                      //         onRemove: () {},
                      //       ),
                      //       const SizedBox(width: 8),
                      //       RecentSearchChip(
                      //         text: 'Eletricista',
                      //         onRemove: () {},
                      //         showRemoveIcon: false,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Text(
                        'Categorias em destaque',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Josefin Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              String? token = StorageDesign.readItem(
                                StorageDesign.token,
                              );

                              if (token == null || token.isEmpty) {
                                // User NOT logged in → go to Login
                                Get.toNamed(AppRoutes.login);
                              } else {
                                Get.toNamed(AppRoutes.materiaisServiceProvider);
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              width: 400,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFF9761E,
                                ).withValues(alpha: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomImageView(
                                      imagePath: "assets/images/s_home.svg",
                                    ),
                                    const SizedBox(width: 10),

                                    Text(
                                      "Loja/ materiais",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Josefin Sans',
                                        fontWeight: FontWeight.bold,
                                        height: 1.7,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              // Get.toNamed(RouteNameV1.serviceScreen);
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.serviceScreen);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              width: 400,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFF9761E,
                                ).withValues(alpha: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomImageView(
                                      imagePath: "assets/images/s_service.svg",
                                    ),
                                    const SizedBox(width: 10),

                                    Text(
                                      "Serviços",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Josefin Sans',
                                        fontWeight: FontWeight.bold,
                                        height: 1.7,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF16577F),
                        ),
                        padding: const EdgeInsets.fromLTRB(19, 8, 19, 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 62,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PROMOÇÕES',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Josefin Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Há um desconto de 60% em alguns prestadores de serviço.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Josefin Sans',
                                      fontWeight: FontWeight.w400,
                                      height: 1.7,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.fromLTRB(
                                      39,
                                      9,
                                      39,
                                      18,
                                    ),
                                    child: Text(
                                      'Ver',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Josefin Sans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 38,
                              child: CustomImageView(
                                imagePath: "assets/images/service_provider.png",
                                width: 137,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Quick Access Section
                      Text(
                        'Acesso rápido',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Josefin Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 20),
                      // Quick Access Images
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: QuickAccessCard(
                              imageUrl: "assets/images/Vender.svg",
                              title: 'Vender',
                              onTap: () async {
                                String? token = StorageDesign.readItem(
                                  StorageDesign.token,
                                );

                                if (token == null || token.isEmpty) {
                                  // User NOT logged in → go to Login
                                  Get.toNamed(AppRoutes.login);
                                } else {
                                  // User IS logged in → go to Vender page
                                  Get.toNamed(AppRoutes.vender);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: QuickAccessCard(
                              imageUrl: "assets/images/Meu_pedido.svg",
                              title: 'Meu pedido',
                              onTap: () async {
                                String? token = StorageDesign.readItem(
                                  StorageDesign.token,
                                );
                                if (token == null || token.isEmpty) {
                                  Get.toNamed(AppRoutes.login);
                                } else {
                                  Get.toNamed(AppRoutes.myOrder);
                                }
                              },
                            ),
                          ),
                          // const SizedBox(width: 20),
                          // Expanded(
                          //   child: QuickAccessCard(
                          //     imageUrl: "assets/images/Favorito.svg",
                          //     title: 'Favorito',
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(217),
              color: const Color(0xFFEEEEEE),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.search_outlined, color: Color(0xFF7F7F7F)),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      String? token = StorageDesign.readItem(
                        StorageDesign.token,
                      );

                      if (token == null || token.isEmpty) {
                        // User NOT logged in → go to Login
                        Get.toNamed(AppRoutes.login);
                      } else {
                        Get.toNamed(AppRoutes.materiaisServiceProvider);
                      }
                    },

                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'O que você está procurando?',
                        hintStyle: TextStyle(
                          color: Color(0xFF7F7F7F),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Josefin Sans',
                          height: 1.5,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Josefin Sans',
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 3),
        GestureDetector(
          onTap: () {
            String? token = StorageDesign.readItem(
              StorageDesign.token,
            );

            if (token == null || token.isEmpty) {
              // User NOT logged in → go to Login
              Get.toNamed(AppRoutes.login);
            } else {
              Get.toNamed(AppRoutes.notificationCpnScreen);
            }

          },

          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE), // background color
              borderRadius: BorderRadius.circular(
                999,
              ), // optional, if you want rounded corners
            ),
            child: Center(
              child: CustomImageView(imagePath: CustomImage.notification),
            ),
          ),
        ),
      ],
    );
  }
}

class SearchBarWidgetMain extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  const SearchBarWidgetMain({
    super.key,
    required this.hintText,
    this.onChanged,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(217),
        color: const Color(0xFFEEEEEE),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.search_outlined, color: Color(0xFF7F7F7F)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              autofocus: autofocus,
              decoration: InputDecoration(
                hintText: hintText,

                hintStyle: const TextStyle(
                  color: Color(0xFF7F7F7F),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Josefin Sans',
                  height: 1.5,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Josefin Sans',
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class RecentSearchChip extends StatelessWidget {
  final String text;
  final VoidCallback onRemove;
  final bool showRemoveIcon;

  const RecentSearchChip({
    super.key,
    required this.text,
    required this.onRemove,
    this.showRemoveIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFEEEEEE),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF16577F),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Josefin Sans',
              height: 24 / 14,
            ),
          ),
          if (showRemoveIcon) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onRemove,
              child: CustomImageView(imagePath: CustomImage.cancel),
            ),
          ],
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String icon;
  final String title;
  final BorderRadius borderRadius;
  final VoidCallback? onTap; // 👈 Added onTap callback

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.borderRadius,
    this.onTap, // 👈 Optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 👈 Handle tap
      child: Container(
        height: 66,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: const Color(0xFFF4F3F3),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
        child: Row(
          children: [
            CustomImageView(
              imagePath: icon,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 19),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Josefin Sans',
                  height: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromotionBanner extends StatelessWidget {
  const PromotionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF16577F),
      ),
      padding: const EdgeInsets.fromLTRB(19, 8, 19, 0),
      child: Row(
        children: [
          Expanded(
            flex: 62,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PROMOÇÕES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Josefin Sans',
                    height: 1,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Há um desconto de 60% em alguns prestadores de serviço.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Josefin Sans',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 106,
                  height: 39,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: const Text(
                      'Ver',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Josefin Sans',
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 38,
            child: CustomImageView(
              imagePath: "assets/images/service_provider.png",
              width: 137,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class QuickAccessCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTap;

  const QuickAccessCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 119.9124755859375,
        height: 103.28227233886719,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F3F3),
          borderRadius: BorderRadius.circular(8.75),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image on top
            Expanded(
              child: CustomImageView(imagePath: imageUrl, fit: BoxFit.contain),
            ),
            const SizedBox(height: 5),
            // Title below image
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Josefin Sans',
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
