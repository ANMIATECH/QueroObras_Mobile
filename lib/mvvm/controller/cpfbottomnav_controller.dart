import '../const/export.dart';
import '../screens/dashboard/profile/profile_screen_cpf.dart';

class CPfBottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}


class CpfBottomNavScreen extends StatelessWidget {
  CpfBottomNavScreen({super.key});

  final CPfBottomNavController controller = Get.put(CPfBottomNavController());

  // Screens for navigation
  final List<Widget> screens = [
    const HomeScreen(),
   StorageDesign.validKey(StorageDesign.token)? OrdersScreen() : Container(),
    ChatScreen(),
    StorageDesign.validKey(StorageDesign.token)? MaterialShopScreen(appbarName: 'Buscar',showAppBar: false) : Container(),
    ProfileScreenCpf(),
  ];

  final List<Map<String, String>> navItems = [
    {
      'activeIcon': CustomImage.homeActive,
      'inactiveIcon': CustomImage.homeInactive,
      'label': 'Início',
    },
    {
      'activeIcon': CustomImage.orderActive,
      'inactiveIcon': CustomImage.orderInactive,
      'label': 'Pedidos',
    },
    {
      'activeIcon': CustomImage.chat,
      'inactiveIcon': CustomImage.chat,
      'label': '',
    },
    {
      'activeIcon': CustomImage.searchActive,
      'inactiveIcon': CustomImage.searchInactive,
      'label': 'Buscar',
    },
    {
      'activeIcon': CustomImage.profileActive,
      'inactiveIcon': CustomImage.profileInactive,
      'label': 'Perfil',
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

                // -----------------------------------------------------
                // 🔵 MIDDLE CHAT BUTTON (index = 2)
                // -----------------------------------------------------
                if (index == 2) {
                  return GestureDetector(
                    onTap: () async {
                      String? token = StorageDesign.readItem(
                        StorageDesign.token,
                      );

                      if (token == null || token.isEmpty) {
                        Navigator.of(context).pushNamed(AppRoutes.login);
                      } else {
                        controller.changeIndex(2);
                      }
                    },
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CustomImageView(
                        imagePath: item['activeIcon'],
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }

                // -----------------------------------------------------
                // 🔵 ALL OTHER NAV BUTTONS WITH LOGIN CHECK
                // -----------------------------------------------------
                return GestureDetector(
                  onTap: () async {
                    String? token = StorageDesign.readItem(StorageDesign.token);

                    if (index == 0) {
                      // Home
                      controller.changeIndex(0);
                      return;
                    }

                    // Other tabs require login
                    if (token == null || token.isEmpty) {
                      Navigator.of(context).pushNamed(AppRoutes.login);
                      return;
                    }

                    controller.changeIndex(index);
                  },
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
