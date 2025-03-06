import 'package:flutter/material.dart';
import 'package:lingualift/entity/sentence_entity.dart';
import 'package:lingualift/entity/word_entity.dart';

@immutable
class QuestionWordEntity {
  const QuestionWordEntity({
    required this.question,
    required this.type,
    required this.words,
  });

  QuestionWordEntity.fromJson(Map<String, Object?> json)
      : this(
    words: ((json['words'] ?? []) as List?)
        ?.cast<Map<String, Object?>>()
        .map(WordEntity.fromJson)
        .toList() ??
        const [],
    question: (json['question'] ?? '') as String,
    type: (json['type'] ?? '') as String,
  );

  final String question;
  final String type;
  final List<WordEntity> words;

  Map<String, Object?> toJson() {
    return {
      'question': question,
      'type': type,
      'words': words,
    };
  }
}
