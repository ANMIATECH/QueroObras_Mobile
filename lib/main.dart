import '../mvvm/const/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LoginController());
  Get.put(ServiceController());

  await StorageService.init(); // Initialize GetStorage
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        final String? token = StorageService.has(StorageDesign.token)
            ? StorageService.read(StorageDesign.token)
            : null;

        final String? userStatus = StorageService.has("user_status")
            ? StorageService.read("user_status")
            : null;
        String initialRoute = AppRoutes.onboarding;

        if (token != null && token.isNotEmpty) {
          if (userStatus == "cpf") {
            initialRoute = AppRoutes.cpfBottomNav;
          } else if (userStatus == "cnpj") {
            initialRoute = AppRoutes.cpnjBottomNav;
          }
        }

        return OverlaySupport.global(
          child: GetMaterialApp(
            title: 'Quero Obra',
            debugShowCheckedModeBanner: false,
            theme: CAppTheme.lightMoodTheme,
            darkTheme: CAppTheme.darkMoodTheme,
            // 1. Define the initial route (the screen that loads first)
            initialRoute: initialRoute,
          
            // 2. Define the available routes using a Map<String, WidgetBuilder>
            routes: AppRoutes.routes,
          ),
        );
      },
    );
  }
}
