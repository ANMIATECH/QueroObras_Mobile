import '../../const/export.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lController = Get.put(LoginController());

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(48), // Adjust as needed
                _buildLogo(),
                verticalSpace(32),
                _buildTitle(context),
                verticalSpace(24),
                _buildEmailInput(context, lController),
                verticalSpace(16),
                _buildPasswordInput(context, lController),
                verticalSpace(8),
                _buildRememberAndForgot(context),
                verticalSpace(32),
                Obx(
                  () => CustomButton(
                    text: CustomText.enter,
                    isLoading: lController.isLoading.value,
                    onPressed: () async {
                      lController.login();
                    },
                  ),
                ),

                verticalSpace(24),

                _buildSignUpLink(context),
                verticalSpace(24),
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
      CustomText.enter,
      style: CustomFontStyle.primaryTitle(context).copyWith(fontSize: 18),
    );
  }

  Widget _buildEmailInput(BuildContext context, LoginController lController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CustomText.emailAddress,
          style: CustomFontStyle.body(context).copyWith(
            fontWeight: FontWeight.w700,
            color: CustomColor.primaryBlue,
          ),
        ),
        verticalSpace(8),
        CustomInputFieldLive(
          hintText: 'exemplo@dominio.com',
          controller: lController.emailController,
          isPassword: false,
          obscureText: false,

          prefixWidget: const Icon(
            Icons.email_outlined,
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
        Text(
          CustomText.password,
          style: CustomFontStyle.body(context).copyWith(
            fontWeight: FontWeight.w700,
            color: CustomColor.primaryBlue,
          ),
        ),
        verticalSpace(8),
        CustomInputFieldLive(
          hintText: '*********',
          controller: lController.passwordController,

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

  Widget _buildRememberAndForgot(BuildContext context) {
    final lController = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Placeholder for Checkbox
        ValueListenableBuilder<bool>(
          valueListenable: lController.rememberMeNotifier,
          builder: (context, value, child) {
            return InkWell(
              onTap: () => lController.toggleRememberMe(),
              child: Row(
                children: [
                  Checkbox(
                    value: value,
                    onChanged: (val) => lController.toggleRememberMe(),
                  ),

                ],
              ),
            );
          },
        ),
            Text(
              CustomText.rememberMe,
              style: CustomFontStyle.body(
                context,
              ).copyWith(fontSize: 14, color: CustomColor.textBlack),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.forgetPassword);
          },
          child: Text(
            CustomText.forgotPassword,
            style: CustomFontStyle.body(context).copyWith(
              fontWeight: FontWeight.w700,
              color: CustomColor.primaryBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: CustomFontStyle.body(context).copyWith(fontSize: 14),
        children: [
          TextSpan(
            text: CustomText.dontHaveAccount,
            style: CustomFontStyle.body(context).copyWith(
              color: CustomColor.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          WidgetSpan(child: SizedBox(width: 4)),
          TextSpan(
            text: CustomText.signUp,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).pushNamed(AppRoutes.registration);
              },
            style: CustomFontStyle.body(context).copyWith(
              color: CustomColor.primary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            // Add recognizer for navigation here if needed
          ),
        ],
      ),
    );
  }
}

// A custom input field widget to match the design style
