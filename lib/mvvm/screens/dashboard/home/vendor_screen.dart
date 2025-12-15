import '../../../const/export.dart';

class VenderScreen extends StatelessWidget {
  const VenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VendorFormController());

    final vController = Get.find<VendorFormController>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            // Use const for Text style
            'Vender',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
              height: 1,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.venderCreate);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9761E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: vController.fetchItems(),
          builder: (context, asyncSnapshot) {
            // The main structure for a flexible layout is a Column
            // where one child (the list) is Expanded.
            return Column(
              children: [
                const SizedBox(height: 40),

                // Add new item button
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.venderCreate);
                  },
                  child: Container(
                    // Simplified width logic for better responsiveness/consistency
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 21),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16577F),
                      borderRadius: BorderRadius.circular(217.391),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 21,
                        vertical: 18,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Color(0xFF16577F),
                              size: 16,
                            ),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Adicionar novo item',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Josefin Sans',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                // Previous article section (Expanded to use remaining space)
                // Expanded is the key to making the list scrollable and responsive.
                Obx(() {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Artigos anteriores',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Josefin Sans',
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () =>
                                  vController.fetchItems(isInitial: true),
                              child: NotificationListener<ScrollNotification>(
                                onNotification: (ScrollNotification scrollInfo) {
                                  // Check if the user is scrolling near the bottom
                                  if (scrollInfo.metrics.pixels >=
                                          scrollInfo.metrics.maxScrollExtent *
                                              0.9 && // 90% scrolled
                                      !vController.isPaginating.value &&
                                      vController.hasMoreData.value) {
                                    vController.loadNextPage();
                                  }
                                  return true; // Return true to stop the notification from bubbling up
                                },
                                child: ListView.builder(
                                  itemCount:
                                      vController.itemList.length +
                                      1, // +1 for the loading indicator
                                  // Added padding for the list content
                                  padding: const EdgeInsets.only(bottom: 20),
                                  itemBuilder: (context, index) {
                                    if (index < vController.itemList.length) {
                                      var dd = vController.itemList[index];
                                      return ItemCard(
                                        title: dd.name ?? "",
                                        subtitle: dd.description ?? "",
                                        price: '\$${dd.price ?? ""}',
                                        quantity: dd.quantity ?? "",
                                        imageUrl: "${dd.files?.first.path}",
                                        onTap: () {
                                          Get.to(
                                            () => VendorEditScreen(itemId: dd),
                                          );
                                        },
                                      );
                                    } else {
                                      // This is the last item: show the pagination loader or an empty space
                                      return Obx(
                                        () => vController.isPaginating.value
                                            ? const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(12.0),
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              )
                                            : vController.itemList.isNotEmpty &&
                                                  !vController.hasMoreData.value
                                            ? const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(12.0),
                                                  child: Text(
                                                    "You've reached the end of the list.",
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String quantity;
  final String imageUrl;
  final VoidCallback? onTap;

  const ItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(8, 12, 12, 11),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFE3E3E3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: CustomImageView(
                  imagePath: imageUrl,
                  width: 27,
                  height: 42,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Josefin Sans',
                      height: 24 / 16,
                    ),
                  ),
                  const SizedBox(height: 4), // ✅ valid small space
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.3),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Josefin Sans',
                      height: 24 / 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Josefin Sans',
                      height: 24 / 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 61,
              height: 58,
              padding: const EdgeInsets.fromLTRB(13, 5, 13, 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF9761E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  quantity,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Josefin Sans',
                    height: 24 / 13,
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
