import 'package:queroobras_mobile/mvvm/screens/dashboard/webview.dart';

import '../../../const/export.dart';

class NotificationCpnScreen extends StatelessWidget {
  const NotificationCpnScreen({super.key});

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
              future: controller.loadNoficationCpn(isInitial: true),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting &&
                    controller.notificaitoncpnfCpn.value.data == null) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final notifications = controller
                    .notificaitoncpn.value.data?.data ??
                    [];

                return Container(
                  constraints: const BoxConstraints(maxWidth: 480),
                  width: double.infinity,
                  child: Column(
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 400),
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_outlined),
                            ),
                            const SizedBox(width: 33),
                            Expanded(
                              child: Container(
                                height: 34,
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Notificações',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontFamily: 'Josefin Sans',
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// EMPTY STATE
                      if (notifications.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Center(
                            child: Column(
                              children: [
                                CustomImageView(imagePath: "assets/images/new_notification.svg",),
                                Text(
                                  'Ainda não há notificações',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                      // Notifications Section
                      NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          // Check if the user is scrolling near the bottom
                          if (scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent * 0.9 &&
                              !controller.isPaginatingCpn.value &&
                              controller.hasMoreDataCpn.value) {
                            // 👈 IMPORTANT: Only load more pages if NOT searching
                            controller.loadNextPageCpn();
                          }
                          return true;
                        },
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(maxWidth: 400),
                          margin: const EdgeInsets.only(top: 44),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: List.generate(
                              controller
                                      .notificaitoncpn
                                      .value
                                      .data
                                      ?.data
                                      ?.length ??
                                  0,
                              (index) {
                                var dd = controller
                                    .notificaitoncpn
                                    .value
                                    .data
                                    ?.data?[index];
                                return Column(
                                  children: [
                                    // Service Provider Notification
                                    NotificationCard(
                                      title: 'Service Provider',
                                      description:
                                          'The service provider ${dd?.provider?.name} [specialisation] accept your request and the price is \$${dd?.replies?.first.amount}.',
                                      actions: [
                                        dd?.status == "5"
                                            ? Container()
                                            : Row(
                                                children: [
                                                  NotificationButton(
                                                    text: 'Cancel',
                                                    backgroundColor:
                                                        const Color(0xFFD10000),
                                                    onPressed: () {
                                                      controller.rejectRequest(
                                                        id: dd?.slug ?? "",
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(width: 10),

                                                NotificationButton(
                                                  text: dd?.status == "4"
                                                      ? "Concluído"
                                                      : 'Pay',
                                                  backgroundColor: const Color(
                                                    0xFF16577F,
                                                  ),
                                                  onPressed: () {
                                                    dd?.status == "4"
                                                        ? controller
                                                              .completeRequestClient(
                                                                id: "${dd?.slug}",
                                                              )
                                                        : showLogoutDialog(dd);
                                                  },
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),

                                  const SizedBox(height: 15),

                                  // // System Update Notification
                                  // if (userStatus != "cnpj")
                                  //   const NotificationCard(
                                  //     title: '[!] New Update',
                                  //     description:
                                  //         'Check the new update that we share in your system.',
                                  //   ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    // Bottom padding
                    const SizedBox(height: 472),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ));
  }

  void showLogoutDialog(DatumCpn? dd) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ), // Softer corners
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Info Icon (Circular Border)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black54, width: 2),
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 40,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),

              // Text Message
              const Text(
                "Ao clicar em 'Aceitar', você será redirecionado para o nosso parceiro de pagamento seguro, Mercado Pago, para concluir sua transação.",
                // Replace with your logout text:
                // "Ao clicar em 'Sair', sua sessão será encerrada e você precisará fazer login novamente.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF555555), // Muted dark grey
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),

              // Primary Action Button (Accept/Sair)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.to(
                      () => WebViewScreen(
                        url: "${dd?.replies?.first.paymentLink}",
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        CustomColor.primary, // The specific orange in the image
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Aceitar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Secondary Action Button (Cancel)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFE0E0E0,
                    ), // Light grey background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Color(0xFF4A6572), // Muted blue-grey text
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget>? actions;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if we are on a small screen to adjust padding/spacing
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 360;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFFFF3EA),
        border: Border.all(color: const Color(0xFFFFE0C9), width: 1),
      ),
      padding: EdgeInsets.all(isSmallScreen ? 12 : 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              // Scale font size slightly based on screen width
              fontSize: screenWidth > 600 ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Josefin Sans',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'Josefin Sans',
              height: 1.4,
            ),
          ),
          if (actions != null) ...[
            const SizedBox(height: 24), // Reduced from 43 for better mobile fit
            // Use Wrap instead of Row to handle button overflow
            Wrap(
              spacing: 12, // Horizontal space between buttons
              runSpacing: 12, // Vertical space if buttons wrap to next line
              children: actions!.map((button) {
                // Ensure buttons take up appropriate space
                return ConstraintsTransformBox(
                  constraintsTransform: ConstraintsTransformBox.unconstrained,
                  child: button,
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class NotificationButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const NotificationButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Remove hardcoded width: 145 to allow button to be flexible
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            minimumSize: const Size(120, 48), // Set a minimum rather than fixed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Josefin Sans',
            ),
          ),
        );
      },
    );
  }
}

class CustomerRequestCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String location;
  final String description;
  final VoidCallback? onCancel;
  final VoidCallback? onApprove;

  const CustomerRequestCard({
    super.key,
    this.title = 'New customer',
    this.imageUrl =
        'https://api.builder.io/api/v1/image/assets/TEMP/57d5fd924518d37875d103d9da2aa409350dfd72?width=692',
    this.location = 'Nigeria - turkey',
    this.description =
        'i want you to repair my bathroom and to make it more beautiful.',
    this.onCancel,
    this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 640 && screenWidth <= 991;
    final isMobile = screenWidth <= 640;

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
                title,
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CustomImageView(
                        imagePath: imageUrl,
                        width: contentWidth,
                        height: imageHeight,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Pagination dots
                    Positioned(
                      left: isMobile ? 104 : (isTablet ? 115 : 126),
                      top: isMobile ? 176 : 216,
                      child: Row(
                        children: List.generate(4, (index) {
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
                location,
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
                      TextSpan(text: description),
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
                  ? Column(
                      children: [
                        _buildButton(
                          text: 'Cancel',
                          backgroundColor: const Color(0xFFDC2626),
                          onPressed: onCancel,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 8),
                        _buildButton(
                          text: 'Approve',
                          backgroundColor: const Color(0xFF1E40AF),
                          onPressed: onApprove,
                          width: double.infinity,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        _buildButton(
                          text: 'Cancel',
                          backgroundColor: const Color(0xFFDC2626),
                          onPressed: onCancel,
                          width: 145,
                        ),
                        const SizedBox(width: 10),
                        _buildButton(
                          text: 'Approve',
                          backgroundColor: const Color(0xFF1E40AF),
                          onPressed: onApprove,
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
