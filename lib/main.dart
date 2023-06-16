import 'package:flutter/material.dart';
import 'package:medic_petcare/Provider/ProductProvider.dart';
import 'package:medic_petcare/Provider/UserProvider.dart';
import 'package:medic_petcare/Routes/Routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (BuildContext context) => UserProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (BuildContext context) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Starter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        initialRoute: Routes.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
