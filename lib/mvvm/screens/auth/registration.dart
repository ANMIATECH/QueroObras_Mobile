import '../../const/export.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 81),

                  // LOGO & TITLE
                  SizedBox(
                    width: 128,
                    height: 83.9,
                    child: CustomImageView(imagePath: "assets/images/logo.png"),
                  ),
                  const SizedBox(height: 21),
                  Container(
                    width: 187,
                    height: 47,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23.37),
                      color: const Color(0x0016577F),
                    ),
                    child: const Center(
                      child: Text(
                        CustomText.cadastrar,
                        style: TextStyle(
                          color: CustomColor.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 41),

                  // =====================
                  // TIPO DE CADASTRO
                  // =====================
                  Obx(() => CustomDropdown(
                    label: 'Tipo de cadastro',
                    selectedValue: controllers.selectedUserStatus.value,
                    options: controllers.userStatusOptions,
                    customIcon: CustomImageView(
                      imagePath: "assets/images/input_status.svg",
                    ),
                    onChanged: (String newValue) {
                      controllers.setUserStatus(newValue); // sync both selectedUserStatus & selectedDocumentType
                    },
                  )),
                  const SizedBox(height: 14),

                  Obx(() {
                    final doc = controllers.selectedDocumentType.value;

                    if (doc == 'CNPJ') {
                      // =========================
                      // CNPJ Fields
                      // =========================
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nome',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.fullNameController,
                            hintText: 'Nome completo',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          const Text('Razão Social',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.companyNameController,
                            hintText: 'Razão Social',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          const Text('Nome do Representante Legal',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.legalRepNameController,
                            hintText: 'Representante Legal',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          const Text('Nome Fantasia',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.tradeNameController,
                            hintText: 'Nome Fantasia',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          const Text('Endereço de e-mail',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.emailController,
                            hintText: 'exemplo@dominio.com',
                            icon: CustomImageView(imagePath: "assets/images/input_email.svg"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 14),

                          const Text('Nome da Mãe',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.motherNameController,
                            hintText: 'Nome da mãe',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          const Text('Data de nascimento',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.birthDateController,
                            hintText: 'dd/mm/aaaa',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          Obx(() => CustomDropdown(
                            label: 'Função',
                            selectedValue: controllers.selectedRoleStatus.value == 0
                                ? null
                                : controllers.userRoleList
                                .firstWhere(
                                  (e) => e.id == controllers.selectedRoleStatus.value,
                              orElse: () => CategoryModel(id: 0, name: ""),
                            )
                                .name,
                            options:
                            controllers.userRoleList.map((item) => item.name).toList(),
                            customIcon: CustomImageView(
                              imagePath: "assets/images/input_status.svg",
                            ),
                            onChanged: (String selectedName) {
                              final selected = controllers.userRoleList.firstWhere(
                                    (item) => item.name == selectedName,
                                orElse: () => CategoryModel(id: 0, name: ""),
                              );
                              controllers.selectedRoleStatus.value = selected.id;
                            },
                          )),
                          const SizedBox(height: 14),

                          const Text('CNPJ',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.cnpjController,
                            hintText: 'CNPJ',
                            icon: CustomImageView(imagePath: "assets/images/input_ced.svg"),
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 14),
                          const Text('CEP',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.cepController,
                            hintText: 'CEP',
                            icon: CustomImageView(imagePath: "assets/images/input_ced.svg"),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 14),

                          const Text('Inscrição Estadual',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.stateRegistrationController,
                            hintText: 'Inscrição Estadual',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          const Text('Endereço',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.addressController,
                            hintText: 'Endereço',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          const Text('Número',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.phoneNumberController,
                            hintText: 'Número',
                            icon: CustomImageView(imagePath: "assets/images/input_number.svg"),
                            keyboardType: TextInputType.number,

                          ),
                          const SizedBox(height: 14),

                          const Text('Senha',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.passwordController,
                            hintText: 'Senha',
                            icon: CustomImageView(imagePath: "assets/images/input_password.svg"),
                            isPassword: true,
                          ),
                          const SizedBox(height: 14),

                          const Text('Confirmar senha',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.confirmPasswordController,
                            hintText: 'Confirmar senha',
                            icon: CustomImageView(imagePath: "assets/images/input_password.svg"),
                            isPassword: true,
                          ),
                        ],
                      );
                    } else if (doc == 'CPF') {
                      // =========================
                      // CPF Fields
                      // =========================
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nome',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.fullNameController,
                            hintText: 'Nome completo',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          const Text('Nome da Empresa',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.companyNameController,
                            hintText: 'Nome da Empresa',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          const Text('Nome da Mãe',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.motherNameController,
                            hintText: 'Nome da mãe',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          const Text('E-mail Comercial',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.emailController,
                            hintText: 'exemplo@dominio.com',
                            icon: CustomImageView(imagePath: "assets/images/input_email.svg"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 14),

                          const Text('Endereço',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.addressController,
                            hintText: 'Endereço',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          const Text('Data de nascimento',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.birthDateController,
                            hintText: 'dd/mm/aaaa',
                            icon: CustomImageView(imagePath: "assets/images/input_name.svg"),
                          ),
                          const SizedBox(height: 14),

                          Obx(() => CustomDropdown(
                            label: 'Função',
                            selectedValue: controllers.selectedRoleStatus.value == 0
                                ? null
                                : controllers.userRoleList
                                .firstWhere(
                                  (e) => e.id == controllers.selectedRoleStatus.value,
                              orElse: () => CategoryModel(id: 0, name: ""),
                            )
                                .name,
                            options:
                            controllers.userRoleList.map((item) => item.name).toList(),
                            customIcon: CustomImageView(
                              imagePath: "assets/images/input_status.svg",
                            ),
                            onChanged: (String selectedName) {
                              final selected = controllers.userRoleList.firstWhere(
                                    (item) => item.name == selectedName,
                                orElse: () => CategoryModel(id: 0, name: ""),
                              );
                              controllers.selectedRoleStatus.value = selected.id;
                            },
                          )),
                          const SizedBox(height: 14),

                          const Text('CPF',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.cpfController,
                            hintText: 'CPF',
                            icon: CustomImageView(imagePath: "assets/images/input_ced.svg"),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 14),

                          const Text('CEP',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.cepController,
                            hintText: 'CEP',
                            icon: CustomImageView(imagePath: "assets/images/input_ced.svg"),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 14),

                          const Text('Número',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.phoneNumberController,
                            hintText: 'Número',
                            icon: CustomImageView(imagePath: "assets/images/input_number.svg"),
                            keyboardType: TextInputType.number,

                          ),
                          const SizedBox(height: 14),

                          const Text('Senha',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.passwordController,
                            hintText: 'Senha',
                            icon: CustomImageView(imagePath: "assets/images/input_password.svg"),
                            isPassword: true,
                          ),
                          const SizedBox(height: 14),

                          const Text('Confirmar senha',
                              style: TextStyle(
                                color: CustomColor.sprimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              )),
                          const SizedBox(height: 14),
                          CustomInputField(
                            controller: controllers.confirmPasswordController,
                            hintText: 'Confirmar senha',
                            icon: CustomImageView(imagePath: "assets/images/input_password.svg"),
                            isPassword: true,
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  }),


                  const SizedBox(height: 34),
                  Obx(
                        () => CustomButton(
                      text: CustomText.entrar,
                      isLoading: controllers.isLoading.value,
                      onPressed: () async {
                        await controllers.signUp();
                      },
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final List<String> options;
  final Function(String) onChanged;
  final IconData? icon;
  final Widget? customIcon;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
    this.icon,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF16577F),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF16577F),
            borderRadius: BorderRadius.circular(217.391),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            onChanged: (String? newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
            style: const TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            dropdownColor: const Color(0xFF16577F),
            decoration: InputDecoration(
              prefixIcon: customIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: customIcon,
                    )
                  : icon != null
                  ? Icon(icon, color: Colors.white, size: 24)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(217.391),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 18,
              ),
              filled: true,
              fillColor: const Color(0xFF16577F),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 24,
            ),
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class InputDesign extends StatelessWidget {
  final VoidCallback? onCpfTap;
  final VoidCallback? onCnpjTap;

  const InputDesign({super.key, this.onCpfTap, this.onCnpjTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 640;
    final isMediumScreen = screenWidth <= 991;

    double containerWidth = 400;
    double containerPadding = 40;
    double sidePadding = 38;
    double innerWidth = 324;
    double gap = 27;
    double headerGap = 14;
    double fontSize = 15;

    if (isSmallScreen) {
      containerWidth = screenWidth * 0.95;
      containerPadding = 20;
      sidePadding = 15;
      gap = 20;
      headerGap = 10;
      fontSize = 14;
    } else if (isMediumScreen) {
      containerWidth = screenWidth * 0.9;
      if (containerWidth > 400) containerWidth = 400;
      containerPadding = 30;
      sidePadding = 20;
    }

    if (isMediumScreen) {
      innerWidth = containerWidth - (sidePadding * 2);
    }

    return Center(
      child: Container(
        height: 413,
        width: containerWidth,
        constraints: const BoxConstraints(minHeight: 413),
        padding: EdgeInsets.symmetric(
          vertical: containerPadding,
          horizontal: sidePadding,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7F7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: innerWidth,
              child: Column(
                children: [
                  // Header section with icon and text
                  Column(
                    children: [
                      // Icon
                      CustomImageView(
                        imagePath: "assets/images/usertype_logo.svg",
                      ),

                      SizedBox(height: headerGap),
                      // Description text
                      SizedBox(
                        width: isMediumScreen ? innerWidth : 260,
                        child: Text(
                          'Use uma das opções para continuar sua configuração.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: fontSize,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: gap),
                  // Buttons section
                  Column(
                    children: [
                      // CPF Button
                      GestureDetector(
                        onTap: onCpfTap,
                        child: Container(
                          width: innerWidth,
                          padding: const EdgeInsets.symmetric(vertical: 20.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF16577F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImageView(
                                imagePath: "assets/images/cpfuser.svg",
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'CPF',
                                style: TextStyle(
                                  fontFamily: 'Josefin Sans',
                                  fontSize: isSmallScreen ? 14 : 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // CNPJ Button
                      GestureDetector(
                        onTap: onCnpjTap,
                        child: Container(
                          width: innerWidth,
                          padding: const EdgeInsets.symmetric(vertical: 20.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF16577F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImageView(
                                imagePath: "assets/images/cnpjuser.svg",
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'CNPJ',
                                style: TextStyle(
                                  fontFamily: 'Josefin Sans',
                                  fontSize: isSmallScreen ? 14 : 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
