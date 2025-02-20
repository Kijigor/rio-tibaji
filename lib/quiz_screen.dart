import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "O que é sustentabilidade?",
      "options": ["Uso equilibrado dos recursos naturais", "Consumo exagerado", "Desmatamento", "Poluição"],
      "answer": "Uso equilibrado dos recursos naturais",
      "hint": "Refere-se ao uso responsável dos recursos naturais."
    },
    {
      "question": "Qual é a principal causa da poluição dos rios?",
      "options": ["Lançamento de esgoto", "Turismo", "Chuva", "Pecuária"],
      "answer": "Lançamento de esgoto",
      "hint": "Muitos rios recebem resíduos diretamente das cidades."
    },
    {
      "question": "O que podemos fazer para economizar água?",
      "options": ["Fechar a torneira", "Deixar a torneira aberta", "Lavar calçadas todos os dias", "Tomar banhos longos"],
      "answer": "Fechar a torneira",
      "hint": "Evitar desperdícios ajuda o meio ambiente."
    },
    {
      "question": "Qual destes não é um rio brasileiro?",
      "options": ["Amazonas", "Tibaji", "São Francisco", "Mississippi"],
      "answer": "Mississippi",
      "hint": "Esse rio fica nos Estados Unidos."
    },
    {
      "question": "Qual é uma fonte de energia renovável?",
      "options": ["Solar", "Petróleo", "Carvão", "Nuclear"],
      "answer": "Solar",
      "hint": "É uma energia limpa e vem do sol."
    }
  ];

  int currentQuestionIndex = 0;
  String feedbackMessage = "";
  Color feedbackColor = Colors.black;

  void checkAnswer(String selectedOption) {
    setState(() {
      if (selectedOption == questions[currentQuestionIndex]["answer"]) {
        feedbackMessage = "✅ Você acertou! Parabéns!";
        feedbackColor = Colors.green;
      } else {
        feedbackMessage = "❌ Errado! Dica: ${questions[currentQuestionIndex]["hint"]}";
        feedbackColor = Colors.red;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
      feedbackMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz sobre Sustentabilidade')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(questions[currentQuestionIndex]["question"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...questions[currentQuestionIndex]["options"].map<Widget>((option) => ElevatedButton(
              onPressed: () => checkAnswer(option),
              child: Text(option),
            )).toList(),
            SizedBox(height: 10),
            Text(feedbackMessage, 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: feedbackColor)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: nextQuestion,
              child: Text('Próxima Pergunta'),
            ),
          ],
        ),
      ),
    );
  }
}

