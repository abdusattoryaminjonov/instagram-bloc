import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclon/bloc/my_like_bloc/like_bloc.dart';
import 'package:instaclon/bloc/my_like_bloc/like_event.dart';
import 'package:instaclon/bloc/my_like_bloc/like_state.dart';
import '../models/post_model.dart';
import '../views/feed_item_of_post.dart';

class MyLikesPage extends StatefulWidget {
  final PageController? pageController;

  const MyLikesPage({Key? key , this.pageController}) : super(key: key);

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {

  late LikeBloc likeBloc;

  @override
  void initState() {
    super.initState();
    likeBloc = BlocProvider.of<LikeBloc>(context);
    likeBloc.add(LikeLoadLikesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Likes",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
        ),
      ),
      body: BlocBuilder<LikeBloc, LikeState>(
        builder: (context, state) {
          if (state is LikeErrorState) {
            return viewOfError("Error code page LikePage!");
          }
          if (state is LikeLoadLikesState) {
            var posts = state.posts;
            return viewOfPostList(posts);
          }
          return viewOfLoading();
        },
      ),
    );
  }
  Widget viewOfError(String err) {
    return Center(
      child: Text("Error occurred $err"),
    );
  }

  Widget viewOfLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget viewOfPostList(List<Post> posts) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: likeBloc.items.length,
          itemBuilder: (ctx, index) {
            return itemOfPost(context,likeBloc.items[index]);
          },
        ),
      ],
    );
  }
}

