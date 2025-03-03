class SentenceEntity {
  final String content;
  final String type;
  final String key;
  final String? correctAnswer;

  const SentenceEntity({
    required this.content,
    required this.type,
    required this.key,
    this.correctAnswer,
  });

  SentenceEntity.fromJson(Map<String, Object?> json)
      : this(
    content: (json['content']! as String),
    type: json['type']! as String,
    key: json['key']! as String,
    correctAnswer: json['correct_answer'] as String?,
  );

  Map<String, Object?> toJson() {
    return {
      'content': content,
      'type': type,
      'key': key,
      'correct_answer': correctAnswer
    };
  }
}