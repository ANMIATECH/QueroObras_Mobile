import '../../../controller/profile_controller.dart';
import '/mvvm/const/export.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(ProfileController());

    return SafeArea(
      child: Scaffold(
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
        body: SingleChildScrollView(
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
                    Container(
                      width: 105,
                      height: 105,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                        child: CustomImageView(
                          imagePath: 'assets/images/profile_dummy.png',
                          width: 105,
                          height: 105,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

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
                          Obx(() {
                            return CustomDropdownField(
                              label: CustomText.role,
                              selectedValue: controllers.selectedRoleName.value,
                              options: controllers.userRoleList
                                  .map((item) => item.name)
                                  .toList(),
                              icon: Icons.verified_user,
                              onChanged: (String selectedName) {
                                final selected = controllers.userRoleList.firstWhere(
                                      (item) => item.name == selectedName,
                                );

                                controllers.selectedRoleId.value = selected.id;
                                controllers.selectedRoleName.value = selected.name;
                              },
                            );
                          }),
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
        ),
      ),
    );
  }
}
