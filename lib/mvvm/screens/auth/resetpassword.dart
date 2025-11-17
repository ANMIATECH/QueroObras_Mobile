import '../../const/export.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo
                    Center(
                      child: SizedBox(
                        width: 128,
                        height: 83.9,
                        child: CustomImageView(imagePath: "assets/images/logo.png"),
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Title
                    const Text(
                      'Redefinir Senha',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Subtitle
                    const Text(
                      'Escreva seu endereço de e-mail\nabaixo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Email input section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Endereço de e-mail',
                          style: TextStyle(
                            color: Color(0xFF16577F),
                            fontSize: 15,
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputField(
                          controller: controller.resetEmailController,
                          hintText: 'exemplo@dominio.com',
                          icon: CustomImageView(
                            imagePath: "assets/images/input_email.svg",
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Fixed bottom button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() {
                return CustomButton(
                  text: CustomText.entrar,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.isEmailFormValid.value
                      ? () {
                    FocusScope.of(context).unfocus();
                    final email = controller.resetEmailController.text.trim();
                    if (email.isNotEmpty) {
                      controller.forgetPassword(); // triggers OTP
                      // Navigate to OTP screen with email
                    } else {
                      SnackbarUtil.showSnackbar(
                        title: "Invalid Email",
                        message: "Please enter your email.",
                        type: SnackbarType.error,
                      );
                    }
                  }
                      : null,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
