import '../../../controller/profile_controller.dart';
import '/mvvm/const/export.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: const Text(
          'Editar Perfil', // 🇧🇷
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            fontFamily: 'Josefin Sans',
            height: 0.75,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: controllers.getServiceCategory(),
          builder: (context, asyncSnapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [

                // Information text
                Container(
                  margin: const EdgeInsets.only(top: 26),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Como prestador de serviços, para permitir alterações nesta página será necessário autorização do administrador por motivos de segurança.',
                    style: TextStyle(
                      color: const Color(0xFF969696),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Josefin Sans',
                      height: 24 / 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Profile section with image and form fields
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 398),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile image
                      ProfilePics(),

                      const SizedBox(width: 21),

                      // Form fields
                      Expanded(
                        child: Column(
                          children: [
                            // Username field
                            CustomInputFieldLive(
                              isPhoneNumber: false,
                              obscureText: false,

                              controller: controllers.usernameController,
                              hintText: "Nome de Usuário",
                              prefixWidget: const Icon(
                                Icons.person_outline_outlined,
                                color: CustomColor.hintText,
                              ),
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(height: 14),
                            CustomInputFieldLive(
                              isPhoneNumber: false,
                              obscureText: false,

                              controller: controllers.emailController,
                              hintText: CustomText.hintEmail,
                              prefixWidget: const Icon(
                                Icons.email_outlined,
                                color: CustomColor.hintText,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 11),
                            CustomInputFieldLive(
                              isPhoneNumber: false,
                              obscureText: false,

                              controller: controllers.phoneController,
                              hintText: CustomText.houseNumber,
                              prefixWidget: const Icon(
                                Icons.phone,
                                color: CustomColor.hintText,
                              ),
                              keyboardType: TextInputType.phone,
                            ),

                            const SizedBox(height: 11),

                            // Service provider field
                            Obx(
                                  () => GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) => MultiSelectDropdownField(
                                      label: CustomText.role,
                                      roles: controllers.userRoleList
                                          .map(
                                            (r) => Role(
                                          id: r.id,
                                          name: r.name,
                                          isSelected: controllers
                                              .selectedRolesNames
                                              .contains(r.name),
                                        ),
                                      )
                                          .toList(),
                                      onSelectionChanged: (selectedRoles) {
                                        controllers.selectedRolesNames.value =
                                            selectedRoles
                                                .map((r) => r.name)
                                                .toList();
                                        controllers.selectedRoleStatusIds.value =
                                            selectedRoles
                                                .map((r) => r.id)
                                                .toList();
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.verified_user),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          controllers.selectedRolesNames.isEmpty
                                              ? 'Selecionar Função'
                                              : controllers.selectedRolesNames
                                              .join(', '),
                                          style: TextStyle(
                                            color: CustomColor.hintText,
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    return CustomButton(
                      text: "Atualizar Informações",
                      isLoading: controllers.isLoading.value, // ✅ built-in loader
                      isActive: !controllers.isLoading.value, // ✅ disables button
                      onPressed: () {
                        controllers.updateProfile();
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class ProfilePics extends StatelessWidget {
  const ProfilePics({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Obx(() {
      return Container(
        width: 105,
        height: 105,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 3)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: CustomImageView(
            imagePath: controller.userAvatar.value.isNotEmpty
                ? controller.userAvatar.value
                : 'assets/images/profile_dummy.png',
            width: 105,
            height: 105,
            fit: BoxFit.cover,
          ),
        ),
      );
    });
  }
}
