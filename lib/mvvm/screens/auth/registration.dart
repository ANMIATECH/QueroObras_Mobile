import '../../const/export.dart';

const List<String> userRoles = ['Client', 'Service Provider', 'Contractor'];

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: Removed all references to 'ref', 'controller', and 'state'
    // as per the requirement to omit the controller pattern.

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
                // 1. User Role Dropdown
                verticalSpace(24),

                CustomDropdownField(
                  hintText: 'Choose User Role',
                  prefixIcon: const Icon(Icons.person_outline),
                  options: userRoles,
                  onOptionSelected: (String role) {
                    // 🚨 Action to handle the selected role (e.g., update a provider/controller)
                  },
                ),
                verticalSpace(24),
                _buildEmailInput(context),

                verticalSpace(20),
                verticalSpace(16),
                _buildPasswordInput(context),
                verticalSpace(32),
                PrimaryButton(
                  bgActive: CustomColor.primary,
                  textColor: CustomColor.white,
                  text: CustomText.enter,
                  onPressed: () {
                    // Navigator.of(context).pushNamed(AppRoutes.welcome);
                  },
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
      CustomText.signUp,
      style: CustomFontStyle.primaryTitle(context).copyWith(fontSize: 18),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
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

          prefixWidget: const Icon(
            Icons.email_outlined,
            color: CustomColor.hintText,
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
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
