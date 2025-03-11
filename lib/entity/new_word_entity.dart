import 'package:flutter/material.dart';
import 'package:lingualift/entity/sentence_entity.dart';

@immutable
class NewWordEntity {
  final String word;
  final String mean;

  const NewWordEntity({
    required this.word,
    required this.mean,
  });

  NewWordEntity copyWith({
    String? word,
    String? mean,
  }) {
    return NewWordEntity(
      word: word ?? this.word,
      mean: mean ?? this.mean,
    );
  }

  NewWordEntity.fromJson(Map<String, Object?> json)
      : this(
    word: (json['word'] ?? '') as String,
    mean: (json['mean'] ?? '') as String,
  );

}