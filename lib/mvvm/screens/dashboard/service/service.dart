import 'package:flutter/material.dart';
import '../../../const/custom_image_view.dart';
import '../home/home_screen.dart';
import 'service_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          children: const [
            Text(
              'Serviços',
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: 'Josefin Sans',
              ),
            ),
          ],
        ),
      ),),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Search Bar & Filters
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

            // Popular Services
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

            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFF4F3F3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                          imagePath: 'assets/images/lighting.svg',
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Service',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,

                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                  childCount: 8,
                ),
              ),
            ),

            // Reforma e Construção Section
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => SServiceCard(
                    iconUrl: 'assets/images/house.svg',
                    text: 'Fundação e\nEstrutura',
                  ),
                  childCount: 6,
                ),
              ),
            ),

            // Serviços de Acabamento Section
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

                    // Finishing Service Row
                    Row(
                      children: [
                        Container(
                          width: 78.82,
                          height: 78.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFFF4F3F3),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImageView(
                                imagePath: 'assets/images/house.svg',
                                width: 25,
                                height: 25,
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Pintura e Textura',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Josefin Sans',
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          width: 78.82,
                          height: 78.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFFF4F3F3),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImageView(
                                imagePath: 'assets/images/house.svg',
                                width: 25,
                                height: 25,
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Instalação de Pocia',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Josefin Sans',
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          width: 161,
                          height: 78.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFFF9761E),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Precisa de ajuda agora?\n Solicitar Agora',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Josefin Sans',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Additional Services
                    const Text(
                      'Serviços de Reforma e Construção',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Josefin Sans',
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: SServiceCard(
                            imageUrl: "assets/images/lighting.svg",
                            text: 'Eletricista',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: SServiceCard(
                            imageUrl:
                            'assets/images/tapwater.svg',
                            text: 'Encanador',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: SServiceCard(
                            imageUrl:
                            'assets/images/construction.svg',
                            text: 'Pedreiro',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: SServiceCard(
                            imageUrl:
                                'assets/images/paintbrush.svg',
                            text: 'Pintor',
                          ),
                        ),
                      ],
                    ),
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
