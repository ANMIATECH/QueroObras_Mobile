import '../../../const/export.dart';

class ServicesProvidersByCategory extends StatelessWidget {
  final String slug;

  const ServicesProvidersByCategory({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final ServiceController controller = Get.find();

    controller.getPopularServiceProviderBySlug(slug);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Serviços',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
              height: 1,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Column(
            children: [
              // Main Content
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Search bar
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(217),
                          color: const Color(0xFFEEEEEE),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.search_outlined,
                                color: Color(0xFF7F7F7F),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Serviços',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF7F7F7F),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Josefin Sans',
                                    height: 1.5,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Josefin Sans',
                                ),
                                onChanged: (value) {
                                  controller.filterProviders(
                                    value,
                                  ); // 🔎 filter on typing
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 26),

                      // Filter buttons
                      Row(
                        children: const [
                          FilterButtonA(
                            text: 'localização',
                            iconUrl: 'assets/images/location.svg',
                            width: 110,
                          ),
                          SizedBox(width: 7),
                          FilterButtonA(
                            text: 'Avaliação',
                            iconUrl: 'assets/images/bstar.svg',
                            width: 110,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Expanded(
                        child: Obx(() {
                          if (controller.filteredProviders.isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Nenhum prestador de serviço disponível nesta categoria.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF7F7F7F),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Josefin Sans',
                                  ),
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: controller.filteredProviders.length,
                            itemBuilder: (context, index) {
                              final provider = controller.filteredProviders[index];
                              // // 🔍 DEBUG: Print raw provider data
                              // debugPrint('========== PROVIDER [$index] ==========');
                              // debugPrint(provider.toString());
                              // // debugPrint('======================================');
                              final double providerLat =
                                  double.tryParse(
                                    provider['profile']?['latitude'] ?? '0',
                                  ) ??
                                  0;
                              final double providerLng =
                                  double.tryParse(
                                    provider['profile']?['longitude'] ?? '0',
                                  ) ??
                                  0;

                              final double distanceKm =
                                  Geolocator.distanceBetween(
                                    controller.myLat.value,
                                    controller.myLng.value,
                                    providerLat,
                                    providerLng,
                                  ) /
                                  1000;
                              final String firstName = (provider['name'] ?? '')
                                  .split(' ')
                                  .first;
                              final String role = controller.categoryName.value;

                              return GestureDetector(
                                onTap: () {
                                  String? token = StorageDesign.readItem(
                                    StorageDesign.token,
                                  );

                                  if (token == null || token.isEmpty) {
                                    Get.toNamed(AppRoutes.login);
                                  } else {
                                    final providerId = provider['id'];

                                    Get.to(() => ServiceRequestScreen(
                                      providerName: firstName,
                                      serviceName: role,
                                      amount: provider['hourly_rate']?.toString() ?? 'Preço sob consulta',
                                      imageUrl:    provider['profile']?['avatar'] == null
                                          ? 'assets/images/profile_dummy.png'
                                          : "${provider['profile']['avatar']}",
                                      providerLat: double.tryParse(provider['latitude']?.toString() ?? '0') ?? 0,
                                      providerLng: double.tryParse(provider['longitude']?.toString() ?? '0') ?? 0,
                                      serviceProviderId: providerId.toString(), // ✅ REAL ID
                                    ));
                                    // debugPrint('PROVIDER ID => ${provider['id']}');
                                    // debugPrint('PROVIDER ID => ${provider}');
                                    // debugPrint('PROFILE => ${provider['profile']}');
                                    // debugPrint('PROFILE ID => ${provider['profile']?['id']}');
                                    debugPrint('PROFILE LAT => ${provider['profile']?['latitude']}');
                                    debugPrint('PROFILE LNG => ${provider['profile']?['longitude']}');
                                    debugPrint('HOURLY RATE => ${provider['profile']?['hourly_rate']}');

                                  }
                                },
                                child: ProviderCardA(
                                  provider: ServiceProviderA(
                                    name: firstName,
                                    role: role,
                                    distance:
                                        "${distanceKm.toStringAsFixed(1)} km de você",
                                    hourlyRate:
                                        provider['profile']?['hourly_rate']
                                            ?.toString() ??
                                        '',
                                    imageUrl:
                                        provider['profile']?['avatar'] == null
                                        ? 'assets/images/profile_dummy.png'
                                        : "${provider['profile']['avatar']}",
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
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
