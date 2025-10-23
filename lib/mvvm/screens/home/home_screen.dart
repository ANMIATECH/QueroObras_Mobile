import '../../const/export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        // Logo
                        Container(
                          width: 53,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: CustomImageView(
                            imagePath: CustomImage.welcomeLogo,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Search Bar
                        const SearchBarWidget(),
                        const SizedBox(height: 25),
                        // Recent Search Section
                        const Text(
                          'Busca recente',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Josefin Sans',
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Recent Search Chips
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              RecentSearchChip(
                                text: 'Eletricista',
                                onRemove: () {},
                              ),
                              const SizedBox(width: 8),
                              RecentSearchChip(
                                text: 'Encanador',
                                onRemove: () {},
                              ),
                              const SizedBox(width: 8),
                              RecentSearchChip(
                                text: 'Eletricista',
                                onRemove: () {},
                              ),
                              const SizedBox(width: 8),
                              RecentSearchChip(
                                text: 'Eletricista',
                                onRemove: () {},
                                showRemoveIcon: false,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Featured Categories Section
                        const Text(
                          'Categorias em destaque',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Josefin Sans',
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Categories Grid
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CategoryCard(
                                    icon: "assets/images/materials.svg",
                                    title: 'Materiais',
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(11),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CategoryCard(
                                    icon: "assets/images/Ferramentas.svg",
                                    title: 'Ferramentas',
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(11),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CategoryCard(
                                    icon: "assets/images/Serviços.svg",
                                    title: 'Serviços',
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(11),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CategoryCard(
                                    icon: "assets/images/Acabamento.svg",
                                    title: 'Acabamento',
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(11),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Promotion Banner
                        const PromotionBanner(),
                        const SizedBox(height: 20),
                        // Quick Access Section
                        const Text(
                          'Acesso rápido',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Josefin Sans',
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Quick Access Cards
                        Row(
                          children: [
                            Expanded(
                              child: QuickAccessCard(
                                imageUrl: "assets/images/Vender.svg",
                                title: 'Vender',
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: QuickAccessCard(
                                imageUrl: "assets/images/Meu_pedido.svg",
                                title: 'Meu pedido',
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: QuickAccessCard(
                                imageUrl: "assets/images/Favorito.svg",
                                title: 'Favorito',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 13),
                      ],
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

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(217),
              color: const Color(0xFFEEEEEE),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
            child: Row(
              children: [
                Icon(Icons.search_outlined),
                const SizedBox(width: 19),
                const Expanded(
                  child: Text(
                    'O que você está procurando?',
                    style: TextStyle(
                      color: Color(0xFF7E7878),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Josefin Sans',
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 3),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE), // background color
            borderRadius: BorderRadius.circular(
              999,
            ), // optional, if you want rounded corners
          ),
          child:  Center(
            child:  CustomImageView(imagePath: CustomImage.notification,),
          ),
        ),
      ],
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
              child: CustomImageView(imagePath: CustomImage.cancel,),
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

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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

  const QuickAccessCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
