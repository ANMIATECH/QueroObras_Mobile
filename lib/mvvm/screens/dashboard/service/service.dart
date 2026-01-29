import 'package:flutter/material.dart';
import '../../../const/custom_image_view.dart';
import '../../../const/export.dart';
import '../../../controller/service_controller.dart';
import '../home/home_screen.dart';
import '../home/servicesproviders_bycategory.dart';
import '../webview.dart';
import 'service_card.dart';

import 'package:get/get.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ServiceController controller = Get.find<ServiceController>();
    controller.getConstructionServiceProvider();
    controller.getConstructionServiceProvider();
    controller.getPopularServiceProvider();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          backgroundColor: const Color(0xFF16577F),
          automaticallyImplyLeading: false, // Remove default back button
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                         Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Serviços',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SearchBarWidget(), // Your search bar here
                ],
              ),
            ),
          ),
        ),
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
                    SizedBox(height: 10),
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
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final category = controller.categories[index];
                    return ServiceCard(
                      isLarge: true,
                      imageUrl: category['avatar'],
                      title:  category["name"] ?? "Serviço",
                      onTap: () {
                        final slug = category['slug'];
                        Get.to(() => ServicesProvidersByCategory(slug: slug));
                      },

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
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final category = controller.cCategories[index];

                    return ServiceCard(
                      imageUrl: category['avatar'],
                      title: category["name"] ?? "Serviço",
                      onTap: () {
                        final slug = category['slug'];
                        Get.to(() => ServicesProvidersByCategory(slug: slug));
                      },

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


                  ],
                ),
              ),
            ),
            Obx(
                  () => SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final category = controller.aCategories[index];
                    return ServiceCard(
                      imageUrl: category['avatar'],
                      title: category["name"] ?? "Serviço",
                      onTap: () {
                        final slug = category['slug'];
                        Get.to(() => ServicesProvidersByCategory(slug: slug));
                      },
                    );
                  }, childCount: controller.aCategories.length),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    height: 77,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular( 6.483),
                      gradient: const RadialGradient(
                        center: Alignment(0.1784, 0.0052), // 58.92% 50.26% converted
                        radius: 2.35, // 470.33% scaled down
                        colors: [
                          Color(0xFFF9761E), // #F9761E
                          Color(0xFF7F320A), // #7F320A
                        ],
                        stops: [0.0, 1.0],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal:  13,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left side - Help text
                        Text(
                          'Precisa de ajuda agora?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:  12 ,
                            height: 1.25,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        // Right side - Action button
                        GestureDetector(
                          onTap: (){
                            Get.to(
                                    () => WebViewScreen(
                                  url:
                                  'https://tawk.to/chat/694ffc0b8a4fb0197ea55c11/1jdg713ib',
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal:8 ,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SizedBox(
                              width: 90 ,
                              height: 13,
                              child: Center(
                                child: Text(
                                  'Solicitar Agora',
                                  style: TextStyle(
                                    color: const Color(0xFFF9761E),
                                    fontSize: 10 ,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Josefin Sans',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTap;
  final bool isLarge;
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
    this.multiLine = false, this.onTap,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 640;

    return  GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isLarge ? 13.468 : 9.223),
        child: SizedBox(
          width: isLarge ? 185 : 126,
          height: isLarge ? 159 : (isSmallScreen ? 120 : 129),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: CustomImageView(imagePath:
                  imageUrl,
                  fit: BoxFit.cover,
                  color: Colors.black.withValues(alpha: 0.3),
                ),
              ),
              // Text overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: isLarge ? 65 : 44,
                  color: const Color(0xFF1E1E1E).withValues(alpha: 0.8),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.josefinSans(
                      fontSize: isLarge ? 20 : 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
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

