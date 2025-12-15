import '../../../const/export.dart';


class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar( title: Text(
          "Meu pedidos",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            fontFamily: 'Josefin Sans',
            height: 1,
          ),
        ),
          backgroundColor: Colors.white,),

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
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Josefin Sans',
                            height: 24 / 14,
                          ),
                          children: [
                            TextSpan(text: 'Pedido nº 1735828712\n'),
                            TextSpan(text: 'Realizado em: 26-10-2025\n'),
                            TextSpan(text: 'Nº de itens: 3\n'),
                            TextSpan(text: 'Total: R\$ 53.750'),

                          ],
                        ),
                      ),


                      const SizedBox(height: 15),

                      // Order Item Card
                      const OrderItemCard(),

                      const SizedBox(height: 15),

                      CustomButton(
                        text: CustomText.trackOrder,
                        onPressed: () async {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.progressTracker);
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
  const OrderItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF8F8F8),
      ),
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Badge
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFF2CA3AB),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 1),
            child: const Text(
              'Em trânsito',
              style: TextStyle(
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
              // Product Image
              Container(
                width: 122,
                height: 122,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: CustomImageView(imagePath:
                  'assets/images/cement.png',
                  width: 122,
                  height: 122,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 10),

              // Product Details
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Description
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Título',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Josefin Sans',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Legenda',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Josefin Sans',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      // Price
                      const Text(
                        '\$20',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Josefin Sans',
                          color: Colors.black,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
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
