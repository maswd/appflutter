import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sarfapp/providers/LocalProvider.dart';
import 'package:sarfapp/providers/ThemeProvider.dart';
import 'package:sarfapp/ui/ui_helper/ThemeSwitcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider,LocaleProvider>(
      builder: (context, themeProvider,localeProvider, child) {
        return MaterialApp(
          locale: localeProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('fa'), // Farsi
          ],
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme, // Define your light theme
          darkTheme: MyThemes.darkTheme, // Define your dark theme
          home: const TestPage(),
        );
      },
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context); // دسترسی به LocaleProvider

    return Scaffold(
      appBar: AppBar(
        actions: const [ThemeSwitcher()],
        title: const Text("data"),
      ),
      body: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              localeProvider.toggleLocale(); // تغییر زبان
            },
            child: Text(AppLocalizations.of(context)!.changeLanguage),
          ),
          Center(
            child: Text(AppLocalizations.of(context)!.helloWorld,style:Theme.of(context).textTheme.bodySmall,),
          ),
        ],
      ),
    );
  }
}
