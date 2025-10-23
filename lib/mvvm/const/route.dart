import '../const/export.dart';


class RouteNameV1 {
  static String getStarted = '/getStarted';
  static String login = '/login';
  static String home = '/home';
  static String bottomNav = '/bottomNav';
  static String welcome = '/welcome';
  static String createAccount = '/createAccount';
  static String onboarding = '/';

  static String forgetPassword = '/forgetPassword';
  static String resetPasswordPin = '/resetPasswordPin';
  static String changePassword = '/changePassword';
  static String otpPin = '/otpPin';


  static List<GetPage> getPages() {
    return [
      GetPage(name: onboarding, page: () =>  OnboardingScreen()),
      GetPage(name: welcome, page: () =>  WelcomeScreen()),
      GetPage(name: home, page: () =>  HomeScreen()),
      GetPage(name: bottomNav, page: () =>  BottomNavScreen()),

    ];
  }
}
