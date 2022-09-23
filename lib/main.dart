import 'package:flutter/material.dart';
import 'janken_Page.dart';
import 'result_Page.dart';

void main() {
  runApp(const MyApp());
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
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        routes: <String, WidgetBuilder>{
          //ページ先
          "/home": (BuildContext context) => const HomeScreen(), //home
          "/Janken": (BuildContext context) => const JankenPage(),
          "/result": (BuildContext context) => const ResultPage(),
        });
  }
}

//_________________________________________________________________________
//スタートページ
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: InkWell(
        onTap: () => {
          Navigator.pushReplacementNamed(
            context,
            "/Janken",
          ),
        },
        child: Expanded(
          child: Container(
            color: Colors.grey[300],
            child: const Center(
              child: Text('ジャンケン',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ),
      ),
    ));
  }
}

//_________________________________
