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
                  // Check loading state (assuming getCart() sets a loading flag)
                  if (controller.isLoading.value &&
                      controller.cart.value.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var dd = controller.cart.value.data?.items ?? [];

                  // Check for empty cart
                  if (dd.isEmpty) {
                    return const Center(child: Text('Your cart is empty!'));
                  }
                  return Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: dd.length, // dynamically create 5 items
                      itemBuilder: (context, index) {
                        var data = dd[index];
                        return OrderItem(
                          dd: data.item!,
                          onTap: () => controller.removeFromCart(
                            itemSlug: "${data.item?.slug}",
                          ),
                          imageUrl: 'assets/images/Ferramentas.svg',
                          title: '${data.item?.name} ',
                          subtitle: '${data.item?.type}',
                          price:
                              '\$${data.item?.price} (Q${data.item?.quantity})', // just to vary the price
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
                    text:
                        "${CustomText.checkOut} \$${controller.cart.value.data?.totalPrice}",

                    onPressed: () {},
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
