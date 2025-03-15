import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/orientation.dart';
import 'package:movieapp/utils/colors.dart';
import 'package:movieapp/utils/dimension.dart';
import 'package:movieapp/utils/services.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    late Dimension dimension;

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      dimension = Dimension(MediaQuery.of(context).size.height,
          MediaQuery.of(context).size.width);
    } else {
      dimension = Dimension(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height);
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Dimension(0, 0)),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Anaconrelo Movie',
          navigatorKey: services<GlobalKey<NavigatorState>>(),
          theme: ThemeData(
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: AppColors.engineeringOrange,
              onPrimary: AppColors.maroon,
              secondary: AppColors.poppy,
              onSecondary: AppColors.bloodRed,
              error: AppColors.pennRed,
              onError: Colors.red,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textTheme: TextTheme(
              displayLarge: GoogleFonts.inter(
                fontSize: 96,
                fontWeight: FontWeight.w300,
                letterSpacing: -1.5,
              ),
              displayMedium: GoogleFonts.inter(
                fontSize: 60,
                fontWeight: FontWeight.w300,
                letterSpacing: -0.5,
              ),
              displaySmall:
                  GoogleFonts.inter(fontSize: 48, fontWeight: FontWeight.w400),
              headlineMedium: GoogleFonts.inter(
                fontSize: 34,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
              ),
              headlineSmall: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
              titleLarge: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
              ),
              titleMedium: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.15,
              ),
              titleSmall: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
              bodyLarge: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
              bodyMedium: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
              ),
              bodySmall: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4,
              ),
              labelLarge: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.25,
              ),
              labelSmall: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.engineeringOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    dimension.getWidth(16),
                  ),
                ),
              ),
            ),
            scaffoldBackgroundColor: AppColors.bloodRed,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.maroon,
              foregroundColor: Colors.white,
            ),
            useMaterial3: true,
            brightness: Brightness.light,
            snackBarTheme: SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  dimension.getWidth(16),
                ),
              ),
            ),
          ),
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!);
          },
          home: const OrientationChangeHandler(),
        );
      },
    );
  }
} 