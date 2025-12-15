import 'package:queroobras_mobile/mvvm/const/extension.dart';
import 'package:queroobras_mobile/mvvm/model/pay_order.dart';
import 'package:queroobras_mobile/mvvm/screens/dashboard/order/trackmy_order.dart';

import '../../../const/export.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key, this.dd});
  final DataItemPayOrder? dd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Meu pedidos",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            fontFamily: 'Josefin Sans',
            height: 1,
          ),
        ),
        backgroundColor: Colors.white,
      ),

      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Order Details Content
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),

                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Josefin Sans',
                            height: 24 / 14,
                          ),
                          children: [
                            TextSpan(text: 'Pedido nº ${dd?.order?.slug}\n'),
                            TextSpan(
                              text:
                                  'Realizado em: ${dd?.order?.createdAt?.toYearMonthDay}\n',
                            ),
                            TextSpan(
                              text:
                                  'Nº de itens: ${dd?.order?.totalQuantity}\n',
                            ),
                            TextSpan(
                              text: 'Total: R\$ ${dd?.order?.totalPrice}',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Order Item Card
                      OrderItemCard(dd: dd),

                      const SizedBox(height: 15),

                      CustomButton(
                        text: CustomText.trackOrder,
                        onPressed: () async {
                          Get.to(() => SellerProgressTracking(dd: dd));
                        },
                      ),

                      const SizedBox(height: 20),
                    ],
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
  const OrderItemCard({super.key, this.dd});
  final DataItemPayOrder? dd;

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive sizing
    final double screenWidth = MediaQuery.of(context).size.width;

    // Define a responsive size for the image (e.g., 30% of screen width, or a max of 122)
    final double imageSize = (screenWidth * 0.3).clamp(90.0, 122.0);

    return Container(
      // The width is already set to double.infinity, which is good.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF8F8F8),
      ),
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Badge
          // This section is already fairly responsive as it sizes based on its content.
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFF2CA3AB),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 1),
            child: Text(
              '${dd?.orderItem?.status}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'Josefin Sans',
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Product Information Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image (Responsive Size)
              Container(
                width: imageSize,
                height: imageSize,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: CustomImageView(
                  imagePath: dd?.item?.files?.first.path,
                  width: imageSize, // Use responsive size
                  height: imageSize, // Use responsive size
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 10),

              // Product Details (Uses Expanded for remaining space)
              Expanded(
                // Remove the fixed height (height: 56) from SizedBox
                // to allow the content to take the necessary height.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title (uses maxLines and overflow for small screens)
                        Text(
                          '${dd?.item?.name}',
                          maxLines: 2, // Limit lines for cleaner display
                          overflow: TextOverflow.ellipsis, // Handle overflow
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                            color: Colors.black,
                          ),
                        ),
                        // Description (uses maxLines and overflow for small screens)
                        Text(
                          '${dd?.item?.description}',
                          maxLines: 2, // Limit lines
                          overflow: TextOverflow.ellipsis, // Handle overflow
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Josefin Sans',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    // Price
                    // Added a small vertical space before the price
                    const SizedBox(height: 5),
                    Text(
                      '\$ ${dd?.item?.price}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Josefin Sans',
                        color: Colors.black,
                        height: 1.2, // Adjusted height for better spacing
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

class TrackButton extends StatelessWidget {
  const TrackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFFF9761E),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 13),
      child: const Text(
        'Track your order',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Josefin Sans',
          color: Colors.white,
          height: 1.2,
        ),
      ),
    );
  }
}
