part of 'new_word_cubit.dart';

enum LoadStatus { loading, success, failure }

@immutable
class NewWordState implements Equatable {
  final List<NewWordEntity>? list;
  final List<NewWordEntity>? blackList;
  final LoadStatus? status;
  final int? currentIndex;

  List<NewWordEntity> get listNewWord {
    final result = list?.where((e) => !inBlackList(e)).toList() ?? [];
    if(result.isEmpty) return [];
    if(result.length < 7) return result;
    return result.sublist(0, 6);
  }

  bool inBlackList(NewWordEntity e) {
    if(blackList?.isEmpty ?? true) return false;
    final index = blackList?.indexWhere((c) => c.word == e.word);
    return index != -1;
  }

  const NewWordState({this.list, this.blackList, this.status, this.currentIndex});

  NewWordState copyWith({
    List<NewWordEntity>? list,
    List<NewWordEntity>? blackList,
    LoadStatus? status,
    int? currentIndex,
  }) {
    return NewWordState(
      list: list ?? this.list,
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
