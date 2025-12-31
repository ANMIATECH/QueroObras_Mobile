import 'package:queroobras_mobile/mvvm/const/export.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductDetailsController());

    final controller = Get.find<ProductDetailsController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              // Title Section
              FutureBuilder(
                future: controller.getCart(),
                builder: (context, asyncSnapshot) {
                  return Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      'Pedidos',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily: 'Josefin Sans',
                        height: 1.06,
                      ),
                    ),
                  );
                },
              ),
      
              // Orders List
              Expanded(
                child: Obx(() {
                  // Loading
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
      
                  final items = controller.cart.value.data?.items ?? [];
      
                  // Empty cart
                  if (items.isEmpty) {
                    return const Center(
                      child: Text(
                        'Seu carrinho está vazio',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }
      
                  // Cart items
                  return Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final data = items[index];
                        return OrderItem(
                          dd: data.item!,
                          onTap: () => controller.removeFromCart(
                            itemSlug: "${data.item?.slug}",
                          ),
                          imageUrl: '${data.item?.files?.first.path}',
                          title: '${data.item?.name}',
                          subtitle: '${data.item?.type}',
                          price: 'R\$${data.item?.price} (Q${data.item?.quantity})',
                        );
                      },
                    ),
                  );
                }),
              ),
      
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() {
                  return CustomButton(
                    isLoading: controller.isLoading.value,
                    text:
                        "${CustomText.checkOut} R\$${controller.cart.value.data?.totalPrice}",
                    onPressed: () {
                      if (controller.cart.value.data?.items?.isEmpty == true) {
                        CustomLoading.showNotification(
                          message: 'Seu carrinho está vazio',
                          messageType: MessageType.error,
                        );
                        return;
                      }
                      showLogoutDialog(controller);
      
                      // controller.checkoutChart();
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutDialog(ProductDetailsController controller) {
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
                    controller.checkoutChart();
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
