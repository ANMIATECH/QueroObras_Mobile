import 'package:queroobras_mobile/mvvm/screens/dashboard/home/trackorder.dart';

import '../../../const/export.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Prestador",
            style: const TextStyle(
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
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: controller.getAllOrders(),
            builder: (context, asyncSnapshot) {
              return Obx(() {
                if (!controller.isLoading.value &&
                    controller.productOrder.value.data?.items == null) {
                  return Center(child: Text("You haven't placed an order yet"));
                }
                return RefreshIndicator(
                  onRefresh: () => controller.getAllOrders(isInitial: true),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      // Check if the user is scrolling near the bottom
                      if (scrollInfo.metrics.pixels >=
                              scrollInfo.metrics.maxScrollExtent * 0.9 &&
                          !controller.isPaginatingOrder.value &&
                          controller.hasMoreOrder.value) {
                        // 👈 IMPORTANT: Only load more pages if NOT searching
                        controller.loadNextPageOrder();
                      }
                      return true;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // Main Content
                          Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics:
                                    const NeverScrollableScrollPhysics(), // if inside another scroll view
                                itemCount: controller
                                    .productOrder
                                    .value
                                    .data
                                    ?.items
                                    ?.length,
                                itemBuilder: (context, index) {
                                  var dd = controller
                                      .productOrder
                                      .value
                                      .data
                                      ?.items?[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: OrderItemCard(
                                      name: "${dd?.item?.name}",
                                      subtitle: "${dd?.item?.type}",
                                      onTap: () {
                                        Get.to(
                                          () => OrderTrackingScreen(dd: dd),
                                        );
                                      },
                                      status: "${dd?.orderItem?.status}",
                                      avatarUrl:
                                          "${dd?.item?.files?.first.path}",
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}

class OrderItemCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String status;
  final String avatarUrl;
  final VoidCallback? onTap;

  const OrderItemCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.status,
    required this.avatarUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Full width using double.infinity is already responsive for width
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to the top
          children: [
            // 2. Avatar - Fixed size (64x64) is acceptable for a card component
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomImageView(imagePath: avatarUrl),
            ),
            const SizedBox(width: 10),

            // 3. Content - Expanded to take remaining space
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Remove fixed height on this parent column
                mainAxisSize: MainAxisSize.min, // Use only required space
                children: [
                  // 4. Name and subtitle (Now flexible height)
                  // Use Padding instead of nested SizedBox for spacing
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4.0,
                    ), // Space between content and status
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize:
                          MainAxisSize.min, // Crucial for flexible height
                      children: [
                        // Name - Responsive to screen/text size
                        Text(
                          name,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2, // Allow name to wrap if needed
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        // Subtitle - Responsive to screen/text size
                        Text(
                          subtitle,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1, // Keep subtitle on one line
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7E7878),
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 5. Status (Now flexible height)
                  // No need for a wrapping SizedBox(width: double.infinity)
                  Text(
                    status,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF16577F),
                      height: 1.0,
                      fontFamily: 'Josefin Sans',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
