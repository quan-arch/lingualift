part of 'incomplete_word_cubit.dart';

enum LoadStatus { loading, success, failure }

@immutable
class IncompleteWordState implements Equatable {
  final List<WordEntity>? listQuestion;
  final LoadStatus? status;
  final int currentIndex;
  final String? question;

  const IncompleteWordState({this.listQuestion, this.status, this.currentIndex = 1, this.question});

  List<WordEntity>? get listRealQuestion {
    return listQuestion
        ?.where((answer) => answer.page == currentIndex)
        .toList();
  }

  IncompleteWordState copyWith({
    List<WordEntity>? listQuestion,
    LoadStatus? status,
    int? currentIndex,
    String? question,
  }) {
    return IncompleteWordState(
      listQuestion: listQuestion ?? this.listQuestion,
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
      question: question ?? this.question,
    );
  }

  @override
  List<Object?> get props => [listQuestion, status, currentIndex, question];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
