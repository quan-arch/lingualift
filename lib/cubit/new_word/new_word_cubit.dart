import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:lingualift/entity/new_word_entity.dart';
import 'package:lingualift/entity/question_entity.dart';
import 'package:lingualift/entity/question_word_entity.dart';
import 'package:meta/meta.dart';

part 'new_word_state.dart';

class NewWordCubit extends Cubit<NewWordState> {
  NewWordCubit() : super(NewWordState());

  void fetchData(){
    emit(state.copyWith(status: LoadStatus.loading));
    List<NewWordEntity> data = [];
    try {
      FirebaseFirestore.instance
          .collection('character')
          .snapshots()
          .listen((querySnapshot) {
        for (final doc in querySnapshot.docs) {
          if (!doc.exists) {
            emit(state.copyWith(status: LoadStatus.failure));
            return;
          }
          data = querySnapshot.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> json =
            document.data()! as Map<String, dynamic>;
            NewWordEntity data = NewWordEntity.fromJson(json);
            return data;
          }).toList();
        }
        emit(state.copyWith(list: data, status: LoadStatus.success));
      });
    } catch (e, stackTrace) {
      print('catch:$e');
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void nextPage(){
    if(state.listNewWord.isEmpty) return;
    emit(state.copyWith(status: LoadStatus.loading));
    final blacklist = List<NewWordEntity>.from(state.blackList ?? []);
    for (var e in state.listNewWord) {
      final index = blacklist.indexWhere((c) => c.word == e.word);
      if(index == -1) {
        blacklist.add(e);
      }
    }
    Future.delayed(Duration(milliseconds: 100)).then((_){
      emit(state.copyWith(blackList: blacklist, status: LoadStatus.success));
    });
  }
}
