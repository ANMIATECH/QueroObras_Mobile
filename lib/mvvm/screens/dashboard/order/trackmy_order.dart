import 'package:queroobras_mobile/mvvm/model/pay_order.dart';

import '../../../const/export.dart';

// --- Main Class ---
class SellerProgressTracking extends StatelessWidget {
  SellerProgressTracking({super.key, this.dd, this.userType = false}) {
    final controller = Get.find<ProductDetailsController>();
    controller.initializeWithItemTracking(
      userType ? dd?.status : dd?.orderItem?.status,
    );
  }
  final DataItemPayOrder? dd;
  final bool userType;

  // Helper to calculate padding based on screen width
  EdgeInsets _getResponsiveContainerPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Calculate padding as a proportion of the screen width.
    // e.g., 20% of the screen width for left/right padding
    final horizontalPadding = width * 0.1;
    // Top/bottom padding can be fixed or a smaller proportion
    const verticalPadding = 30.0;

    // Ensure padding doesn't get too small or too large on extreme screens
    final effectiveHorizontalPadding = horizontalPadding.clamp(20.0, 100.0);

    return EdgeInsets.only(
      top: verticalPadding,
      left: effectiveHorizontalPadding,
      right: effectiveHorizontalPadding,
      bottom: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();

    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Meu ${dd?.item?.name ?? 'Produto'}",
            style: TextStyle(
              color: Colors.black,
              // Scale font size based on screen width for a better responsive title
              fontSize: screenWidth * 0.07,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
              height: 1,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          // Keep main padding, but use a proportion or slightly smaller fixed value
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center the main items
              children: [
                // Use proportional spacing
                SizedBox(height: screenWidth * 0.08),
      
                // --- Main Content Container ---
                Container(
                  width: double.infinity,
                  // Adjust horizontal margin proportionally
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    color: const Color(0xFFF5F5F5),
                  ),
                  // **Responsiveness change**: Removed AspectRatio.
                  // We let the content determine the height, or use a flexible approach.
                  // If AspectRatio is essential, keep it, but it locks the width/height relation.
                  // For better flexibility, I'll remove it and rely on content/Expanded.
                  child: Padding(
                    // Use responsive padding helper
                    padding: _getResponsiveContainerPadding(context),
                    child: Column(
                      children: [
                        // Removed SizedBox with fixed width (170)
                        Column(
                          children: [
                            SizedBox(
                              height: screenWidth * 0.4,
                              child: CustomImageView(
                                imagePath: dd?.item?.files?.first.path ?? '',
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      dd?.item?.name ?? 'Item Name',
                                      style: const TextStyle(
                                        fontSize: 20, // Consider scaling this too
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Josefin Sans',
                                        height: 37 / 20,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      dd?.item?.description ?? 'Description',
                                      style: const TextStyle(
                                        fontSize: 16, // Consider scaling this too
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Josefin Sans',
                                        color: Colors.black,
      
                                        height: 37 / 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ), // Added space for clarity
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$${dd?.order?.totalPrice ?? '0.00'}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Josefin Sans',
                                        height: 1.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${dd?.order?.totalQuantity ?? '0'} Quantity',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Josefin Sans',
                                        height: 1.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
      
                SizedBox(height: screenWidth * 0.1), 
                Obx(() {
                  return ProgressTracker(
                    currentStatus: controller.selectedLevelUpdateProduct.value,
                    dd: dd,
                    vendor: userType,
                  );
                }),
      
                SizedBox(height: screenWidth * 0.08), 
                userType
                    ? Obx(() {
                        return CustomButton(
                          text: CustomText.updateStatus,
                          isLoading: controller.loadStatusBtn.value,
                          onPressed: () async {
                            // Button logic
                            controller.updateOrderStatus(itemSlug: "${dd?.slug}");
                          },
                        );
                      })
                    : Container(),
      
                SizedBox(height: screenWidth * 0.1), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressTracker extends StatelessWidget {
  final String currentStatus;
  final bool? vendor;
  final DataItemPayOrder? dd;

  const ProgressTracker({
    super.key,
    required this.currentStatus,
    this.vendor = false,
    this.dd,
  });

  // Map English keys to Portuguese display names
  static const Map<String, String> statusMap = {
    'packaging': 'Em Embalagem',
    'in_road': 'Em Trânsito',
    'in_checking': 'Em Verificação',
    'in_reviewing_packaging': 'Revisando Pacote',
    'shipped': 'A Caminho de Envio',
    'deliver': 'Entregue',
  };
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();

    // Get all English keys (the internal order)
    final List<String> statusKeys = statusMap.keys.toList();

    // Find the index of the current active status
    final int activeIndex = statusKeys.indexOf(currentStatus);
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: List.generate(statusKeys.length, (index) {
          final String key = statusKeys[index];
          final String displayStatus = statusMap[key]!;
          final bool isActive = index <= activeIndex;
          final bool isLast = index == statusKeys.length - 1;
          // final bool isCurrent = index == activeIndex;

          // Define the size for the dot and checkmark circle
          // const double dotSize = 16.0;
          // const double lineLength = 40.0;
          // const double lineWidth = 2.0;
          // final Color activeColor = const Color(0xFF16577F);
          // final Color inactiveColor = Colors.grey.shade300;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left dot + line
              Column(
                children: [
                  // Dot
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? const Color(0xFF16577F)
                          : Colors.grey.shade300,
                    ),
                  ),
                  // Line connecting to next dot
                  if (!isLast)
                    Container(
                      width: 4,
                      height: 40,
                      color: isActive
                          ? const Color(0xFF16577F)
                          : Colors.grey.shade300,
                    ),
                ],
              ),
              const SizedBox(width: 12),
              // Status text
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    displayStatus,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Josefin Sans',
                      color: isActive ? Colors.black : const Color(0xFFABABAB),
                    ),
                  ),
                ),
              ),
              // Right check dot
              vendor == false
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        statusKeys[index];
                        controller.selectedLevelUpdateProduct.value = key;
                        // print(
                        //   'Status selected and updated in controller: $key',
                        // );
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? const Color(0xFF16577F)
                              : Colors.grey.shade300,
                        ),
                        child: isActive
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
            ],
          );
        }),
      ),
    );
  }
}
