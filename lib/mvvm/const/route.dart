import '../const/export.dart';
import '../controller/cpfbottomnav_controller.dart';
import '../screens/auth/cnpjprofilepic_update.dart';
import '../screens/auth/profilepic_update.dart';
import '../screens/auth/signuoOtp_verification.dart';
import '../screens/dashboard/home/meuPedido.dart';
import '../screens/dashboard/home/servicesproviders_bycategory.dart';

class RouteNameV1 {
  static String getStarted = '/getStarted';
  static String login = '/login';
  static String vender = '/vender';
  static String meuPedido = '/meuPedido';
  static String cpfProfile = '/cpfProfile';
  static String cnpjProfile = '/cnpjProfile';
  static String createVender = '/createVender';
  static String venderDetail = '/venderDetail';
  static String home = '/home';
  static String profileEdit = '/profileEdit';
  static String bottomNav = '/bottomNav';
  static String bottomNavCpf = '/bottomNavCpf';
  static String welcome = '/welcome';
  static String oneOnOneChat = '/oneOnOneChat';
  static String productDetail = '/productDetail';
  static String createAccount = '/createAccount';
  static String onboarding = '/';
  static String serviceScreen = '/serviceScreen';
  static String serviceProviderByCategoryScreen = '/serviceProviderByCategoryScreen';
  static String serviceRequestScreen = '/serviceRequestScreen';
  static String acabamentoServiceProvider = '/acabamentoServiceProvider';
  static String materiaisServiceProvider = '/materiaisServiceProvider';
  static String ferramentasServiceProvider = '/ferramentasServiceProvider';

  static String forgetPassword = '/forgetPassword';
  static String serviceProviderAvailability = '/serviceProviderAvailability';
  static String serviceProviderReview = '/serviceProviderReview';
  static String resetPasswordPin = '/resetPasswordPin';
  static String changePassword = '/changePassword';
  static String otpPin = '/otpPin';
  static String signOtpPin = '/signOtpPin';

  static List<GetPage> getPages() {
    return [
      GetPage(name: onboarding, page: () => OnboardingScreen()),
      GetPage(name: welcome, page: () => WelcomeScreen()),
      GetPage(name: home, page: () => HomeScreen()),
      GetPage(name: profileEdit, page: () => ProfileEdit()),
      GetPage(name: cnpjProfile, page: () => CNPJProfileUploadScreen()),
      GetPage(name: cpfProfile, page: () => ProfileUploadScreen()),
      GetPage(name: bottomNav, page: () => BottomNavScreen()),
      GetPage(name: bottomNavCpf, page: () => CpfBottomNavScreen()),
      GetPage(name: serviceProviderByCategoryScreen, page: () => ServicesProvidersByCategory(slug: '',)),
      GetPage(name: serviceProviderAvailability, page: () => ServiceProviderAvailability()),
      GetPage(name: serviceProviderReview, page: () => ServiceProviderReview()),
      GetPage(name: productDetail, page: () => ProductDetailsScreen()),
      GetPage(name: oneOnOneChat, page: () => OneOnOneChat()),
      GetPage(name: serviceScreen, page: () => ServicesScreen()),
      GetPage(name: login, page: () => LoginScreen()),
      GetPage(name: signOtpPin, page: () => SignUpOtpVerification(email:  Get.arguments as String,)),
      GetPage(name: vender, page: () => VenderScreen()),
      GetPage(name: meuPedido, page: () => OrderTrackingScreen()),
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
