part of 'incomplete_word_cubit.dart';

enum LoadStatus { loading, success, failure }

@immutable
class IncompleteWordState implements Equatable {
  final List<WordEntity>? listQuestion;
  final LoadStatus? status;
  final int currentIndex;
  final String? question;
  final int totalPage;

  const IncompleteWordState({this.listQuestion, this.status, this.currentIndex = 1, this.question, this.totalPage = 0});

  IncompleteWordState copyWith({
    List<WordEntity>? listQuestion,
    LoadStatus? status,
    int? currentIndex,
    String? question,
    int? totalPage
  }) {
    return IncompleteWordState(
      listQuestion: listQuestion ?? this.listQuestion,
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
      question: question ?? this.question,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object?> get props => [listQuestion, status, currentIndex, question, totalPage];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

extension ListEx on List<WordEntity>? {
  List<WordEntity>? filterByIndex(int index) {
    return this
        ?.where((answer) => answer.page == index)
        .toList();
  }
}