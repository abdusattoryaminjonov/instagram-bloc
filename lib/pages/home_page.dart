import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclon/bloc/my_like_bloc/like_bloc.dart';
import 'package:instaclon/bloc/myprofile/axis_count_bloc.dart';
import 'package:instaclon/bloc/myprofile/my_photo_bloc.dart';
import 'package:instaclon/bloc/myprofile/my_posts_bloc.dart';
import 'package:instaclon/bloc/myprofile/my_profile_bloc.dart';

import '../bloc/home_bloc/home_bloc.dart';
import '../bloc/home_bloc/home_event.dart';
import '../bloc/home_bloc/home_state.dart';
import '../bloc/my_feed_bloc/feed_bloc.dart';
import '../bloc/my_feed_bloc/item_of_post_bloc/like_bloc.dart';
import '../bloc/my_uploade_bloc/image_picker_bloc.dart';
import '../bloc/my_uploade_bloc/uploade_bloc.dart';
import '../bloc/search_bloc/follow_member_bloc.dart';
import '../bloc/search_bloc/mysearch_bloc.dart';
import '../services/log_service.dart';
import 'my_feed_page.dart';
import 'my_likes_page.dart';
import 'my_profile_page.dart';
import 'my_search_page.dart';
import 'my_upload_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  PageController? _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        LogService.i(state.currentIndex.toString());
      },
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyFeedBloc(),
                  ),
                  BlocProvider(
                    create: (context) => LikePostBloc(),
                  )
                ],
                child: MyFeedPage(
                  pageController: _pageController,
                ),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MySearchBloc(),
                  ),
                  BlocProvider(
                    create: (context) => FollowMemberBloc(),
                  ),
                ],
                child: const MySearchPage(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyUploadBloc(),
                  ),
                  BlocProvider(
                    create: (context) => ImagePickerBloc(),
                  ),
                ],
                child: MyUploadPage(
                  pageController: _pageController,
                ),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyLikeBloc(),
                  ),
                ],
                child: MyLikesPage(),
              ),


              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyProfileBloc(),
                  ),
                  BlocProvider(
                    create: (context) => MyPostsBloc(),
                  ),
                  BlocProvider(
                    create: (context) => AxisCountBloc(),
                  ),
                  BlocProvider(
                    create: (context) => MyPhotoBloc(),
                  ),
                ],
                child: const MyProfilePage(),
              ),
            ],
            onPageChanged: (int index) {
              homeBloc.add(PageViewEvent(currentIndex: index));
            },
          ),
          bottomNavigationBar: CupertinoTabBar(
            onTap: (int index) {
              homeBloc.add(BottomNavEvent(currentIndex: index));
              _pageController!.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            },
            currentIndex: state.currentIndex,
            activeColor: Color.fromRGBO(193, 53, 132, 1),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_box,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  size: 32,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}