import '../const/export.dart';

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
    const HomeScreen(),
    // Replace these Containers with your actual screens
    Container(color: Colors.red),
    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
  ];

  final List<Map<String, String>> navItems = [
    {
      'activeIcon': CustomImage.homeActive,
      'inactiveIcon': CustomImage.homeInactive,
      'label': 'Home',
    },
    {
      'activeIcon': CustomImage.orderActive,
      'inactiveIcon': CustomImage.orderInactive,
      'label': 'Order',
    },
    {
      'activeIcon': CustomImage.chat,
      'inactiveIcon': CustomImage.chat,
      'label': '',
    },
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
              border: Border(top: BorderSide(color: Color(0xFFF4F3F3), width: 1)),
            ),
            padding: const EdgeInsets.fromLTRB(30, 13, 30, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(navItems.length, (index) {
                final item = navItems[index];
      
                // Middle button (special style)
                if (index == 2) {
                  return SizedBox(
                    width: 50,
                    height: 50,
                    child: CustomImageView(
                      imagePath: item['activeIcon'],
                      fit: BoxFit.contain,
                    ),
                  );
                }
      
                // Other tabs
                return GestureDetector(
                  onTap: () => controller.changeIndex(index),
                  child: index == 0
                      ? Column(
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
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ],
                  )
                      : Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
