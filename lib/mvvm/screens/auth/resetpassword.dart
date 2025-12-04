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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalSpace(48), // Adjust as needed
                    _buildLogo(),
                    const SizedBox(height: 60),

                    // Title
                    const Text(
                      CustomText.forgotPassword,
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
                      CustomText.forgotPasswordSub,
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
                          CustomText.emailAddress,
                          style: TextStyle(
                            color: Color(0xFF16577F),
                            fontSize: 15,
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 14),
                        CustomInputFieldLive(
                          controller: controller.resetEmailController,
                          hintText: CustomText.hintEmail,
                          isPassword: false,
                          prefixWidget: const Icon(
                            Icons.email_outlined,
                            color: CustomColor.hintText,
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
                          final email = controller.resetEmailController.text
                              .trim();
                          if (email.isNotEmpty) {
                            controller.forgetPassword(context);
                          } else {
                            SnackbarUtil.showSnackbar(
                              title: "E-mail inválido",
                              message: "Por favor, insira o seu e-mail.",
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
