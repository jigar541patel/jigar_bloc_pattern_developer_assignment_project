import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jigar_developer_flutter_assigments/theme/themes.dart';
import 'package:jigar_developer_flutter_assigments/utils/app_color.dart';
import 'package:jigar_developer_flutter_assigments/utils/route_names.dart';
import 'package:jigar_developer_flutter_assigments/utils/routes.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColor.primaryDarkColor,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => MaterialApp(
        title: 'BLOC Pattern Realtime Innovation Assignment',
        debugShowCheckedModeBanner: false,
        theme: Themes.lightTheme,
        darkTheme: Themes.lightTheme,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: routeEmployeeList,
        // localizationsDelegates: const [
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        supportedLocales: const [Locale('en', 'US')],
      ),
    );
  }
}
