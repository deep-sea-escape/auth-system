import 'package:flutter/material.dart';
import 'pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthPage(),
      initialRoute: AuthPage.routeName, // default is '/'
      routes: {
        AuthPage.routeName: (ctx) => const AuthPage(),
      },
      onGenerateRoute: (settings) {
        // 이름 정해지지 않은 곳으로 접근하면 여기로 감
        // print(settings.arguments);
        return MaterialPageRoute(
            builder: (ctx) => const Center(child: Text('Error')));
      },

      onUnknownRoute: (settings) {
        // 최후의 보루.
        // routes와 onGenerateRoute가 정의되어 있지 않은 경우, error 띄우기 전에 여기에 방문함
        // 보통 404 Error 페이지 사용
        return MaterialPageRoute(
            builder: (ctx) => const Center(child: Text('Error')));
      },
    );
  }
}
