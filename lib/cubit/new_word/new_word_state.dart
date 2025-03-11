part of 'new_word_cubit.dart';

enum LoadStatus { loading, success, failure }

@immutable
class NewWordState implements Equatable {
  final List<NewWordEntity>? listNewWord;
  final List<NewWordEntity>? blackList;
  final LoadStatus? status;
  final int? currentIndex;

  const NewWordState({this.listNewWord, this.blackList, this.status, this.currentIndex});

  NewWordState copyWith({
    List<NewWordEntity>? listNewWord,
    List<NewWordEntity>? blackList,
    LoadStatus? status,
    int? currentIndex,
  }) {
    return NewWordState(
      listNewWord: listNewWord ?? this.listNewWord,
      blackList: blackList ?? this.blackList,
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [listNewWord, blackList, status, currentIndex];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
