import '../const/export.dart';
import '../screens/auth/signuoOtp_verification.dart';

class RouteNameV1 {
  static String getStarted = '/getStarted';
  static String login = '/login';
  static String vender = '/vender';
  static String createVender = '/createVender';
  static String venderDetail = '/venderDetail';
  static String home = '/dashboard';
  static String bottomNav = '/bottomNav';
  static String welcome = '/welcome';
  static String oneOnOneChat = '/oneOnOneChat';
  static String productDetail = '/productDetail';
  static String createAccount = '/createAccount';
  static String onboarding = '/';
  static String serviceScreen = '/serviceScreen';
  static String serviceRequestScreen = '/serviceRequestScreen';
  static String acabamentoServiceProvider = '/acabamentoServiceProvider';
  static String materiaisServiceProvider = '/materiaisServiceProvider';
  static String ferramentasServiceProvider = '/ferramentasServiceProvider';

  static String forgetPassword = '/forgetPassword';
  static String resetPasswordPin = '/resetPasswordPin';
  static String changePassword = '/changePassword';
  static String otpPin = '/otpPin';
  static String signOtpPin = '/signOtpPin';

  static List<GetPage> getPages() {
    return [
      GetPage(name: onboarding, page: () => OnboardingScreen()),
      GetPage(name: welcome, page: () => WelcomeScreen()),
      GetPage(name: home, page: () => HomeScreen()),
      GetPage(name: bottomNav, page: () => BottomNavScreen()),
      GetPage(name: productDetail, page: () => ProductDetailsScreen()),
      GetPage(name: oneOnOneChat, page: () => OneOnOneChat()),
      GetPage(name: serviceScreen, page: () => ServicesScreen()),
      GetPage(name: login, page: () => LoginScreen()),
      GetPage(name: signOtpPin, page: () => SignUpOtpVerification(email:  Get.arguments as String,)),
      GetPage(name: vender, page: () => VenderScreen()),
      GetPage(name: createVender, page: () => VendorFormScreen()),
      GetPage(name: venderDetail, page: () => VenderItemDetails()),
      GetPage(
        name: acabamentoServiceProvider,
        page: () => ServiceProvidersScreen(),
      ),
      GetPage(name: materiaisServiceProvider, page: () => MaterialShopScreen()),
      GetPage(
        name: ferramentasServiceProvider,
        page: () => FerramentasServices(),
      ),
      GetPage(name: serviceRequestScreen, page: () => ServiceRequestScreen()),
      GetPage(
        name: RouteNameV1.otpPin,
        page: () => OtpVerificationScreen(email: Get.arguments as String),
      ),

      GetPage(name: createAccount, page: () => RegistrationScreen()),
      GetPage(name: forgetPassword, page: () => ResetPasswordScreen()),
    ];
  }
}
