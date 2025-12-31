import 'package:queroobras_mobile/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../mvvm/const/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  await StorageService.init(); // Initialize GetStorage
  Get.put(ServiceController());
  runApp( const MyApp());
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


          Widget resolveHome() {
            final bool hasValidToken = StorageDesign.isTokenValid();
            final String? userType = StorageDesign.readItem(StorageDesign.userType);

            if (hasValidToken && userType != null) {
              if (userType == "cpf") {
                return  CpfBottomNavScreen();
              } else if (userType == "cnpj") {
                return  BottomNavScreen();
              }
            }

            return const OnboardingScreen();
          }



        return OverlaySupport.global(
          child: GetMaterialApp(
            title: 'Quero Obra',
            debugShowCheckedModeBanner: false,
            theme: CAppTheme.lightMoodTheme,
            darkTheme: CAppTheme.darkMoodTheme,
            home: resolveHome(),
            routes: AppRoutes.routes,

            locale: const Locale('pt', 'BR'),
            supportedLocales: const [
              Locale('pt', 'BR'),
              Locale('en', 'US'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          )
          ,

        );
      },
    );
  }
}
