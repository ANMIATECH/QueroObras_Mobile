import 'package:queroobras_mobile/mvvm/screens/auth/cnpjprofilepic_update.dart';

import '../const/export.dart';
import '../screens/dashboard/notification/notification_cpnf.dart';

/// A utility class to hold all static route names and the route map.
class AppRoutes {
  // Define route names as static constants for type-safe navigation
  static const String onboarding = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String notificationcpnf = '/notificationcpnf';
  static const String oneOnOneChat = '/oneOnOneChat';
  static const String serviceRequestScreen = '/serviceRequestScreen';
  static const String registration = '/registration';
  static const String cpfBottomNav = '/cpfBottomNav';
  static const String cpnjBottomNav = '/cpnjBottomNav';
  static const String forgetPassword = '/forgetPassword';
  static const String cpfProfile = '/cpfProfile';
  static const String bottomNavCpf = '/bottomNavCpf';
  static const String cnpjProfile = '/cnpjProfile';
  static const String serviceScreen = '/serviceScreen';
  static const String otpPin = '/otpPin';
  static const String changePasswordWord = '/changePasswordWord';
  static const String bottomNav = '/bottomNav';
  static const String materiaisServiceProvider = '/materiaisServiceProvider';
  static const String vender = '/vender';
  static const String venderCreate = '/venderCreate';
  static const String uploadSuccessScreen = '/uploadSuccessScreen';
  static const String checkout = '/checkout';
  static const String notificationCpnScreen = '/notificationCpnScreen';

  /// A map defining all application routes.
  static Map<String, WidgetBuilder> get routes => {
    onboarding: (context) => const OnboardingScreen(),
    welcome: (context) => const WelcomeScreen(),
    login: (context) => LoginScreen(),
    oneOnOneChat: (context) => OneOnOneChat(),
    // serviceRequestScreen: (context) => ServiceRequestScreen(),
    registration: (context) => const RegistrationScreen(),
    forgetPassword: (context) => const ResetPasswordScreen(),
    cpfBottomNav: (context) => CpfBottomNavScreen(),
    cpnjBottomNav: (context) => BottomNavScreen(),
    cpfProfile: (context) => ProfileUploadScreen(),
    cnpjProfile: (context) => CNPJProfileUploadScreen(),
    serviceScreen: (context) => ServicesScreen(),
    notificationcpnf: (context) => NotificationCpnfScreen(),
    bottomNavCpf: (context) => BottomNavScreen(),
    otpPin: (context) => OtpVerificationScreen(),
    changePasswordWord: (context) => ChangePasswordWord(),
    bottomNav: (context) => CpfBottomNavScreen(),
    materiaisServiceProvider: (context) => MaterialShopScreen(),
    vender: (context) => VenderScreen(),
    venderCreate: (context) => VendorFormScreen(),
    uploadSuccessScreen: (context) => UploadSuccessScreen(),
    checkout: (context) => OrdersScreen(),
    notificationCpnScreen: (context) => NotificationCpnScreen(),
  };
}
