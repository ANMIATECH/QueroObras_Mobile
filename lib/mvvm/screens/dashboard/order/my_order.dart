import '../../../const/export.dart';


class MyOrder extends StatelessWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar( title: Text(
          "Prestador",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            fontFamily: 'Josefin Sans',
            height: 1,
          ),
        ),
          backgroundColor: Colors.white,
          elevation: 0,),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // Main Content
                Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // if inside another scroll view
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        final items = [
                          {
                            'name': 'David',
                            'subtitle': 'Product',
                            'status': 'In road',
                          },
                          {
                            'name': 'David',
                            'subtitle': 'Role',
                            'status': 'Deliver',
                          },{
                            'name': 'David',
                            'subtitle': 'Product',
                            'status': 'In road',
                          },
                          {
                            'name': 'David',
                            'subtitle': 'Role',
                            'status': 'Deliver',
                          },{
                            'name': 'David',
                            'subtitle': 'Product',
                            'status': 'In road',
                          },
                          {
                            'name': 'David',
                            'subtitle': 'Role',
                            'status': 'Deliver',
                          },{
                            'name': 'David',
                            'subtitle': 'Product',
                            'status': 'In road',
                          },
                          {
                            'name': 'David',
                            'subtitle': 'Role',
                            'status': 'Deliver',
                          },{
                            'name': 'David',
                            'subtitle': 'Product',
                            'status': 'In road',
                          },
                          {
                            'name': 'David',
                            'subtitle': 'Role',
                            'status': 'Deliver',
                          },{
                            'name': 'David',
                            'subtitle': 'Product',
                            'status': 'In road',
                          },
                          {
                            'name': 'David',
                            'subtitle': 'Role',
                            'status': 'Deliver',
                          },{
                            'name': 'David',
                            'subtitle': 'Product',
                            'status': 'In road',
                          },
                          {
                            'name': 'David',
                            'subtitle': 'Role',
                            'status': 'Deliver',
                          },
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: OrderItemCard(
                            name: items[index]['name']!,
                            subtitle: items[index]['subtitle']!,
                            onTap: (){
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.myOrderDetails);
                            },
                            status: items[index]['status']!,
                            avatarUrl:
                            'assets/images/profile_dummy.png',
                          ),
                        );
                      },
                    ),
                  ],
                ),
]

            ),
          ),
        ),
      ),
    );
  }
}


class OrderItemCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String status;
  final String avatarUrl;
  final VoidCallback? onTap; // 👈 add this

  const OrderItemCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.status,
    required this.avatarUrl,
    this.onTap, // 👈 add this
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 👈 handle tap
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomImageView(imagePath: avatarUrl),
            ),
            const SizedBox(width: 10),

            // Content
            Expanded(
              child: SizedBox(
                height: 56,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and subtitle
                    SizedBox(
                      height: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontFamily: 'Josefin Sans',
                            ),
                          ),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF7E7878),
                              fontFamily: 'Josefin Sans',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Status
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        status,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF16577F),
                          height: 1.0,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
