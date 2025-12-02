import '../const/export.dart';
import '../screens/dashboard/cnpj/cnpj_home.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  // Screens for navigation
  final List<Widget> screens = [
    const CnpjHomeScreen(),
    // OrdersScreen(),
    // ChatScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  final List<Map<String, String>> navItems = [
    {
      'activeIcon': CustomImage.homeActive,
      'inactiveIcon': CustomImage.homeInactive,
      'label': 'Home',
    },
    // {
    //   'activeIcon': CustomImage.orderActive,
    //   'inactiveIcon': CustomImage.orderInactive,
    //   'label': 'Order',
    // },
    // {
    //   'activeIcon': CustomImage.chat,
    //   'inactiveIcon': CustomImage.chat,
    //   'label': '',
    // },
    {
      'activeIcon': CustomImage.searchActive,
      'inactiveIcon': CustomImage.searchInactive,
      'label': 'Search',
    },
    {
      'activeIcon': CustomImage.profileActive,
      'inactiveIcon': CustomImage.profileInactive,
      'label': 'Profile',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: screens,
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFF4F3F3), width: 1),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(30, 13, 30, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(navItems.length, (index) {
                final item = navItems[index];

                // // ✅ Middle button (Chat button)
                // if (index == 2) {
                //   return GestureDetector(
                //     onTap: () => controller.changeIndex(2), // ✅ Go to ChatScreen
                //     child: SizedBox(
                //       width: 50,
                //       height: 50,
                //       child: CustomImageView(
                //         imagePath: item['activeIcon'],
                //         fit: BoxFit.contain,
                //       ),
                //     ),
                //   );
                // }

                // Other tabs
                return GestureDetector(
                  onTap: () => controller.changeIndex(index),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImageView(
                        imagePath: controller.selectedIndex.value == index
                            ? item['activeIcon']
                            : item['inactiveIcon'],
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item['label']!,
                        style: TextStyle(
                          color: controller.selectedIndex.value == index
                              ? Colors.black
                              : Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}
