import '../../const/export.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(LoginController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CustomColor.background,
      body: GestureDetector(
        // Tap outside TextField to close keyboard
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                verticalSpace(48), // Adjust as needed
                _buildLogo(),
                verticalSpace(32),
                _buildTitle(context),
                verticalSpace(24),

                Obx(
                  () => CustomDropdownField(
                    label: CustomText.registrationType,
                    selectedValue: controllers.selectedUserStatus.value,
                    options: controllers.userStatusOptions,
                    customIcon: const Icon(
                      Icons.verified_user,
                      color: CustomColor.hintText,
                    ),

                    onChanged: (String newValue) {
                      controllers.setUserStatus(
                        newValue,
                      ); // sync both selectedUserStatus & selectedDocumentType
                    },
                  ),
                ),
                const SizedBox(height: 14),

                Obx(() {
                  final doc = controllers.selectedDocumentType.value;

                  if (doc == CustomText.cnpj) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          CustomText.name,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.fullNameController,
                          hintText: CustomText.fullName,
                          prefixWidget: CustomImageView(
                            imagePath: "assets/images/input_name.svg",
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.cooperateName,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.companyNameController,
                          hintText: CustomText.cooperateName,
                          prefixWidget: CustomImageView(
                            imagePath: "assets/images/input_name.svg",
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.legalRepName,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.legalRepNameController,
                          hintText: CustomText.hintLegalRep,
                          prefixWidget: CustomImageView(
                            imagePath: "assets/images/input_name.svg",
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.tradeName,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.tradeNameController,
                          hintText: CustomText.tradeName,
                          prefixWidget: CustomImageView(
                            imagePath: "assets/images/input_name.svg",
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.emailAddress,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
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
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.motherName,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.motherNameController,
                          hintText: CustomText.motherName,
                          prefixWidget: const Icon(
                            Icons.person_outline_outlined,
                            color: CustomColor.hintText,
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.birthDate,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.birthDateController,
                          hintText: CustomText.hintBirthDate,
                          prefixWidget: const Icon(
                            Icons.calendar_today_outlined,
                            color: CustomColor.hintText,
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                        const SizedBox(height: 14),

                        Obx(
                          () => CustomDropdownField(
                            label: CustomText.role,
                            selectedValue:
                                controllers.selectedRoleStatus.value == 0
                                ? null
                                : controllers.userRoleList
                                      .firstWhere(
                                        (e) =>
                                            e.id ==
                                            controllers
                                                .selectedRoleStatus
                                                .value,
                                        orElse: () =>
                                            CategoryModel(id: 0, name: ""),
                                      )
                                      .name,
                            options: controllers.userRoleList
                                .map((item) => item.name)
                                .toList(),
                            icon: Icons.verified_user,

                            onChanged: (String selectedName) {
                              final selected = controllers.userRoleList
                                  .firstWhere(
                                    (item) => item.name == selectedName,
                                    orElse: () =>
                                        CategoryModel(id: 0, name: ""),
                                  );
                              controllers.selectedRoleStatus.value =
                                  selected.id;
                            },
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.cnpj,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.cnpjController,
                          hintText: CustomText.cnpj,
                          prefixWidget: const Icon(
                            Icons.person_outline_outlined,
                            color: CustomColor.hintText,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          CustomText.cep,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.cepController,
                          hintText: CustomText.cep,
                          prefixWidget: const Icon(
                            Icons.person_outline_outlined,
                            color: CustomColor.hintText,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.stateRegistration,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.stateRegistrationController,
                          hintText: CustomText.stateRegistration,
                          prefixWidget: const Icon(
                            Icons.person_outline_outlined,
                            color: CustomColor.hintText,
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.address,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.addressController,
                          hintText: CustomText.address,
                          prefixWidget: const Icon(
                            Icons.location_on_outlined,
                            color: CustomColor.hintText,
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.houseNumber,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.phoneNumberController,
                          hintText: CustomText.houseNumber,
                          prefixWidget: const Icon(
                            Icons.phone,
                            color: CustomColor.hintText,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.password,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.passwordController,
                          hintText: CustomText.password,
                          prefixWidget: const Icon(
                            Icons.lock_outline,
                            color: CustomColor.hintText,
                          ),
                          isPassword: true,
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.confirmPassword,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.confirmPasswordController,
                          hintText: CustomText.confirmPassword,
                          prefixWidget: const Icon(
                            Icons.lock_outline,
                            color: CustomColor.hintText,
                          ),
                          isPassword: true,
                        ),
                      ],
                    );
                  } else if (doc == CustomText.cpf) {
                    // =========================
                    // CPF Fields
                    // =========================
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          CustomText.name,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.fullNameController,
                          hintText: CustomText.fullName,
                          prefixWidget: CustomImageView(
                            imagePath: "assets/images/input_name.svg",
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.companyName,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.companyNameController,
                          hintText: CustomText.companyName,
                          prefixWidget: CustomImageView(
                            imagePath: "assets/images/input_name.svg",
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.motherName,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.motherNameController,
                          hintText: CustomText.motherName,
                          prefixWidget: CustomImageView(
                            imagePath: "assets/images/input_name.svg",
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.businessEmail,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
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
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.address,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.addressController,
                          hintText: CustomText.address,
                          prefixWidget: const Icon(
                            Icons.location_on_outlined,
                            color: CustomColor.hintText,
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.birthDate,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.birthDateController,
                          hintText: CustomText.hintBirthDate,
                          prefixWidget: const Icon(
                            Icons.calendar_today_outlined,
                            color: CustomColor.hintText,
                          ),
                        ),
                        const SizedBox(height: 14),

                        Obx(
                          () => CustomDropdownField(
                            label: CustomText.role,
                            selectedValue:
                                controllers.selectedRoleStatus.value == 0
                                ? null
                                : controllers.userRoleList
                                      .firstWhere(
                                        (e) =>
                                            e.id ==
                                            controllers
                                                .selectedRoleStatus
                                                .value,
                                        orElse: () =>
                                            CategoryModel(id: 0, name: ""),
                                      )
                                      .name,
                            options: controllers.userRoleList
                                .map((item) => item.name)
                                .toList(),
                            customIcon: const Icon(
                              Icons.verified_user,
                              color: CustomColor.hintText,
                            ),

                            onChanged: (String selectedName) {
                              final selected = controllers.userRoleList
                                  .firstWhere(
                                    (item) => item.name == selectedName,
                                    orElse: () =>
                                        CategoryModel(id: 0, name: ""),
                                  );
                              controllers.selectedRoleStatus.value =
                                  selected.id;
                            },
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.cpf,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.cpfController,
                          hintText: CustomText.cpf,
                          prefixWidget: const Icon(
                            Icons.person_outline_outlined,
                            color: CustomColor.hintText,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.cep,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.cepController,
                          hintText: CustomText.cep,
                          prefixWidget: const Icon(
                            Icons.person_outline_outlined,
                            color: CustomColor.hintText,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.houseNumber,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.phoneNumberController,
                          hintText: CustomText.houseNumber,
                          prefixWidget: const Icon(
                            Icons.phone,
                            color: CustomColor.hintText,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.password,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          isPhoneNumber: false,
                          obscureText: false,

                          controller: controllers.passwordController,
                          hintText: CustomText.password,
                          prefixWidget: const Icon(
                            Icons.lock_outline,
                            color: CustomColor.hintText,
                          ),
                          isPassword: true,
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          CustomText.confirmPassword,
                          style: TextStyle(
                            color: CustomColor.sprimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          controller: controllers.confirmPasswordController,
                          isPhoneNumber: false,
                          obscureText: false,
                          hintText: CustomText.confirmPassword,
                          prefixWidget: const Icon(
                            Icons.lock_outline,
                            color: CustomColor.hintText,
                          ),
                          isPassword: true,
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                }),

                const SizedBox(height: 34),
                Obx(() {
                  return AgreeInputDesign(
                    value: controllers.agree.value,
                    onChanged: (v) => controllers.agree.value = v,
                  );
                }),
                const SizedBox(height: 34),
                Obx(
                  () => CustomButton(
                    text: CustomText.entrar,
                    isLoading: controllers.isLoading.value,
                    isActive: controllers
                        .agree
                        .value, // 🔥 button only active when checked
                    onPressed: controllers.agree.value
                        ? () async => await controllers.signUp()
                        : null, // 🔒 prevents click
                  ),
                ),

                const SizedBox(height: 20),
                _buildSignUpLink(context),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    // Assuming the logo is a local asset
    return Image.asset(
      CustomImage.welcomeLogo,
      height: 60, // Adjust size based on image
      errorBuilder: (context, error, stackTrace) =>
          _buildLogoPlaceholder(context), // Fallback
    );
  }

  Widget _buildLogoPlaceholder(BuildContext context) {
    // Fallback widget if logo asset fails to load
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: CustomColor.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'QO',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: CustomColor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      CustomText.signUp,
      style: CustomFontStyle.primaryTitle(context).copyWith(fontSize: 18),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: CustomFontStyle.body(context).copyWith(fontSize: 14),
        children: [
          TextSpan(
            text: CustomText.doHaveAccount,
            style: CustomFontStyle.body(context).copyWith(
              color: CustomColor.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          WidgetSpan(child: SizedBox(width: 4)),
          TextSpan(
            text: CustomText.entrar,
            style: CustomFontStyle.body(context).copyWith(
              color: CustomColor.primary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).pushNamed(AppRoutes.login);
              },
          ),
        ],
      ),
    );
  }
}

class AgreeInputDesign extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AgreeInputDesign({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // CUSTOM CHECKBOX BOX
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xFFB1B1B1), width: 2),
              color: value ? const Color(0xFFF9761E) : Colors.transparent,
            ),
            child: value
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 10),

          // TEXT
          Expanded(
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF828282),
                  height: 1.0,
                ),
                children: [
                  const TextSpan(text: 'Accept '),

                  // TERMS LINK
                  TextSpan(
                    text: 'terms',
                    style: const TextStyle(color: Color(0xFFF9761E)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Terms tapped");
                        // TODO: Navigate to Terms screen
                      },
                  ),

                  const TextSpan(text: ' and '),

                  // CONDITIONS LINK
                  TextSpan(
                    text: 'condition',
                    style: const TextStyle(color: Color(0xFFF9761E)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Condition tapped");
                        // TODO: Navigate to Condition screen
                      },
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
