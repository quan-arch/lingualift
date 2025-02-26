import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/common/app_images.dart';
import 'package:lingualift/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'LinguaLift',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<QuerySnapshot> _collectionStream = FirebaseFirestore.instance
      .collection('single-answer-question')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  width: 215,
                  height: 264,
                  AppImages.bannerTopRight,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  width: 225,
                  height: 306,
                  AppImages.bannerBottomLeft,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            _buildBodyWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppbar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 49),
      child: Text(
        'TOPIC NUMBER 1',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAppbar(context),
          const SizedBox(height: 93),
          _buildCountdownTimer(context),
          const SizedBox(height: 58),
          _buildQnA(context)
        ],
      ),
    );
  }

  Widget _buildCountdownTimer(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          width: 40,
          height: 40,
          AppImages.countdownTimer,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 6),
        Text(
          '00:09s',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.red),
        ),
      ],
    );
  }

  Widget _buildQnA(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 43),
      child: StreamBuilder<QuerySnapshot>(
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          List<Question> data =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> json =
                document.data()! as Map<String, dynamic>;
            Question data = Question.fromJson(json);
            return data;
          }).toList();

          if (data.isEmpty) return Text("Empty");

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildQuestion(context, data.first.question),
              const SizedBox(height: 37),
              _buildAnswer(context, data.first.answer1),
              const SizedBox(height: 10),
              _buildAnswer(context, data.first.answer2),
              const SizedBox(height: 10),
              _buildAnswer(context, data.first.answer3),
              const SizedBox(height: 10),
              _buildAnswer(context, data.first.answer4),
            ],
          );

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> json =
                  document.data()! as Map<String, dynamic>;
              Question data = Question.fromJson(json);
              return ListTile(
                title: Text(data.question),
                subtitle: Text(data.correctAnswer),
              );
            }).toList(),
          );
        },
        stream: _collectionStream,
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  Widget _buildAnswer(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          width: 20,
          height: 20,
          AppImages.radioBlack,
          fit: BoxFit.fill,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
        ),
      ],
    );
  }
}

@immutable
class Question {
  const Question({
    required this.correctAnswer,
    required this.question,
    required this.type,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
  });

  Question.fromJson(Map<String, Object?> json)
      : this(
          correctAnswer: (json['correct_answer']! as String),
          question: json['question']! as String,
          type: json['type']! as String,
          answer1: json['answer_1']! as String,
          answer2: json['answer_2']! as String,
          answer3: json['answer_3']! as String,
          answer4: json['answer_4']! as String,
        );

  final String correctAnswer;
  final String question;
  final String type;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;

  Map<String, Object?> toJson() {
    return {
      'correct_answer': correctAnswer,
      'question': question,
      'type': type,
      'answer_1': answer1,
      'answer_2': answer2,
      'answer_3': answer3,
      'answer_4': answer4,
    };
  }
}
