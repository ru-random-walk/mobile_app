part of 'test_form_screen.dart';

class Question {
  final String text;
  final List<String> answerOptions;
  final String answerType;
  final List<int> correctOptionNumbers;

  Question({
    required this.text,
    required this.answerOptions,
    required this.answerType,
    required this.correctOptionNumbers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] as String,
      answerOptions: (json['answerOptions'] as List<dynamic>).cast<String>(),
      answerType: json['answerType'] as String,
      correctOptionNumbers: (json['correctOptionNumbers'] as List<dynamic>).cast<int>(),
    );
  }
}
