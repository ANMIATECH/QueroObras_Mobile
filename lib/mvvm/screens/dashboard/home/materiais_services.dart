import '../../../const/export.dart';

class MaterialShopScreen extends StatelessWidget {
  const MaterialShopScreen({
    super.key,
    required this.appbarName,
    this.showAppBar = true,
  });

  final String appbarName;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    final pController = Get.find<ProductDetailsController>();

    // 🔥 Prevent multiple API calls
    if (pController.masterItemList.isEmpty) {
      pController.getAllProduct();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: AppBar(
            backgroundColor: const Color(0xFF16577F),
            automaticallyImplyLeading: false, // Remove default back button
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
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
                        Text(
                          appbarName,
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
                    SearchBarWidgetMain(
                      hintText: 'O que você está procurando?',
                      onChanged: pController.updateSearchTerm,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Produtos Disponíveis',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Josefin Sans',
                      height: 24 / 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (pController.isLoading.value &&
                      pController.masterItemList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final displayList = pController.filteredItemList;

                  if (!pController.isLoading.value && displayList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined, // material / products icon
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            pController.searchTerm.isEmpty
                                ? 'Nenhum material disponível.'
                                : 'Nenhum material encontrado para "${pController.searchTerm.value}".',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontFamily: 'Josefin Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => pController.getAllProduct(isInitial: true),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent * 0.9 &&
                            !pController.isPaginating.value &&
                            pController.hasMoreData.value &&
                            pController.searchTerm.isEmpty) {
                          pController.loadNextPage();
                        }
                        return true;
                      },
                      child: GridView.builder(
                        itemCount:
                            displayList.length +
                            (pController.hasMoreData.value &&
                                    pController.searchTerm.isEmpty
                                ? 1
                                : 0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.7,
                            ),
                        itemBuilder: (context, index) {
                          if (index < displayList.length) {
                            final dd = displayList[index];

                            final imageUrl =
                                dd.files.isNotEmpty &&
                                    dd.files.first.path != null
                                ? dd.files.first.path!
                                : '';

                            return ProductCardNew(
                              imageUrl: imageUrl,
                              title: dd.name,
                              subtitle: dd.type,
                              price: 'R\$${dd.price}',
                              onCardTap: () {
                                Get.to(() => ProductDetailsScreen(dd: dd));
                              },
                              onAddTap: () async {
                                await pController.addToCart(
                                  itemSlug: "${dd.slug}",
                                );
                              },
                            );
                          }

                          return Obx(
                            () => pController.isPaginating.value
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCardNew extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback? onCardTap;
  final Future<void> Function()? onAddTap; // Make it async

  const ProductCardNew({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    this.onCardTap,
    this.onAddTap,
  });

  @override
  State<ProductCardNew> createState() => _ProductCardNewState();
}

class _ProductCardNewState extends State<ProductCardNew> {
  bool isLoading = false; // Track button loading

  void handleAddTap() async {
    if (widget.onAddTap == null) return;
    setState(() {
      isLoading = true; // Start spinner
    });

    await widget.onAddTap!(); // Wait for addToCart to finish

    setState(() {
      isLoading = false; // Stop spinner
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onCardTap,
      child: Container(
        width: 190,
        height: 368,
        decoration: BoxDecoration(
          color: const Color(0xFFEBEBEB),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            /// IMAGE
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: CustomImageView(
                imagePath: widget.imageUrl,
                width: 116,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),

            /// DETAILS
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBEBEB),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.00),
                      blurRadius: 49,
                      offset: const Offset(-33, 172),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.01),
                      blurRadius: 45,
                      offset: const Offset(-21, 110),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 38,
                      offset: const Offset(-12, 62),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.09),
                      blurRadius: 28,
                      offset: const Offset(-5, 28),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 15,
                      offset: const Offset(-1, 7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// TITLE + SUBTITLE
                      Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0x4D000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                      const SizedBox(height: 2),

                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                      const SizedBox(height: 4),

                      /// ADD BUTTON
                      GestureDetector(
                        onTap: isLoading ? null : handleAddTap,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Adicionar',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Josefin Sans',
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
          ],
        ),
      ),
    );
  }
}
