import '/mvvm/const/export.dart';


class MyHireScreen extends StatelessWidget {
  const MyHireScreen({super.key});

  // Sample data list
  final List<Map<String, String>> hires = const [
    {
      'name': 'David',
      'role': 'Role',
      'distance': '1km from you',
      'price': 'R\$ 50/h',
      'status': 'Completed',
      'imageUrl': 'assets/images/profile_dummy.png',
    },
    {
      'name': 'David',
      'role': 'Role',
      'distance': '1km from you',
      'price': 'R\$ 50/h',
      'status': 'In service',
      'imageUrl': 'assets/images/profile_dummy.png',
    },
    // Add more items here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meu Hire",
          style: TextStyle(
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
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 480),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: hires.length,
          itemBuilder: (context, index) {
            final hire = hires[index];
            return Column(
              children: [
                ServiceProviderCard(
                  name: hire['name']!,
                  role: hire['role']!,
                  distance: hire['distance']!,
                  price: hire['price']!,
                  status: hire['status']!,
                  imageUrl: hire['imageUrl']!,
                  onTap: () {
                    print('${hire['name']} tapped!');
                    Navigator.of(context).pushNamed(AppRoutes.myHireReview);
    
                  },
                ),
                if (index != hires.length - 1) const SizedBox(height: 20),
              ],
            );
          },
        )
        ,
      ),
    );
  }
}

class ServiceProviderCard extends StatelessWidget {
  final String name;
  final String role;
  final String distance;
  final String price;
  final String status;
  final String imageUrl;
  final VoidCallback? onTap; // Added onTap callback

  const ServiceProviderCard({
    super.key,
    required this.name,
    required this.role,
    required this.distance,
    required this.price,
    required this.status,
    required this.imageUrl,
    this.onTap, // Optional
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF009059);
      case 'in service':
        return const Color(0xFFD6A103);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Trigger when tapped
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF8F8F8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left section with image and details
            Expanded(
              child: Row(
                children: [
                  // Profile image
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomImageView(
                      imagePath: imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Name, role, and distance
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Name and role section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                role,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF7E7878),
                                ),
                              ),
                            ],
                          ),
                          // Distance
                          Text(
                            distance,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Right section with price and status
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _getStatusColor(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
