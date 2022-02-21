import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Icon> scoreKeeper = [];

  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: () {
                  checkAnswer(true);
                },
                child: const Text(
                  "True",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(backgroundColor: Colors.green),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: () {
                  checkAnswer(false);
                },
                child: const Text(
                  "False",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ),
          Container(
            height: 25,
            child: Row(

              children: scoreKeeper,
            ),
          )
        ],
      ),
    );
  }

  void checkAnswer(bool clicked) {
    setState(() {
      if(quizBrain.isFinished()) {
        Alert(context: context, title: "Finished!", desc: "You've reached the end of the quiz.").show();
        quizBrain.reset();
        cleanScoreKeeper();
      } else {
        addScoreKeeper(clicked == quizBrain.getQuestionAnswer());
        quizBrain.nextQuestion();
      }
    });

  }
  void addScoreKeeper(bool isCorrect) {
    if (isCorrect) {
      scoreKeeper.add(
        const Icon(Icons.check, color: Colors.green, size: 25),
      );
    } else {
      scoreKeeper.add(
        const Icon(Icons.close, color: Colors.red, size: 25),
      );
    }
  }
  void cleanScoreKeeper() {
    scoreKeeper.clear();
  }
}
