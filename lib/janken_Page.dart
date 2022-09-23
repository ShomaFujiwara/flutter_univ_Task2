import 'dart:math';
import 'package:flutter/material.dart';

class JankenPage extends StatefulWidget {
  const JankenPage({super.key});

  @override
  State<JankenPage> createState() => _JankenPageState();
}



class _JankenPageState extends State<JankenPage> {
  String myHand = '';
  String computerHand = '';
  String result = '';
  List<String> resultBox = ['-', '-', '-', '-', '-']; //ジャンケン結果
  String myPic = 'images/white.png'; //自分の手のpicture
  String comPic = 'images/white.png'; //相手の手のpicture
  int battleCounter = 0;

  void genelateComputerHand() {
    final randomNumber = Random().nextInt(3);
    //3であれば０、１、２の値がランダムで生成される
    //生成された値を一時的に保存
    computerHand = randomNumberToHand(randomNumber);
    // 値を✊✌️✋に変換し、代入
    comPic = numberToPicture(randomNumber);
  }

  final _textSize = const TextStyle(fontSize: 20); //多用するTextStyleを変数に格納

  void _onItemTapped(int index) {
    //bottomNavからIndexが送られてくる
    myHand = randomNumberToHand(index); //indexを手に変える
    myPic = numberToPicture(index); //数字をpictureに変えるメソッド
    genelateComputerHand(); //コンピュータの手を決める
    judge(); //勝敗を判定,カウンターの追加

    if (resultBox[4] != '-') {
      //boxが結果で埋まったら
      Navigator.pushReplacementNamed(
        //resultPageへ画面遷移
        context,
        "/result",
        arguments: resultBox, //画面遷移する際、結果の配列を送る
      );
    }
    setState(() {}); //画面更新
  }

  void judge() {
    //＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
    // ジャンケン結果↓
    battleCounter--;
    if (myHand == computerHand) {
      result = "あいこで";
    } else if (myHand == "✊" && computerHand == "✌️") {
      result = "勝ち";
    } else if (myHand == "✌️" && computerHand == "✋") {
      result = "勝ち";
    } else if (myHand == "✋" && computerHand == "✊") {
      result = "勝ち";
    } else {
      result = "負け";
    }

    // 勝ちなら◯、負けなら✖️、あいこ以外カウントする
    if (result == "勝ち") {
      resultBox[battleCounter] = "◯";
    } else if (result == "負け") {
      resultBox[battleCounter] = "✖️";
    }
    if (result != 'あいこで') {
      battleCounter++;
      print(battleCounter);
    }
  }

  String numberToPicture(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return 'images/gu.png';
      case 1:
        return 'images/tyoki.png';
      case 2:
        return 'images/pa.png';
      default:
        return '';
    }
  }

  String randomNumberToHand(int randomNumber) {
    //数字からジャンケンの手に変えるメソッド
    switch (randomNumber) {
      case 0:
        return '✊';
      case 1:
        return '✌️';
      case 2:
        return '✋';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    battleCounter++;
    return Scaffold(
      appBar: AppBar(title: Text("$battleCounter")),
      body: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
        children: [
              Text(("$battleCounter回戦"), style: _textSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < resultBox.length; i++) ...[
                    //配列を全部表示
                    Text(
                      resultBox[i],
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.w700),
                    ),
                  ]
                ],
              ),
              Text(
                result,
                style: const TextStyle(
                    fontSize: 35, fontWeight: FontWeight.w600, color: Colors.blue),
              ),
              const SizedBox(height: 48),
              SizedBox(
                    width: 120,
                    height: 120,
                child: Image.asset(
                  comPic,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.asset(
                    myPic,
                    fit: BoxFit.cover,
                  )),
        ],
      ),
            ],
          )),
          
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Text("✊", style: _textSize),
            label: 'グー',
          ),
          BottomNavigationBarItem(
            icon: Text("✌️", style: _textSize),
            label: 'チョキ',
          ),
          BottomNavigationBarItem(
            icon: Text("✋", style: _textSize),
            label: 'パー',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
        selectedItemColor: Colors.black,
        selectedFontSize: 15,
        unselectedFontSize: 15,
      ),
    );
  }
}
