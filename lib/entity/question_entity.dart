import 'package:flutter/material.dart';
import 'package:lingualift/entity/sentence_entity.dart';

@immutable
class QuestionEntity {
  const QuestionEntity({
    required this.question,
    required this.type,
    required this.sentences,
  });

  QuestionEntity.fromJson(Map<String, Object?> json)
      : this(
    sentences: ((json['sentences'] ?? []) as List?)
        ?.cast<Map<String, Object?>>()
        .map(SentenceEntity.fromJson)
        .toList() ??
        const [],
    question: (json['question'] ?? '') as String,
    type: (json['type'] ?? '') as String,
  );

  final String question;
  final String type;
  final List<SentenceEntity> sentences;

  Map<String, Object?> toJson() {
    return {
      'question': question,
      'type': type,
      'sentences': sentences,
    };
  }
}
