import '../../const/export.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();

    // 1. Retrieve the arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;

    // 2. Safely cast the arguments to the expected Map type.
    // Use a null-aware operator (`??`) to provide an empty Map if arguments are null or the wrong type.
    final Map<String, dynamic> data = arguments is Map<String, dynamic>
        ? arguments
        : {};

    // 3. Access the values by key, providing a default value if the key is missing.
    final String email = data["email"] as String? ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // final isLandscape = constraints.maxWidth > constraints.maxHeight;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        verticalSpace(48), // Adjust as needed
                        _buildLogo(),
                        const SizedBox(height: 40),
                        const Text(
                          CustomText.otpPin,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Josefin Sans',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Enviamos um e-mail para $email,\nescreva o código abaixo.',
                          style: const TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Josefin Sans',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),

                        // OTP Inputs
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            return Flexible(
                              child: Container(
                                height: 55,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF6F3F3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: TextField(
                                    controller:
                                        controller.otpControllers[index],
                                    focusNode: controller.focusNodes[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      counterText: '',
                                    ),
                                    onChanged: (value) =>
                                        controller.onOtpChanged(value, index),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 30),

                        // Resend Code
                        Obx(() {
                          final minutes =
                              (controller.remainingSeconds.value ~/ 60)
                                  .toString()
                                  .padLeft(2, '0');
                          final seconds =
                              (controller.remainingSeconds.value % 60)
                                  .toString()
                                  .padLeft(2, '0');

                          return GestureDetector(
                            onTap: controller.canResend.value
                                ? () => controller.resendCode(email: email)
                                : null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  controller.canResend.value
                                      ? 'Reenviar código'
                                      : 'Reenviar código $minutes:$seconds',
                                  style: TextStyle(
                                    color: controller.canResend.value
                                        ? CustomColor.primaryBlue
                                        : CustomColor.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Josefin Sans',
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 24,
                  ),
                  child: Obx(
                    () => CustomButton(
                      text: CustomText.entrar,
                      isLoading: controller.isButtonLoading.value,
                      onPressed: () async {
                        controller.isButtonLoading.value = true;
                        final otp = controller.otpControllers
                            .map((c) => c.text)
                            .join();
                        await controller.verifyForgetPasswordOtp(
                          otp,
                          context,
                          email: email,
                        );
                        controller.isButtonLoading.value = false;
                      },
                    ),
                  ),
                ),
              ],
            );
          },
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
