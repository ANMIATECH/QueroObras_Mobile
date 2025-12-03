import '../const/export.dart';
import '../controller/cpfbottomnav_controller.dart';


/// A utility class to hold all static route names and the route map.
class AppRoutes {
  // Define route names as static constants for type-safe navigation
  static const String onboarding = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String cpfBottomNav = '/cpfBottomNav';
  static const String cpnjBottomNav = '/cpnjBottomNav';
  static const String forgetPassword = '/forgetPassword';


  /// A map defining all application routes.
  static Map<String, WidgetBuilder> get routes => {
        onboarding: (context) => const OnboardingScreen(),
        welcome: (context) => const WelcomeScreen(),
        login: (context) =>  LoginScreen(),
        registration: (context) => const RegistrationScreen(),
    forgetPassword: (context) => const ResetPasswordScreen(),
    cpfBottomNav: (context) =>  CpfBottomNavScreen(),
    cpnjBottomNav: (context) =>  BottomNavScreen(),

  };
}
