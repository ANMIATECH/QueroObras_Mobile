import '../../const/export.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.maxWidth > constraints.maxHeight;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: isLandscape ? 100 : 128,
                          height: isLandscape ? 65 : 83.9,
                          child: CustomImageView(imagePath: "assets/images/logo.png"),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'SENHA OTP',
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
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF6F3F3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.05),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: TextField(
                                    controller: controller.otpControllers[index],
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
                                        ? const Color(0xFF16577F)
                                        : const Color(0xFFF9761E),
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
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Obx(() => CustomButton(
                    text: CustomText.entrar,
                    isLoading: controller.isButtonLoading.value,
                    onPressed: () async {
                      controller.isButtonLoading.value = true;
                      // Combine email + OTP verification
                      final otp = controller.otpControllers.map((c) => c.text).join();
                      await controller.verifyForgetPasswordOtp(otp, email: email);
                      controller.isButtonLoading.value = false;
                    },
                  )),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
