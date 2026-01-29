import '../../../const/export.dart';

class CnpjHomeScreen extends StatelessWidget {
  const CnpjHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController());
    final controllerNoticiation = Get.find<ServiceController>();

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
                        child: CustomImageView(imagePath: CustomImage.newLogo),
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
                                      onTap: () => Get.toNamed(
                                        AppRoutes.materiaisServiceProvider,
                                      ),
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
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.notificationcpnf);
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
                                    CustomImageView(
                                      imagePath: CustomImage.notification,
                                    ),
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
                                          future: controllerNoticiation
                                              .loadNofication(isInitial: true),
                                          builder: (context, asyncSnapshot) {
                                            if (asyncSnapshot.connectionState ==
                                                    ConnectionState.waiting &&
                                                controllerNoticiation
                                                        .notificaitoncpnf
                                                        .value
                                                        .data
                                                        ?.datacpnf ==
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
                                                '${controllerNoticiation.notificaitoncpnf.value.data?.datacpnf?.length ?? 0}', // Replace with your variable: '${cartCount}'
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
                          const SizedBox(width: 3),

                          GestureDetector(
                            onTap: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.checkout);
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

                      // // Categories Grid
                      // Column(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Expanded(
                      //           child: buildCategoryCard(
                      //             "assets/images/materials.svg",
                      //             'Materiais',
                      //             BorderRadius.only(
                      //               topLeft: Radius.circular(11),
                      //             ),
                      //             onTap: () {
                      //               Get.toNamed(
                      //                 AppRoutes.materiaisServiceProvider,
                      //               );
                      //             },
                      //           ),
                      //         ),
                      //         const SizedBox(width: 10),
                      //         Expanded(
                      //           child: buildCategoryCard(
                      //             "assets/images/Ferramentas.svg",
                      //             'Ferramentas',
                      //             BorderRadius.only(
                      //               topRight: Radius.circular(11),
                      //             ),
                      //             onTap: () {
                      //               Get.toNamed(AppRoutes.ferramentasServiceProvider);
                      //             },
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     // const SizedBox(height: 10),
                      //     // Row(
                      //     //   children: [
                      //     //     Expanded(
                      //     //       child: buildCategoryCard(
                      //     //         "assets/images/Acabamento.svg",
                      //     //         'Acabamento',
                      //     //         BorderRadius.only(
                      //     //           bottomLeft: Radius.circular(11),
                      //     //         ),
                      //     //         onTap: () {
                      //     //           Get.toNamed(AppRoutes.acabamentoServiceProvider);
                      //     //         },
                      //     //       ),
                      //     //     ),
                      //     //     const SizedBox(width: 10),
                      //     //     Expanded(child: Container()),
                      //     //   ],
                      //     // ),
                      //   ],
                      // ),
                      //
                      // const SizedBox(height: 20),

                      // Promotions Section
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
                                  // Get.toNamed(RouteNameV1.login);
                                } else {
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
      floatingActionButton: CustomImageView(imagePath: CustomImage.chat),
    );
  }
}

Widget buildCategoryCard(
  String iconUrl,
  String title,
  BorderRadius borderRadius, {
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: const Color(0xFFF4F3F3),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
      child: Row(
        children: [
          CustomImageView(imagePath: iconUrl, width: 24, height: 24),
          const SizedBox(width: 19),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Josefin Sans',
                fontWeight: FontWeight.w400,
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
