part of 'incomplete_sentence_cubit.dart';

enum LoadStatus { loading, success, failure }

@immutable
class IncompleteSentenceState implements Equatable {
  final List<QuestionEntity>? listQuestion;
  final LoadStatus? status;
  final int? currentIndex;

  const IncompleteSentenceState({this.listQuestion, this.status, this.currentIndex});

  IncompleteSentenceState copyWith({
    List<QuestionEntity>? listQuestion,
    LoadStatus? status,
    int? currentIndex,
  }) {
    return IncompleteSentenceState(
      listQuestion: listQuestion ?? this.listQuestion,
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [listQuestion, status, currentIndex];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
