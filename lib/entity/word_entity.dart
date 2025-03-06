import 'package:flutter/material.dart';
import 'package:lingualift/entity/sentence_entity.dart';

@immutable
class WordEntity {
  final int page;
  final String sender;
  final List<SentenceEntity> sentences;

  const WordEntity({
    required this.page,
    required this.sender,
    required this.sentences,
  });

  WordEntity copyWith({
    int? page,
    String? sender,
    List<SentenceEntity>? sentences,
  }) {
    return WordEntity(
      page: page ?? this.page,
      sender: sender ?? this.sender,
      sentences: sentences ?? this.sentences,
    );
  }

  WordEntity.fromJson(Map<String, Object?> json)
      : this(
    sentences: ((json['sentences'] ?? []) as List?)
        ?.cast<Map<String, Object?>>()
        .map(SentenceEntity.fromJson)
        .toList() ??
        const [],
    sender: (json['sender'] ?? '') as String,
    page: (json['page'] ?? '') as int,
  );

}