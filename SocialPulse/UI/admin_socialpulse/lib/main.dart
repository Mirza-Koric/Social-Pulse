import 'dart:io';

import 'package:admin_socialpulse/providers/notification_provider.dart';
import 'package:admin_socialpulse/providers/recommend_result_provider.dart';
import 'package:flutter/material.dart';
import 'package:admin_socialpulse/pages/login_page.dart';
import 'package:admin_socialpulse/providers/access_provider.dart';
import 'package:admin_socialpulse/providers/answer_provider.dart';
import 'package:admin_socialpulse/providers/comment_provider.dart';
import 'package:admin_socialpulse/providers/conversation_provider.dart';
import 'package:admin_socialpulse/providers/group_provider.dart';
import 'package:admin_socialpulse/providers/like_provider.dart';
import 'package:admin_socialpulse/providers/message_provider.dart';
import 'package:admin_socialpulse/providers/image_provider.dart';
import 'package:admin_socialpulse/providers/post_provider.dart';
import 'package:admin_socialpulse/providers/question_provicer.dart';
import 'package:admin_socialpulse/providers/report_provider.dart';
import 'package:admin_socialpulse/providers/subscription_provider.dart';
import 'package:admin_socialpulse/providers/tag_provider.dart';
import 'package:admin_socialpulse/providers/user_conversation_provider.dart';
import 'package:admin_socialpulse/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(1300, 800));
    //WindowManager.instance.setMaximumSize(const Size(1200, 600));
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AccessProvider()),
      ChangeNotifierProvider(create: (context) => AnswerProvider()),
      ChangeNotifierProvider(create: (context) => CommentProvider()),
      ChangeNotifierProvider(create: (context) => ConversationProvider()),
      ChangeNotifierProvider(create: (context) => GroupProvider()),
      ChangeNotifierProvider(create: (context) => MyImageProvider()),
      ChangeNotifierProvider(create: (context) => LikeProvider()),
      ChangeNotifierProvider(create: (context) => MessageProvider()),
      ChangeNotifierProvider(create: (context) => PostProvider()),
      ChangeNotifierProvider(create: (context) => QuestionProvider()),
      ChangeNotifierProvider(create: (context) => ReportProvider()),
      ChangeNotifierProvider(create: (context) => SubscriptionProvider()),
      ChangeNotifierProvider(create: (context) => TagProvider()),
      ChangeNotifierProvider(create: (context) => UserConversationProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => RecommendResultProvider()),
      ChangeNotifierProvider(create: (context) => NotificationProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialPulse mobile',
      theme: AppTheme.themeData,
      home: const LoginPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class AppTheme {
  static final textFormFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: AppColors.grey,
      width: 1.6,
    ),
  );

  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 34,
        letterSpacing: 0.5,
      ),
      bodySmall: TextStyle(
        color: Colors.grey,
        fontSize: 14,
        letterSpacing: 0.5,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      errorStyle: const TextStyle(
        fontSize: 12,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 14,
      ),
      border: textFormFieldBorder,
      errorBorder: textFormFieldBorder,
      focusedBorder: textFormFieldBorder,
      focusedErrorBorder: textFormFieldBorder,
      enabledBorder: textFormFieldBorder,
      labelStyle: const TextStyle(
        fontSize: 17,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(double.infinity, 52),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          Colors.black,
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.primaryColor,
        ),
      ),
    ),
  );
}
