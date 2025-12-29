import 'package:queroobras_mobile/mvvm/const/export.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              CustomImageView(
                imagePath: CustomImage.welcomeLogo,
                width: 53,
                height: 35,
              ),
              const SizedBox(height: 20),
      
              // Search Bar + Menu Icon
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(217),
                        color: const Color(0xFFEEEEEE),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: Row(
                        children: const [
                          Icon(Icons.search_outlined),
                          SizedBox(width: 19),
                          Expanded(
                            child: Text(
                              'O que você está procurando?',
                              style: TextStyle(
                                color: Color(0xFF7E7878),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Josefin Sans',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
      
                  // Toggle Menu Button
                  GestureDetector(
                    onTap: controller.toggleFilters,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Center(
                        child: CustomImageView(
                          imagePath: controller.showFilters.value
                              ? CustomImage.menuInactive
                              : CustomImage.menuActive,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
      
              // Collapsible Section
              if (controller.showFilters.value) ...[
                const Text(
                  'Search & filters',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Josefin Sans',
                  ),
                ),
                const SizedBox(height: 20),
      
                // Search Input
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(217),
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Search for....',
                          style: TextStyle(
                            color: Color(0xFF7E7878),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 18),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
      
                const Text(
                  'Filters',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Josefin Sans',
                  ),
                ),
                const SizedBox(height: 15),
      
                Row(
                  children: const [
                    Expanded(child: FilterButton(text: 'Price', isLeft: true)),
                    SizedBox(width: 10),
                    Expanded(child: FilterButton(text: 'Location')),
                  ],
                ),
                const SizedBox(height: 20),
      
                // Location Input
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 17),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(217),
                  ),
                  child: const Text(
                    'Sao Paulo',
                    style: TextStyle(
                      color: Color(0xFF7E7878),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Josefin Sans',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
      
                // Search Button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9761E),
                    borderRadius: BorderRadius.circular(217),
                  ),
                  child: const Text(
                    'Search',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Josefin Sans',
                    ),
                  ),
                ),
                const SizedBox(height: 25),
              ],
      
              // Items Section
              const Text(
                'Items',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Josefin Sans',
                ),
              ),
              const SizedBox(height: 20),
      
              // GridView
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.5,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SearchProductCard(
                    imageUrl: "assets/images/cement.png",
                    title: "Título $index",
                    subtitle: "Legenda $index",
                    price: "\$${(index + 1) * 10}",
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          )),
        ),
      ),
    );
  }
}



class SearchProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;

  const SearchProductCard({
    super.key,
    required this.imageUrl,
    this.title = 'Título',
    this.subtitle = 'Legenda',
    this.price = '\$20',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFEEEEEE),
      ),
      child: Column(
        children: [
          // Image section with dynamic padding
          Container(
            padding: EdgeInsets.only(top: 18),
            child:   CustomImageView(imagePath:
            imageUrl,
              width:  74,
              fit: BoxFit.contain,
            )
          ),
          // Content section
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFFBFAFA),
            ),
            padding: const EdgeInsets.all(9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                          height: 1.5,
                        ),
                      ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Josefin Sans',
                        height: 1.71,
                      ),
                    ),
                  ],
                ),
                // Price and cart section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Josefin Sans',
                        height: 1.71,
                      ),
                    ),
                    Text(
                      'Carrinho',
                      style: const TextStyle(
                        color: Color(0xFFF9761E),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Josefin Sans',
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final bool isLeft;

  const FilterButton({
    super.key,
    required this.text,
    this.isLeft = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 21),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3F3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isLeft ? 11 : 0),
          bottomLeft: Radius.circular(isLeft ? 11 : 0),
          topRight: Radius.circular(isLeft ? 0 : 11),
          bottomRight: Radius.circular(isLeft ? 0 : 11),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Josefin Sans',
              height: 2,
            ),
          ),
          Icon(Icons.arrow_drop_down_outlined),
        ],
      ),
    );
  }
}

