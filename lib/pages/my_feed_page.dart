import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_feed_bloc/feed_bloc.dart';
import '../bloc/my_feed_bloc/feed_event.dart';
import '../bloc/my_feed_bloc/feed_state.dart';
import '../bloc/my_feed_bloc/item_of_post_bloc/like_bloc.dart';
import '../bloc/my_feed_bloc/item_of_post_bloc/like_event.dart';
import '../bloc/my_feed_bloc/item_of_post_bloc/like_state.dart';
import '../models/post_model.dart';
import '../services/utils_service.dart';


class MyFeedPage extends StatefulWidget {
  final PageController? pageController;

  const MyFeedPage({Key? key, this.pageController}) : super(key: key);

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  late MyFeedBloc feedBloc;
  late LikePostBloc likePostBloc;

  _dialogRemovePost(Post post,BuildContext context) async{
    var result = await Utils.dialogCommon(context, "Instagram", "Do you want to detele this post?", false);

    if(result){
      likePostBloc.add(RemoveLikePostEvent(post: post));
    }

  }

  @override
  void initState() {
    super.initState();
    feedBloc = context.read<MyFeedBloc>();
    feedBloc.add(LoadFeedPostsEvent());
    // likePostBloc.stream.listen((state) {
    //   if(state is RemoveLikePostSuccessState){
    //     feedBloc.add(LoadFeedPostsEvent());
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyFeedBloc, MyFeedState>(
      listener: (context, state){

      },
      builder: (context, state){
        if(state is MyFeedLoadingState){
          return viewOfMyFeedPage(true,[]);
        }
        if(state is MyFeedSuccessState){
          return viewOfMyFeedPage(false, state.items);
        }
        return viewOfMyFeedPage(false,[]);
      },
    );
  }

  Widget viewOfMyFeedPage(bool isLoading, List<Post> items){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Instagram",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.pageController!.animateToPage(2,
                  duration: Duration(microseconds: 200), curve: Curves.easeIn);
            },
            icon: Icon(Icons.camera_alt),
            color: Color.fromRGBO(193, 53, 132, 1),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return _itemOfPost(items[index]);
            },
          ),
          isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _itemOfPost(Post post) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Divider(),
          //#user info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: post.img_user.isEmpty
                          ? const Image(
                        image: AssetImage("assets/images/ic_person.png"),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        post.img_user,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.fullname,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          post.date,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
                post.mine
                    ? IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    _dialogRemovePost(post,context);
                  },
                )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          //#post image
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onDoubleTap: (){
              if (!post.liked) {
                likePostBloc.add(LikePostEvent(post: post));
              } else {
                likePostBloc.add(UnLikePostEvent(post: post));
              }
            },
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              imageUrl: post.img_post,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),

          //#like share
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (!post.liked) {
                        context.read<LikePostBloc>().add(LikePostEvent(post: post));
                      } else {
                        context.read<LikePostBloc>().add(UnLikePostEvent(post: post));
                      }
                    },
                    icon: BlocBuilder<LikePostBloc, LikeState>(
                      builder: (context, state){
                        return post.liked
                            ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                            : const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                    ),
                  ),
                ],
              )
            ],
          ),

          //#caption
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.visible,
              text: TextSpan(
                  text: post.caption,
                  style: const TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}