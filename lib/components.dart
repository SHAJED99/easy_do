import 'package:easy_do/src/controllers/services/functions/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// //! ------------------------------------------------------------------------------------------------ Company Information
// const baseCompanyName = "GTR";
// const projectName = "Halda";

// const baseLink = "https://3mz085wg-7074.asse.devtunnels.ms/api/";
// const baseLinkAuth = "https://gtrbd.net/chitraupdateapi/api/Auth/";
// const imageBaseLink = "https://gtrbd.net/Halda/";

// //! ------------------------------------------------------------------------------------------------ Sizes
get baseScreenSize => const Size(360, 800);
get defaultPadding => 24.sp;
get defaultBoxHeight => defaultPadding * 2;
// const paginationPageSize = 10;
const maxBoxWidth = 400.0;

// //* Border
// get borderWidth1 => 1.sp;
// get borderWidth2 => 2.sp;

// //! ------------------------------------------------------------------------------------------------ Time
const defaultSplashScreenShow = Duration(seconds: 3);
const defaultDuration = Duration(milliseconds: 500);
// const apiCallTimeOut = Duration(seconds: 30);
// const otpWaiting = Duration(seconds: 10);

// //! ------------------------------------------------------------------------------------------------ Color
const Color _primaryLight = Color(0xff8C88CD);
const Color scaffoldBackgroundColor = Color(0xffF9F9FF);

const List<Color> defaultGradient = [
  scaffoldBackgroundColor,
  Color(0xffFDF7E1),
  Color(0xffCDDAFC),
  Color(0xffF7E1E4),
  Color(0xffFBF3E8),
  scaffoldBackgroundColor
];
// //! ------------------------------------------------------------------------------------------------ Text
get textTheme => GoogleFonts.manropeTextTheme(Typography.englishLike2018.apply(fontSizeFactor: 1.sp));

get buttonTheme => ButtonThemeData(height: defaultBoxHeight);
get appBarTheme => AppBarTheme(
      toolbarHeight: defaultBoxHeight,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
    );

// //! ------------------------------------------------------------------------------------------------ Theme
ThemeData get lightTheme => ThemeData(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      useMaterial3: true,
      textTheme: textTheme,
      buttonTheme: buttonTheme,
      appBarTheme: appBarTheme,
      colorScheme: ColorScheme.fromSeed(seedColor: _primaryLight, brightness: Brightness.light),
    );

ThemeData get darkTheme => ThemeData(
      scaffoldBackgroundColor: scaffoldBackgroundColor.customInverseColor,
      useMaterial3: true,
      textTheme: textTheme,
      buttonTheme: buttonTheme,
      appBarTheme: appBarTheme,
      colorScheme: ColorScheme.fromSeed(seedColor: _primaryLight, brightness: Brightness.dark),
    );

    

// //! ------------------------------------------------------------------------------------------------ Validation
// const int phoneNumberLength = 11;
// const int nameMinLength = 8;
// const int passwordMinLength = 8;
// const int addressLength = 10;
// const String emailValidationPattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
// const int otpValidationLength = 5;

// // options.SignIn.RequireConfirmedEmail = true;
// //  options.Password.RequireDigit = true;
// //  options.Password.RequireLowercase = true;
// //  options.Password.RequiredLength = 8;
// //  options.Password.RequireUppercase = false;
// //  options.Password.RequireNonAlphanumeric = false;
// //  options.Lockout.MaxFailedAccessAttempts = 5;
// //  options.User.RequireUniqueEmail = true;
