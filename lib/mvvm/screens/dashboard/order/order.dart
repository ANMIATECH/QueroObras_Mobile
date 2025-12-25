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
                  // Loading state
                  if (controller.isLoading.value &&
                      controller.cart.value.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final items = controller.cart.value.data?.items ?? [];

                  // Empty cart state
                  if (items.isEmpty) {
                    return const Center(
                      child: Text(
                        'Seu carrinho está vazio!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  // Cart items list
                  return Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    margin: const EdgeInsets.only(top: 16),
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
                          price:
                          '\R${data.item?.price} (Q${data.item?.quantity})',
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
                        "${CustomText.checkOut} \R${controller.cart.value.data?.totalPrice}",

                    onPressed: () {
                      controller.checkoutChart();
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
}
