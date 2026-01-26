import '../../const/export.dart';

class ChangePasswordWord extends StatelessWidget {
  const ChangePasswordWord({super.key});

  @override
  Widget build(BuildContext context) {
    final lController = Get.put(LoginController());
    // 1. Retrieve the arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;

    // 2. Safely cast the arguments to the expected Map type.
    // Use a null-aware operator (`??`) to provide an empty Map if arguments are null or the wrong type.
    final Map<String, dynamic> data = arguments is Map<String, dynamic>
        ? arguments
        : {};

    // 3. Access the values by key, providing a default value if the key is missing.
    final String email = data["email"] as String? ?? "";
    final String otp = data["otp"] as String? ?? "";

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CustomColor.background,
        body: GestureDetector(
          // Tap outside TextField to close keyboard
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(48), // Adjust as needed
                _buildLogo(),
                verticalSpace(32),
                _buildTitle(context),
                _buildTitleSub(context),
                verticalSpace(24),
                _buildEmailInput(context, lController),
                verticalSpace(16),
                _buildPasswordInput(context, lController),
          
                verticalSpace(32),
                Obx(
                  () => CustomButton(
                    text: CustomText.update,
                    isLoading: lController.isResetPasswordLoading.value,
                    onPressed: () async {
                      await lController.resetPassword(
                        email: email,
                        otp: otp,
                        context: context,
                      );
                    },
                  ),
                ),
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
      CustomText.resetPassword,
      style: CustomFontStyle.primaryTitle(
        context,
      ).copyWith(fontSize: 20, color: CustomColor.black),
    );
  }

  Widget _buildTitleSub(BuildContext context) {
    return Text(
      CustomText.changeUrPassword,
      style: CustomFontStyle.primaryTitle(context).copyWith(
        fontSize: 16,
        color: CustomColor.textHash,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context, LoginController lController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputFieldLive(
          hintText: CustomText.newPassword,
          controller: lController.setPassword,

          prefixWidget: const Icon(
            Icons.lock_outline,
            color: CustomColor.hintText,
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildPasswordInput(
    BuildContext context,
    LoginController lController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputFieldLive(
          hintText: CustomText.confirmPassword,
          controller: lController.setComfirmPassword,

          prefixWidget: const Icon(
            Icons.lock_outline,
            color: CustomColor.hintText,
          ),
          keyboardType: TextInputType.text,
          isPassword: true,
        ),
      ],
    );
  }
}

// A custom input field widget to match the design style
