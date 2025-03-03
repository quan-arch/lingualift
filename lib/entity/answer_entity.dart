enum AnswerStatus { waiting, correct, incorrect }

class AnswerEntity {
  final String answer;
  final String key;
  final AnswerStatus status;

  const AnswerEntity({
    required this.answer,
    required this.key,
    this.status = AnswerStatus.waiting,
  });

  AnswerEntity copyWith({
    String? answer,
    String? key,
    AnswerStatus? status,
  }) {
    return AnswerEntity(
      answer: answer ?? this.answer,
      key: key ?? this.key,
      status: status ?? this.status,
    );
  }
}