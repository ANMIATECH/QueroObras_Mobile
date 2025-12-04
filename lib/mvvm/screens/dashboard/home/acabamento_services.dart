import '../../../const/export.dart';

class ServiceProvidersScreen extends StatelessWidget {
  const ServiceProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:  Text(
            'Acabamento',
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
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap:(){
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
                                  hintText: 'Acabamento',
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
                            text: 'ocalização',
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
      
                      // Provider list
                      Expanded(
                        child: ListView.builder(
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                // Get.toNamed(RouteNameV1.serviceRequestScreen);

                              },
                              child: ProviderCardA(
                                provider: ServiceProviderA(
                                  name: 'David',
                                  role: 'Eletricista',
                                  distance: '1 km de você',
                                  hourlyRate: 'R\$ 50/h',
                                  imageUrl: 'assets/images/user.png',
                                ),
                              ),
                            );
                          },
                        ),
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

class ServiceProviderA {
  final String name;
  final String role;
  final String distance;
  final String hourlyRate;
  final String imageUrl;

  const ServiceProviderA({
    required this.name,
    required this.role,
    required this.distance,
    required this.hourlyRate,
    required this.imageUrl,
  });
}


class FilterButtonA extends StatelessWidget {
  final String text;
  final String iconUrl;
  final double width;

  const FilterButtonA({
    super.key,
    required this.text,
    required this.iconUrl,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFEEEEEE),
      ),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(imagePath:
            iconUrl,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF16577F),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Josefin Sans',
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}


class ProviderCardA extends StatelessWidget {
  final ServiceProviderA provider;

  const ProviderCardA({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF8F8F8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomImageView(imagePath:
              provider.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Josefin Sans',
                    height: 1.2,
                  ),
                ),
                Text(
                  provider.role,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Josefin Sans',
                    height: 1.7,
                  ),
                ),
                Text(
                  provider.distance,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Josefin Sans',
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
          Text(
            provider.hourlyRate,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

