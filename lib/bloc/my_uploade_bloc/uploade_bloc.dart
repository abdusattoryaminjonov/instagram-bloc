import 'package:bloc/bloc.dart';
import 'package:instaclon/bloc/my_uploade_bloc/uploade_event.dart';
import 'package:instaclon/bloc/my_uploade_bloc/uploade_state.dart';
import '../../models/post_model.dart';
import '../../services/db_service.dart';
import '../../services/file_service.dart';


class MyUploadBloc extends Bloc<MyUploadEvent, MyUploadState> {
  MyUploadBloc() : super(MyUploadInitialState()) {
    on<UploadPostEvent>(_onUploadPostEvent);
  }

  Future<void> _onUploadPostEvent(UploadPostEvent event, Emitter<MyUploadState> emit) async {
    emit(MyUploadLoadingState());

    var downloadUrl = await FileService.uploadPostImage(event.image);
    if(downloadUrl.isEmpty){
      emit(MyUploadFailureState("Please try again later"));
    }

    Post post = Post(event.caption, downloadUrl);
    // Post to posts
    Post posted = await DBService.storePost(post);
    // Post to feeds
    await DBService.storeFeed(posted);
    emit(MyUploadSuccessState());
  }
}