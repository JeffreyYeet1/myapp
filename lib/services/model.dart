import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

// define instance variables that match the format in our firestore database

@JsonSerializable()
class Topic {
  final String id;
  final String title;
  final String img;
  final String description;
  final List<Quiz> quizzes;

  // Set up constructor to assign default values to these variables

  Topic ({
    this.id = '',
    this.title = '',
    this.description = '',
    this.img = 'default.png',
    this.quizzes = const [],
  });

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);

}

@JsonSerializable()
class Report {
  String uid;
  int total;
  Map topics;

  Report({
    this.uid = '',
    this.topics = const{},
    this.total = 0,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);

} 

@JsonSerializable()
class Quiz {
  final String description;
  final String id;
  final List<Question> questions;
  final String title;
  final String topic;

  Quiz ({
    this.description = '',
    this.id = '',
    this.title = '',
    this.topic = '',
    this.questions = const [],
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);

}

@JsonSerializable()
class Question {
  String text;
  List<Option> options;
  Question({
    this.text = '',
    this.options = const [],
  });

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);

}

@JsonSerializable()
class Option{
  String value;
  String detail;
  bool correct;
  Option({
    this.value = '',
    this.detail = '',
    this.correct = false,
  });

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  Map<String, dynamic> toJson() => _$OptionToJson(this);
  
}