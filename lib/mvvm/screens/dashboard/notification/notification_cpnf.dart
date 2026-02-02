import '../../../const/export.dart';

class NotificationCpnfScreen extends StatelessWidget {
  const NotificationCpnfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Notificações"),
      ),
      body: SafeArea(
        child: Obx(() {
          final notifications =
              controller.notificaitoncpnf.value.data?.datacpnf ?? [];

          if (controller.isLoading.value && notifications.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                "Nenhuma solicitação encontrada",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent * 0.9 &&
                  !controller.isPaginating.value &&
                  controller.hasMoreData.value) {
                controller.loadNextPage();
              }
              return false;
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount:
                  notifications.length +
                  (controller.isPaginating.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == notifications.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final dd = notifications[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CustomerRequestCard(dd: dd),
                );
              },
            ),
          );
        }),
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
        setState(() => _currentPage = _pageController.page?.round() ?? 0);
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
    final controller = Get.find<ServiceController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 640;

    // Responsive values (unchanged)
    double containerMaxWidth = 400;
    double containerPadding = 27;
    double contentWidth = 346;
    double imageHeight = 240;
    double borderRadius = 20;
    double contentGap = 19;
    double titleFontSize = 20;
    double descriptionFontSize = 16;
    double locationFontSize = 14;

    if (screenWidth > 640 && screenWidth <= 991) {
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

    final item = widget.dd;
    if (item == null) return const SizedBox.shrink();

    final status = (item.statusText ?? '').trim().toLowerCase();
    final hasImages = item.images != null && item.images!.isNotEmpty;
    final imageCount = hasImages ? item.images!.length : 0;

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
                "Novo Cliente",
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w700,
                  height: 24 / titleFontSize,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: contentGap),

              // Images carousel + dots
              if (hasImages) ...[
                SizedBox(
                  height: imageHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: imageCount,
                        itemBuilder: (context, idx) {
                          final url = item.images![idx].imageUrl ?? '';
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(borderRadius),
                            child: CustomImageView(
                              imagePath: url,
                              width: contentWidth,
                              height: imageHeight,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                      if (imageCount > 1)
                        Positioned(
                          bottom: 12,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(imageCount, (idx) {
                                final isActive = idx == _currentPage;
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

              // Location / Address
              Text(
                item.address ?? 'Endereço não informado',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: locationFontSize,
                  fontWeight: FontWeight.w700,
                  height: 24 / locationFontSize,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: contentGap),

              // Description
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
                        text: (item.description ?? '').trim().isEmpty
                            ? 'Sem descrição disponível'
                            : item.description!.trim(),
                      ),
                      const TextSpan(text: '  '),
                      const TextSpan(
                        text: 'Mais',
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

              // Action buttons – now using statusText
              if (status == 'cancelled' || status == 'completed')
                const SizedBox.shrink()
              else if (isMobile)
                Column(
                  children: [
                    if (status != 'cancelled')
                      _buildButton(
                        text: 'Cancelar',
                        backgroundColor: const Color(0xFFDC2626),
                        onPressed: () {
                          // TODO: call controller.cancelRequest(id: item.slug ?? '')
                                                                            controller.cancelRequestClient(id: item.slug ?? '');

                          Get.snackbar(
                            'Ação',
                            'Cancelar solicitação (implementar)',
                          );
                        },
                        width: double.infinity,
                      ),
                    if (status != 'cancelled') const SizedBox(height: 8),
                    _buildButton(
                      text: _getPrimaryButtonText(status),
                      backgroundColor: const Color(0xFF1E40AF),
                      onPressed: () {
                        if (status == 'complete_pending_confirmation') {
                          controller.completedRequest(id: item.slug ?? '');
                        } else {
                          Get.to(() => ApproveRequest(dd: item));
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
                      text: 'Cancelar',
                      backgroundColor: const Color(0xFFDC2626),
                      onPressed: () {
                        // TODO: implement cancel
                                                  controller.cancelRequestClient(id: item.slug ?? '');

                      },
                      width: 145,
                    ),
                    _buildButton(
                      text: _getPrimaryButtonText(status),
                      backgroundColor: const Color(0xFF1E40AF),
                      onPressed: () {
                        if (status == 'complete_pending_confirmation') {
                          controller.completedRequest(id: item.slug ?? '');
                        } else {
                          Get.to(() => ApproveRequest(dd: item));
                        }
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

  String _getPrimaryButtonText(String status) {
    switch (status) {
      case 'complete_pending_confirmation':
        return 'Completar';
      case 'cancelled':
        return 'Cancelado';
      case 'completed':
        return 'Concluído';
      default:
        return 'Aprovar';
    }
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
