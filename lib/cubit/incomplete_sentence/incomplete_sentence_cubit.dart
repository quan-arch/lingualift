import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:lingualift/entity/question_entity.dart';
import 'package:meta/meta.dart';

part 'incomplete_sentence_state.dart';

class IncompleteSentenceCubit extends Cubit<IncompleteSentenceState> {
  IncompleteSentenceCubit() : super(IncompleteSentenceState());

  void fetchData(){
    emit(state.copyWith(status: LoadStatus.loading));
    List<QuestionEntity> data = [];
    try {
      FirebaseFirestore.instance
          .collection('incomplete-sentences')
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
            QuestionEntity data = QuestionEntity.fromJson(json);
            return data;
          }).toList();
        }
        emit(state.copyWith(listQuestion: data, status: LoadStatus.success));
      });
    } catch (e, stackTrace) {
      print('catch:$e');
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void nextPage(){
    final totalPage = state.listQuestion?.length ?? 0;

    if(totalPage == 0) return;
    if(state.currentIndex == totalPage - 1) return;
    emit(state.copyWith(status: LoadStatus.loading));
    Future.delayed(Duration(milliseconds: 100)).then((_){
      var index = state.currentIndex ?? 0;
      final next = index + 1;
      emit(state.copyWith(currentIndex: next, status: LoadStatus.success));
    });
  }
}
