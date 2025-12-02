import '../mvvm/const/export.dart';
import 'mvvm/controller/service_controller.dart';

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
        // final String? token = StorageService.has(StorageDesign.token)
        //     ? StorageService.read(StorageDesign.token)
        //     : null;

        // final String? userStatus = StorageService.has("user_status")
        //     ? StorageService.read("user_status")
        //     : null;
        // String initialRoute = RouteNameV1.getStarted;

        // if (token != null && token.isNotEmpty) {
        //   if (userStatus == "cpf") {
        //     initialRoute = RouteNameV1.bottomNavCpf;
        //   } else if (userStatus == "cnpj") {
        //     initialRoute = RouteNameV1.bottomNav;
        //   }
        // }

        return GetMaterialApp(
          title: 'Quero Obra',
          debugShowCheckedModeBanner: false,
          theme: CAppTheme.lightMoodTheme,
          darkTheme: CAppTheme.darkMoodTheme,
          // 1. Define the initial route (the screen that loads first)
          initialRoute: AppRoutes.onboarding,

          // 2. Define the available routes using a Map<String, WidgetBuilder>
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
