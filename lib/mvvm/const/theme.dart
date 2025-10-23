import '../const/export.dart';


class CAppTheme {
  CAppTheme._();

  static ThemeData lightMoodTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    scaffoldBackgroundColor: CustomColor.white,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: CustomColor.primary,
      elevation: 0,
    ),
    primaryColor: CustomColor.primary,
    textTheme: CAppTextTheme.lightModeTextTheme,
    colorScheme: const ColorScheme.light(
      primary: CustomColor.primary,
      secondary: CustomColor.secondary,
      error: CustomColor.error,
      onPrimary: CustomColor.white,
      onSecondary: CustomColor.white,
      onError: CustomColor.white,
      surface: CustomColor.white,
      onSurface: CustomColor.black,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(CustomColor.white),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: CustomColor.white,
      surfaceTintColor: Colors.transparent, // Disables the light blue overlay
      scrolledUnderElevation: 0, // Removes shadow when scrolling

      elevation: 0,
      iconTheme: IconThemeData(color: CustomColor.black),
      titleTextStyle: TextStyle(
        color: CustomColor.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColor.primary,
        foregroundColor: CustomColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    // cardTheme: CardTheme(
    //   color: CustomColor.white,
    //   elevation: 4,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    // ),
  );

  static ThemeData darkMoodTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    scaffoldBackgroundColor: CustomColor.white,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: CustomColor.primary,
      elevation: 0,
    ),
    primaryColor: CustomColor.primary,
    textTheme: CAppTextTheme.lightModeTextTheme,
    colorScheme: const ColorScheme.light(
      primary: CustomColor.primary,
      secondary: CustomColor.secondary,
      error: CustomColor.error,
      onPrimary: CustomColor.white,
      onSecondary: CustomColor.white,
      onError: CustomColor.white,
      surface: CustomColor.white,
      onSurface: CustomColor.black,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(CustomColor.white),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: CustomColor.white,
      surfaceTintColor: Colors.transparent, // Disables the light blue overlay
      scrolledUnderElevation: 0, // Removes shadow when scrolling

      elevation: 0,
      iconTheme: IconThemeData(color: CustomColor.black),
      titleTextStyle: TextStyle(
        color: CustomColor.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColor.primary,
        foregroundColor: CustomColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    // cardTheme: CardTheme(
    //   color: CustomColor.white,
    //   elevation: 4,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    // ),
  );
}

class CAppTextTheme {
  CAppTextTheme._();

  static TextTheme lightModeTextTheme = TextTheme(
    // Heading Styles
    displayLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 24.sp,
      color: CustomColor.black,
      fontWeight: FontWeight.w700,
      height: 1.4,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.sp,
      color: CustomColor.black,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    // Body Styles
    bodyLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 15.sp,
      color: CustomColor.white,
      fontWeight: FontWeight.w100,
      letterSpacing: -0.28,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14.sp,
      color: CustomColor.white,
      fontWeight: FontWeight.w400,
      height: 1.29,
    ),
  );

  static TextTheme darkModeTextTheme = TextTheme(
    // Heading Styles
    displayLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 24.sp,
      color: CustomColor.white,
      fontWeight: FontWeight.w700,
      height: 1.4,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.sp,
      color: CustomColor.white,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    // Body Styles
    bodyLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 15.sp,
      color: CustomColor.black,
      fontWeight: FontWeight.w100,
      letterSpacing: -0.28,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14.sp,
      color: CustomColor.black,
      fontWeight: FontWeight.w400,
      height: 1.29,
    ),
  );
}
