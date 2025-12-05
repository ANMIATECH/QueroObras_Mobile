import 'package:flutter/material.dart';
import '../../../const/custom_image_view.dart';
import '../../../controller/service_controller.dart';
import '../home/home_screen.dart';
import '../home/servicesproviders_bycategory.dart';
import 'service_card.dart';

import 'package:get/get.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ServiceController controller = Get.find<ServiceController>();
    controller.getConstructionServiceProvider();
    controller.getAcabamentoServiceProvider();

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Serviços',
            style: TextStyle(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SearchBarWidget(),
                    SizedBox(height: 26),
                    Row(
                      children: [
                        Expanded(child: FilterChipWidget(text: 'Localização')),
                        SizedBox(width: 5),
                        Expanded(child: FilterChipWidget(text: 'Urgência')),
                        SizedBox(width: 5),
                        Expanded(
                          child: FilterChipWidget(text: 'Faixa de preço'),
                        ),
                        SizedBox(width: 5),
                        Expanded(child: FilterChipWidget(text: 'Tipo de')),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Serviços Populares',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Josefin Sans',
                  ),
                ),
              ),
            ),
            // Construction CATEGORIES FROM API
            Obx(
              () => SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final category = controller.categories[index];

                    return InkWell(
                      onTap: () {
                        final slug = category['slug'];

                        Get.to(() => ServicesProvidersByCategory(slug: slug));
                      },
                      borderRadius: BorderRadius.circular(6),
                      child: ServiceCard(
                        imageUrl: category['avatar'],
                        title:  category["name"] ?? "Serviço",
                      ),
                    );
                  }, childCount: controller.categories.length),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Serviços de Reforma e Construção',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Josefin Sans',
                  ),
                ),
              ),
            ),

            Obx(
              () => SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final category = controller.cCategories[index];

                    return InkWell(
                      onTap: () {
                        final slug = category['slug'];
                        Get.to(() => ServicesProvidersByCategory(slug: slug));
                      },
                      borderRadius: BorderRadius.circular(6),
                      child: Column(
                        children: [
                          ServiceCard(
                            imageUrl: category['avatar'],
                            title: category["name"] ?? "Serviço",
                          ),
                        ],
                      ),
                    );
                  }, childCount: controller.cCategories.length),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Serviços de Acabamento',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Josefin Sans',
                      ),
                    ),

                    const SizedBox(height: 20),

                    Obx(() {
                      final list = controller.aCategories;

                      if (list.length < 2) return const SizedBox();

                      final firstCategory = list[0];
                      final secondCategory = list[1];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ITEM 1
                          InkWell(
                            onTap: () {
                              Get.to(
                                    () => ServicesProvidersByCategory(slug: firstCategory['slug']),
                              );
                            },
                            child: ServiceCard(
                              imageUrl: firstCategory['avatar'],
                              title: firstCategory['name'] ?? "Serviço",
                            ),
                          ),

                          const SizedBox(width: 12),

                          // ITEM 2
                          InkWell(
                            onTap: () {
                              Get.to(
                                    () => ServicesProvidersByCategory(slug: secondCategory['slug']),
                              );
                            },
                            child: ServiceCard(
                              imageUrl: secondCategory['avatar'],
                              title: secondCategory['name'] ?? "Serviço",
                            ),
                          ),

                          const SizedBox(width: 12),

                          // ORANGE BOX
                          Expanded(
                            child: Container(
                              height: 78.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0xFFF9761E),
                              ),
                              child: const Center(
                                child: Text(
                                  'Precisa de ajuda agora?\nSolicitar Agora',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Josefin Sans',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),

                    const SizedBox(height: 40),
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

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final TextAlign? textAlign;
  final bool multiLine;

  const ServiceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.width = 89,
    this.height,
    this.padding,
    this.textAlign = TextAlign.center,
    this.multiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    final aspectRatio = height != null ? (width! / height!) : 1.156;

    return SizedBox(
      width: width,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CustomImageView(
                    imagePath: imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  padding: padding ?? const EdgeInsets.only(top: 0, left: 4, right: 4, bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        textAlign: textAlign,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Josefin Sans',
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
    );
  }
}
