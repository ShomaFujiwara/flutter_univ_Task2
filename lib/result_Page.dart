import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int winCounter = 0;
  String resultMess = "";
  void winCount(List list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i] == "◯") {
        winCounter++;
      }
    }
    if (winCounter == 5) {
      resultMess = "全勝だ！すごい！";
    } else if (winCounter >= 3) {
      resultMess = "$winCounter勝だ。まあまあかな";
    } else if (winCounter >= 1) {
      resultMess = "$winCounter勝か、、、";
    } else {
      resultMess = "全敗";
    }
  }

  var optionStyle = const TextStyle(fontSize: 32, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context)?.settings.arguments as List;
    //↑list で受け取る navigationから
    winCount(args);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(resultMess, style: optionStyle),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < args.length; i++) ...[
                  Text(
                    args[i],
                    style: optionStyle,
                  ),
                ]
              ],
            ),
            const SizedBox(height: 35),
            ElevatedButton(
                onPressed: () => {
                      Navigator.pushReplacementNamed(
                        context,
                        "/home",
                      ),
                    },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25)),
                  height: 70,
                  width: 240,
                  child: Center(child: Text("タイトルに戻る", style: optionStyle)),
                ))
          ],
        ),
      ),
    );
  }
}
