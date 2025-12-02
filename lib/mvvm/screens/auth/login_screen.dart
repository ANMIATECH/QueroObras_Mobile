import '../../const/export.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 81),
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 128,
                                  height: 83.9,
                                  child: CustomImageView(
                                    imagePath: "assets/images/logo.png",
                                  ),
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
                                      CustomText.entrar,
                                      style: TextStyle(
                                        color: CustomColor.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Josefin Sans',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 41),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Endereço de e-mail',
                                  style: TextStyle(
                                    color: CustomColor.sprimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Josefin Sans',
                                  ),
                                ),
                                const SizedBox(height: 14),
                                CustomInputField(
                                  controller: lController.emailController,
                                  hintText: 'exemplo@dominio.com',
                                  icon: CustomImageView(
                                    imagePath: "assets/images/input_email.svg",
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 14),
                                const Text(
                                  'Senha',
                                  style: TextStyle(
                                    color:CustomColor.sprimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Josefin Sans',
                                  ),
                                ),
                                const SizedBox(height: 14),
                                CustomInputField(
                                  controller: lController.passwordController,
                                  hintText: '*********',
                                  icon: CustomImageView(
                                    imagePath:
                                        "assets/images/input_password.svg",
                                  ),
                                  isPassword: true,
                                ),
                                const SizedBox(height: 14),

                                // Remember me + Forgot password
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ValueListenableBuilder<bool>(
                                      valueListenable:
                                      lController.rememberMeNotifier,
                                      builder: (context, value, _) {
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                              lController
                                                          .rememberMeNotifier
                                                          .value =
                                                      !value,
                                              child: Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: const Color(
                                                      0xFFB1B1B1,
                                                    ),
                                                    width: 2,
                                                  ),
                                                  color: value
                                                      ? CustomColor.sprimary
                                                      : Colors.transparent,
                                                ),
                                                child: value
                                                    ? const Icon(
                                                        Icons.check,
                                                        size: 10,
                                                        color: CustomColor.white,
                                                      )
                                                    : null,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            const Text(
                                              'Lembrar de mim',
                                              style: TextStyle(
                                                color: Color(0xFFB1B1B1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Josefin Sans',
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(RouteNameV1.forgetPassword); // 👈🏽 Navigate using GetX route name

                                      },
                                      child: const Text(
                                        'Esqueceu a senha?',
                                        style: TextStyle(
                                          color: CustomColor.sprimary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Josefin Sans',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 34),
                            Obx(() {
                              return CustomButton(
                                text: CustomText.entrar,
                                isLoading: lController.isLoading.value,
                                onPressed: lController.isFormValid.value
                                    ? () {
                                  FocusScope.of(context).unfocus();
                                  lController.login();
                                }
                                    : null,
                              );
                            })
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Não tem uma conta? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Josefin Sans',
                              ),
                            ),
                            TextSpan(
                              text: 'Cadastrar-se',
                              style: const TextStyle(
                                color: Color(0xFFF9761E),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Josefin Sans',
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(RouteNameV1.createAccount); // 👈🏽 Navigate using GetX route name
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
