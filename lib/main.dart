import '../mvvm/const/export.dart';
import 'mvvm/controller/service_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LoginController());
  Get.put(ServiceController());

  await StorageService.init(); // Initialize GetStorage
  runApp(const MyApp());
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
          return GetMaterialApp(
            title: 'Quero Obra',
            debugShowCheckedModeBanner: false,
            theme: CAppTheme.lightMoodTheme,
            initialBinding: BindingsBuilder(() {

            }),
            darkTheme: CAppTheme.darkMoodTheme,
            getPages: RouteNameV1.getPages(), // Route Management
            initialRoute: !StorageService.has(StorageDesign.token)
                ? RouteNameV1.getStarted
                : RouteNameV1.bottomNav, // Web Routes Handling
          );
        });
  }
}
