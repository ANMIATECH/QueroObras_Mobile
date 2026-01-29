import '../../../const/export.dart';

class NotificationCpnfScreen extends StatelessWidget {
  const NotificationCpnfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
    );
  }
}

class CustomerRequestCard extends StatefulWidget {
  final DatumCpnf? dd;

  const CustomerRequestCard({super.key, this.dd});

  @override
  State<CustomerRequestCard> createState() => _CustomerRequestCardState();
}

class _CustomerRequestCardState extends State<CustomerRequestCard> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      if (mounted) {
        setState(() {
          _currentPage = _pageController.page?.round() ?? 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 640 && screenWidth <= 991;
    final isMobile = screenWidth <= 640;
    final controller = Get.find<ServiceController>();

    // Responsive values
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
      imageHeight = 220;
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

    final hasImages =
        widget.dd?.images != null && widget.dd!.images!.isNotEmpty;
    final imageCount = hasImages ? widget.dd!.images!.length : 0;

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

              // Images + Dots (only if images exist)
              if (hasImages) ...[
                SizedBox(
                  height: imageHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image carousel
                      PageView.builder(
                        controller: _pageController,
                        itemCount: imageCount,
                        itemBuilder: (context, index) {
                          final image = widget.dd!.images![index];
                          final url = image.imageUrl ?? '';

                          return ClipRRect(
                            borderRadius: BorderRadius.circular(borderRadius),
                            child: CustomImageView(
                              imagePath: url,
                              width: contentWidth,
                              height: imageHeight,
                              fit: BoxFit.cover,
                              // Recommended additions if CustomImageView supports them:
                              // errorWidget: const Icon(Icons.broken_image, size: 64, color: Colors.grey),
                              // placeholder: const Center(child: CircularProgressIndicator()),
                            ),
                          );
                        },
                      ),

                      // Pagination dots (only show if more than 1 image)
                      if (imageCount > 1)
                        Positioned(
                          bottom: 12,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(imageCount, (index) {
                                final isActive = index == _currentPage;
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: isActive ? 24 : 12,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: isActive
                                        ? Colors.black.withOpacity(0.8)
                                        : const Color(0xFFCCCCCC),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: contentGap),
              ],

              // Location
              Text(
                widget.dd?.address ?? 'No address provided',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: locationFontSize,
                  fontWeight: FontWeight.w700,
                  height: 24 / locationFontSize,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: contentGap),

              // Description + "More"
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
                      TextSpan(
                        text: (widget.dd?.description ?? '').trim().isEmpty
                            ? 'No description available'
                            : widget.dd!.description!,
                      ),
                      const TextSpan(text: '  '),
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
              if (isMobile)
                if (widget.dd?.status == "5")
                  const SizedBox.shrink()
                else
                  Column(
                    children: [
                      if (widget.dd?.status != "3")
                        _buildButton(
                          text: 'Cancel',
                          backgroundColor: const Color(0xFFDC2626),
                          onPressed: () {
                            // TODO: implement cancel logic
                          },
                          width: double.infinity,
                        ),
                      if (widget.dd?.status != "3") const SizedBox(height: 8),
                      _buildButton(
                        text: widget.dd?.status == "3" ? "Completo" : 'Aprovar',
                        backgroundColor: const Color(0xFF1E40AF),
                        onPressed: () {
                          if (widget.dd?.status == "3") {
                            controller.completedRequest(
                              id: "${widget.dd?.slug}",
                            );
                          } else {
                            Get.to(() => ApproveRequest(dd: widget.dd));
                          }
                        },
                        width: double.infinity,
                      ),
                    ],
                  )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildButton(
                      text: 'Cancel',
                      backgroundColor: const Color(0xFFDC2626),
                      onPressed: () {
                        // TODO: implement cancel
                      },
                      width: 145,
                    ),
                    _buildButton(
                      text: 'Approve',
                      backgroundColor: const Color(0xFF1E40AF),
                      onPressed: () {
                        // TODO: implement approve
                      },
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
