import '/mvvm/const/export.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
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
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth > 440 ? 440.0 : screenWidth;

    return SizedBox(
      width: maxWidth,
      height: 284,
      child: Stack(
        children: [
          Positioned(
            left: -2,
            top: 0,
            child: Container(
              width: maxWidth + 4,
              height: 151,
              decoration: const BoxDecoration(
                color: Color(0xFFF9761E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                  bottomRight: Radius.circular(150),
                ),
              ),
            ),
          ),

          // Profile image
          Positioned(
            left: (maxWidth - 105) / 2,
            top: 92,
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
                  imagePath: 'assets/images/profile_dummy.png',
                  width: 105,
                  height: 105,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // User info translated
          Positioned(
            left: (maxWidth - 241) / 2,
            top: 205,
            child: SizedBox(
              height: 79,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nome do Usuário',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'SF Pro',
                      height: 24 / 20,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Eletricista',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF787878),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'SF Pro',
                      height: 24 / 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ID do Usuário: 2203494 | Turquia, Istambul',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF787878),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'SF Pro',
                      height: 24 / 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth > 440 ? 400.0 : screenWidth - 40;

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
                ProfileMenuItemWidget(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Carteira',
                  hasArrow: true,
                ),
                const SizedBox(height: 10),
                ProfileMenuItemWidget(
                  icon: Icons.edit,
                  title: 'Editar Perfil',
                  hasArrow: true,
                  onTap: (){
                    // Get.toNamed(RouteNameV1.serviceProviderAvailability, );

                  },

                ),
                const SizedBox(height: 10),
                ProfileMenuItemWidget(
                  icon: Icons.person_add_alt_1,
                  title: 'Disponibilidade',
                  subtitle: 'Hoje das 09h às 18h',
                  hasArrow: true,
                  isExpanded: true,
                  onTap: (){
                    // Get.toNamed(RouteNameV1.profileEdit, );

                  },

                ),
                const SizedBox(height: 10),
                ProfileMenuItemWidget(
                  icon: Icons.star_border,
                  title: 'Avaliações',
                  hasArrow: true,
                  onTap: (){
                    // Get.toNamed(RouteNameV1.serviceProviderReview, );

                  },

                ),
                const SizedBox(height: 10),
                ProfileMenuItemWidget(
                  icon: Icons.language,
                  title: 'Idioma',
                  subtitle: 'Português',
                  hasArrow: true,
                  isExpanded: true,
                ),
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
                ProfileMenuItemWidget(
                  icon: Icons.delete,
                  title: 'Excluir Conta',
                  hasArrow: false,
                  titleFontSize: 14,
                ),
                const SizedBox(height: 10),
                ProfileMenuItemWidget(
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
    return InkWell(
      onTap: onTap, // ✅ ADD TAP HERE
      borderRadius: BorderRadius.circular(10),
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

