import 'package:flutter/material.dart';
import 'package:queroobras_mobile/mvvm/const/custom_image_view.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 640;
    final isMediumScreen = screenWidth <= 991;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Details Section
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Josefin Sans',
                    height: 24 / 14,
                  ),
                  children: [
                    TextSpan(text: 'Order #1735828712\n'),
                    TextSpan(text: 'Placed on: 26-10-2025\n'),
                    TextSpan(text: 'N° of items: 3\n'),
                    TextSpan(text: 'Total: #53,750'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Order Item Card Section
              OrderItemCard(
                status: 'In transit',
                statusColor: const Color(0xFF2CA3AB),
                imageUrl:
                'https://api.builder.io/api/v1/image/assets/TEMP/8fec0c3caf1a623e34843fe0d7c9f35def636d41?width=104',
                title: 'Título',
                subtitle: 'Legenda',
                price: '\$20',
              ),

              const SizedBox(height: 15),

              // Track Order Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Handle track order action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF9761E),
                    padding: EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: isSmallScreen
                          ? 20
                          : isMediumScreen
                          ? 80
                          : 120,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Track your order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Josefin Sans',
                      height: 24 / 20,
                    ),
                    textAlign: TextAlign.center,
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


class OrderItemCard extends StatelessWidget {
  final String status;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final Color statusColor;

  const OrderItemCard({
    super.key,
    required this.status,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 640;

    return Container(
      padding: EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusBadge(
            text: status,
            backgroundColor: statusColor,
            textColor: Colors.white,
          ),
          const SizedBox(height: 14),
          Flex(
            direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: isSmallScreen ? 100 : 122,
                height: isSmallScreen ? 100 : 122,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3E3E3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: CustomImageView(imagePath:
                    imageUrl,
                    width: isSmallScreen ? 42 : 52,
                    height: isSmallScreen ? 65 : 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: isSmallScreen ? 0 : 10,
                height: isSmallScreen ? 15 : 0,
              ),
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
                    const SizedBox(height: 5),
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
                    const SizedBox(height: 10),
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
            ],
          ),
        ],
      ),
    );
  }
}


class StatusBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          fontFamily: 'Josefin Sans',
          height: 24 / 13,
        ),
      ),
    );
  }
}
