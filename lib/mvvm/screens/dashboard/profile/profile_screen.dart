import 'package:queroobras_mobile/mvvm/screens/dashboard/profile/profile_screen_cpf.dart';
import 'package:queroobras_mobile/mvvm/screens/dashboard/webview.dart';

import '../../../controller/profile_controller.dart';
import '/mvvm/const/export.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 440),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const ProfileHeader(),
                    const SizedBox(height: 21),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const ProfileMenuSection(),
                          const SizedBox(height: 87),
                        ],
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

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth > 440 ? 440.0 : screenWidth;

    return FutureBuilder(
      future: Future.wait([controller.getUserP(), controller.getUser()]),
      builder: (context, asyncSnapshot) {
        return Obx(() {
          if (controller.isLoading.value) {
            return const SizedBox(
              height: 284,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return Container(
            width: maxWidth,
            padding: const EdgeInsets.only(bottom: 16),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                // Orange curved background
                Container(
                  width: maxWidth,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9761E),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(150),
                      bottomRight: Radius.circular(150),
                    ),
                  ),
                ),

                // Profile Image
                Transform.translate(
                  offset: const Offset(0, -50),
                  child: Container(
                    width: 105,
                    height: 105,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white, width: 6),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CustomImageView(
                        imagePath: controller.userAvatar.value.isNotEmpty
                            ? controller.userAvatar.value
                            : 'assets/images/profile_dummy.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // User Info
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: Column(
                    children: [
                      Text(
                        controller.userName.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Category: ${controller.userCategoryName.value}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF787878),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'User ID: ${controller.userId.value} | ${controller.userAddress.value}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF787878),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth > 440 ? 400.0 : screenWidth - 40;
    final controller = Get.find<ProfileController>();

    return SizedBox(
      width: containerWidth,
      child: Column(
        children: [
          // Main menu section
          Container(
            width: containerWidth,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3EA),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFFE0C9)),
            ),
            padding: const EdgeInsets.fromLTRB(21, 19.5, 18, 18.5),
            child: Column(
              children: [
                // ProfileMenuItemWidget(
                //   icon: Icons.account_balance_wallet_outlined,
                //   title: 'Carteira',
                //   hasArrow: true,
                // ),
                const SizedBox(height: 10),
                ProfileMenuItemWidget(
                  icon: Icons.edit,
                  title: 'Meu Hire',
                  hasArrow: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.myHire);
                  },
                ),
                ProfileMenuItemWidget(
                  icon: Icons.edit,
                  title: 'Meu Pedido',
                  hasArrow: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.sellerOrder);
                  },
                ),
                const SizedBox(height: 10),
                ProfileMenuItemWidget(
                  icon: Icons.edit,
                  title: 'Editar Perfil',
                  hasArrow: true,
                  onTap: () {
                    Get.toNamed(AppRoutes.profileEdit);
                  },
                ),
                const SizedBox(height: 10),
                ProfileMenuItemWidget(
                  icon: Icons.person_add_alt_1,
                  title: 'Disponibilidade',
                  subtitle: 'Hoje das 09h às 18h',
                  hasArrow: true,
                  isExpanded: true,
                  onTap: () {
                    Get.toNamed(AppRoutes.availability);
                  },
                ),
                const SizedBox(height: 10),
                ProfileMenuItemWidget(
                  icon: Icons.star_border,
                  title: 'Avaliações',
                  hasArrow: true,
                  onTap: () {
                    Get.toNamed(AppRoutes.profileReview);
                  },
                ),

                const SizedBox(height: 10),

                // ProfileMenuItemWidget(
                //   icon: Icons.language,
                //   title: 'Idioma',
                //   subtitle: 'Português',
                //   hasArrow: true,
                //   isExpanded: true,
                // ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Bottom menu
          Container(
            width: containerWidth,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3EA),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFFE0C9)),
            ),
            padding: const EdgeInsets.fromLTRB(21, 25, 18, 25),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ProfileMenuItemWidget(
                  icon: Icons.help,
                  title: 'centro de ajuda',
                  hasArrow: true,
                  onTap: () {
                    Get.to(
                      () => WebViewScreen(
                        url:
                            'https://tawk.to/chat/694ffc0b8a4fb0197ea55c11/1jdg713ib',
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                ProfileMenuItemWidget(
                  onTap: () {
                    showLogoutDialog(controller);
                  },
                  icon: Icons.logout,
                  title: 'Sair',
                  hasArrow: false,
                  titleFontSize: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool hasArrow;
  final bool isExpanded;
  final double titleFontSize;
  final VoidCallback? onTap;

  const ProfileMenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.hasArrow = false,
    this.isExpanded = false,
    this.titleFontSize = 16,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ✅ ADD TAP HERE
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        child: isExpanded && subtitle != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(icon, size: 24, color: Colors.black),
                          const SizedBox(width: 10),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Josefin Sans',
                              height: 24 / titleFontSize,
                            ),
                          ),
                        ],
                      ),
                      if (hasArrow)
                        Transform.rotate(
                          angle: 1.5708,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 34, top: 5),
                    child: Text(
                      subtitle!,
                      style: const TextStyle(
                        color: Color(0xFF8C8C8C),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Josefin Sans',
                        height: 24 / 14,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 24, color: Colors.black),
                      const SizedBox(width: 10),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                          height: 24 / titleFontSize,
                        ),
                      ),
                    ],
                  ),
                  if (hasArrow)
                    Transform.rotate(
                      angle: 1.5708,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
