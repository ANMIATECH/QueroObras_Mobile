import '../../../const/export.dart';

class NotificationCpnfScreen extends StatelessWidget {
  const NotificationCpnfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: controller.loadNofication(isInitial: true),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting &&
                    controller.notificaitoncpnf.value.data == null) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Container(
                  constraints: const BoxConstraints(maxWidth: 480),
                  width: double.infinity,
                  child: Builder(
                    builder: (context) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          // Check if the user is scrolling near the bottom
                          if (scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent * 0.9 &&
                              !controller.isPaginating.value &&
                              controller.hasMoreData.value) {
                            // 👈 IMPORTANT: Only load more pages if NOT searching
                            controller.loadNextPage();
                          }
                          return true;
                        },
                        child: Column(
                          children: List.generate(
                            controller
                                    .notificaitoncpnf
                                    .value
                                    .data
                                    ?.datacpnf
                                    ?.length ??
                                0,
                            (index) {
                              DatumCpnf? dd = controller
                                  .notificaitoncpnf
                                  .value
                                  .data
                                  ?.datacpnf?[index];
                              return Column(
                                children: [
                                  // Notifications Section
                                  Container(
                                    width: double.infinity,
                                    constraints: const BoxConstraints(
                                      maxWidth: 400,
                                    ),
                                    margin: const EdgeInsets.only(top: 44),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        CustomerRequestCard(dd: dd),
                                        const SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerRequestCard extends StatelessWidget {
  final DatumCpnf? dd;

  const CustomerRequestCard({super.key, this.dd});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 640 && screenWidth <= 991;
    final isMobile = screenWidth <= 640;
    final controller = Get.find<ServiceController>();

    double containerMaxWidth = 400;
    double containerPadding = 27;
    double contentWidth = 346;
    double imageHeight = 240;
    double borderRadius = 20;
    double contentGap = 19;
    double titleFontSize = 20;
    double descriptionFontSize = 16;
    double locationFontSize = 14;

    if (isTablet) {
      containerMaxWidth = 350;
      containerPadding = 20;
      contentWidth = 310;
    } else if (isMobile) {
      containerMaxWidth = 320;
      containerPadding = 16;
      contentWidth = 288;
      imageHeight = 200;
      borderRadius = 16;
      contentGap = 16;
      titleFontSize = 18;
      descriptionFontSize = 14;
      locationFontSize = 13;
    }

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: containerMaxWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: const Color(0xFFFFE0C9)),
          color: const Color(0xFFFFF5F0),
        ),
        padding: EdgeInsets.all(containerPadding),
        child: SizedBox(
          width: contentWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "New Customer",
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w700,
                  height: 24 / titleFontSize,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: contentGap),
              // Image with pagination dots
              SizedBox(
                height: 235,
                child: Stack(
                  children: [
                    // Start of the updated image list (PageView.builder)
                    dd?.images?.isEmpty ?? [].isEmpty
                        ? Container()
                        : SizedBox(
                            height:
                                imageHeight, // Use the dynamically calculated height
                            child: PageView.builder(
                              itemCount:
                                  dd?.images?.length ??
                                  0, // Assumed number of images, matching the dots
                              itemBuilder: (context, index) {
                                // Placeholder list of image URLs for demonstration.
                                // You should replace this with a dynamic list property.
                                var image = dd?.images?[index];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    borderRadius,
                                  ), // Use dynamic radius
                                  child: CustomImageView(
                                    imagePath: image
                                        ?.imageUrl, // Use the image for the current index
                                    width: contentWidth,
                                    height: imageHeight,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                    // End of the updated image list (PageView.builder)

                    // Pagination dots (existing code for context)
                    Positioned(
                      left: isMobile ? 104 : (isTablet ? 115 : 126),
                      top: isMobile ? 176 : 216,
                      child: Row(
                        children: List.generate(dd?.images?.length ?? 0, (
                          index,
                        ) {
                          return Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: 20,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFCCCCCC),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: contentGap),

              // Location
              Text(
                "${dd?.address}",
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: locationFontSize,
                  fontWeight: FontWeight.w700,
                  height: 24 / locationFontSize,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: contentGap),

              // Description with "More" link
              SizedBox(
                height: isMobile ? null : 48,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: descriptionFontSize,
                      fontWeight: FontWeight.w400,
                      height: 24 / descriptionFontSize,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: "${dd?.description}"),
                      const TextSpan(text: ' '),
                      const TextSpan(
                        text: 'More',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF16577F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: contentGap),

              // Action buttons
              isMobile
                  ? dd?.status == "5"
                        ? Container()
                        : Column(
                            children: [
                              dd?.status == "3"
                                  ? Container()
                                  : _buildButton(
                                      text: 'Cancel',
                                      backgroundColor: const Color(0xFFDC2626),
                                      onPressed: () {},
                                      width: double.infinity,
                                    ),
                              const SizedBox(height: 8),
                              _buildButton(
                                text: dd?.status == "3"
                                    ? "Completo"
                                    : 'Aprovar',
                                backgroundColor: const Color(0xFF1E40AF),
                                onPressed: () {
                                  dd?.status == "3"
                                      ? controller.completedRequest(
                                          id: "${dd?.slug}",
                                        )
                                      : Get.to(() => ApproveRequest(dd: dd));
                                },
                                width: double.infinity,
                              ),
                            ],
                          )
                  : Row(
                      children: [
                        _buildButton(
                          text: 'Cancel',
                          backgroundColor: const Color(0xFFDC2626),
                          onPressed: () {},
                          width: 145,
                        ),
                        const SizedBox(width: 10),
                        _buildButton(
                          text: 'Approve',
                          backgroundColor: const Color(0xFF1E40AF),
                          onPressed: () {},
                          width: 145,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color backgroundColor,
    required VoidCallback? onPressed,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 13),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 24 / 14,
          ),
        ),
      ),
    );
  }
}
