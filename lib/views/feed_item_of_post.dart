import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_feed_bloc/item_of_post_bloc/item_post_bloc.dart';
import '../bloc/my_feed_bloc/item_of_post_bloc/item_post_event.dart';
import '../bloc/my_feed_bloc/item_of_post_bloc/item_post_state.dart';
import '../models/post_model.dart';

Widget itemOfPost(BuildContext context, Post post) {
  return BlocProvider(
    create: (context) => ItemPostBloc(),
    child: Container(
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
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.fullname,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 3),
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
                    // feedBloc.dialogRemovePost(context, post);
                    context
                        .read<ItemPostBloc>()
                        .add(RemovePostEvent(context, post));
                  },
                )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          //#post image
          const SizedBox(height: 8),
          GestureDetector(
            onDoubleTap: () {
              if (!post.liked) {
                // apiPostLike(post);
                context.read<ItemPostBloc>().add(LikePostEvent(post));
              } else {
                // apiPostUnLike(post);
                context.read<ItemPostBloc>().add(UnlikePostEvent(post));
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
                  BlocBuilder<ItemPostBloc, ItemPostState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          if(post.liked){
                            context.read<ItemPostBloc>().add(UnlikePostEvent(post));
                          } else {
                            context.read<ItemPostBloc>().add(LikePostEvent(post));

                          }
                        },
                        icon: Icon(post.liked
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: post.liked ? Colors.red : Colors.black,
                      );
                    },
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     context
                  //         .read<LikedBloc>()
                  //         .add(LikedEvent(changeState: post.liked));
                  //   },
                  //   icon: BlocSelector<LikedBloc, LikedState, bool>(
                  //     selector: (state) => state.changeState,
                  //     builder: (context, state) {
                  //       return Icon(
                  //         state ? Icons.favorite : Icons.favorite_border,
                  //         color: state ? Colors.red : Colors.black,
                  //       );
                  //     },
                  //   ),
                  // ),
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
    ),
  );
}