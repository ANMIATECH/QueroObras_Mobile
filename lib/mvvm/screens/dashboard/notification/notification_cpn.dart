import 'package:queroobras_mobile/mvvm/screens/dashboard/webview.dart';

import '../../../const/export.dart';

class NotificationCpnScreen extends StatelessWidget {
  const NotificationCpnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Notificações'),
      ),
      body: SafeArea(
        child: Obx(() {
          // Using Obx here so it rebuilds when the observable list changes
          final notifications =
              controller.notificaitoncpn.value.data?.data ?? [];

          // if (controller.isLoadingNotifications.value && notifications.isEmpty) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          if (notifications.isEmpty) {
            return _EmptyNotificationsState();
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent * 0.85 &&
                  !controller.isPaginatingCpn.value &&
                  controller.hasMoreDataCpn.value) {
                controller.loadNextPageCpn();
              }
              return false;
            },
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 40),
              itemCount:
                  notifications.length +
                  (controller.isPaginatingCpn.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == notifications.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final item = notifications[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: NotificationCard(
                    title: 'Prestador de Serviço',
                    description: _buildNotificationDescription(item),
                    actions: _buildActionButtons(item, controller),
                    status: item.status ?? "",
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  String _buildNotificationDescription(DatumCpn? item) {
    if (item == null || item.provider?.name == null) {
      return 'Sua solicitação foi atualizada.';
    }

    final name = item.provider!.name!;
    final amount = item.replies?.isNotEmpty == true
        ? item.replies!.first.amount ?? '0'
        : '0';

    return 'O prestador de serviço $name aceitou sua solicitação e o preço é R\$$amount.';
  }

  List<Widget> _buildActionButtons(DatumCpn? dd, ServiceController controller) {
    if (dd == null) return const [];

    // ── Status 5: Accepted case ────────────────────────────────────────
    if (dd.customerAccepted == "1") {
      return [
        NotificationButton(
          text: 'Bater papo',
          backgroundColor: const Color(0xFFD10000),
          onPressed: () {
            final provider = dd.provider;
            if (provider == null) return;

            Get.to(
              () => OneOnOneChat(
                id: '${provider.id ?? ''}',
                userName: provider.name ?? 'Prestador',
              ),
            );
          },
        ),
      ];
    }

    // ── Default case: Cancel + Pay / Complete ───────────────────────────
    if (dd.status == "3") return [];
    return [
      NotificationButton(
        text: 'Cancelar',
        backgroundColor: const Color(0xFFD10000),
        onPressed: () => controller.rejectRequest(id: dd.slug ?? ''),
      ),
      const SizedBox(width: 12),
      NotificationButton(
        text: dd.status == '4' ? 'Concluído' : 'Pagar',
        backgroundColor: const Color(0xFF16577F),
        onPressed: () {
          if (dd.status == '4') {
            controller.completeRequestClient(id: dd.slug ?? '');
          } else if (dd.replies?.isNotEmpty == true) {
            _showPaymentConfirmationDialog(dd);
          }
        },
      ),
    ];
  }

  void _showPaymentConfirmationDialog(DatumCpn dd) {
    final paymentLink = dd.replies?.firstOrNull?.paymentLink;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black54, width: 2),
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 48,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ao clicar em "Aceitar", você será redirecionado para o Mercado Pago para concluir o pagamento de forma segura.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF444444),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 32),
              _DialogButton(
                text: 'Aceitar',
                color: CustomColor.primary,
                textColor: Colors.white,
                onPressed: () {
                  Get.back();
                  if (paymentLink != null && paymentLink.isNotEmpty) {
                    Get.to(() => WebViewScreen(url: paymentLink));
                  } else {
                    Get.snackbar('Erro', 'Link de pagamento não disponível');
                  }
                },
              ),
              const SizedBox(height: 12),
              _DialogButton(
                text: 'Cancelar',
                color: const Color(0xFFE0E0E0),
                textColor: const Color(0xFF4A6572),
                onPressed: Get.back,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Helper Widgets ──────────────────────────────────────────────────────

class _EmptyNotificationsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              imagePath: 'assets/images/new_notification.svg',
              height: 140,
            ),
            const SizedBox(height: 32),
            Text(
              'Ainda não há notificações',
              style: TextStyle(
                fontSize: 19,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const _DialogButton({
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String status;
  final String description;
  final List<Widget>? actions;

  const NotificationCard({
    super.key,
    required this.title,
    required this.status,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth > 600 ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Josefin Sans',
                  ),
                ),
              ),
              if (status == "3") ...[
                const SizedBox(width: 12),
                _StatusBadge(
                  label: "cancelar",
                  color: Colors.red,
                  backgroundColor: Colors.red.withValues(alpha: 0.1),
                ),
              ],
            ],
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

// Small reusable badge widget
class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color backgroundColor;

  const _StatusBadge({
    required this.label,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999), // pill shape (fully rounded)
        // border: Border.all(color: color.withOpacity(0.3), width: 1), // optional subtle border
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.4,
          fontFamily: 'Josefin Sans',
        ),
      ),
    );
  }
}
