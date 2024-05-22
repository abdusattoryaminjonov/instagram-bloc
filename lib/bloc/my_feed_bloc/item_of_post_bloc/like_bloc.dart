import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instaclon/models/post_model.dart';

import '../../../services/db_service.dart';
import '../../../services/utils_service.dart';
import 'like_event.dart';
import 'like_state.dart';


class LikePostBloc extends Bloc<LikedEvent, LikeState> {

  LikePostBloc() : super(LikePostInitialState()) {
    on<LikePostEvent>(_onLikePostEvent);
    on<UnLikePostEvent>(_onUnlikePostEvent);
    on<RemoveLikePostEvent>(_onRemoveLikePostEvent);
  }



  Future<void> _onLikePostEvent(LikePostEvent event, Emitter<LikeState> emit) async {
    await DBService.likePost(event.post, true);
    event.post.liked = true;
    emit(LikePostSuccessState(post: event.post));
  }

  Future<void> _onUnlikePostEvent(UnLikePostEvent event, Emitter<LikeState> emit) async {
    await DBService.likePost(event.post, false);
    event.post.liked = false;
    emit(UnLikePostSuccessState(post: event.post));
  }

  Future<void> _onRemoveLikePostEvent(RemoveLikePostEvent event, Emitter<LikeState> emit) async{
    await DBService.removePost(event.post);
    emit(RemoveLikePostSuccessState(post: event.post));
  }

}