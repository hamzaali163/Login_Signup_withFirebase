import 'package:firebase_example/Utils/general_utils.dart';
import 'package:firebase_example/Utils/routes_names.dart';
import 'package:firebase_example/components/colors.dart';
import 'package:firebase_example/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => GeneralUtils())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: AppColors.mainColor),
          initialRoute: RoutesNames.splashscreen,
          //home: SplashScreen(),
          onGenerateRoute: Routes.generateroutes,
        ));
  }
}
