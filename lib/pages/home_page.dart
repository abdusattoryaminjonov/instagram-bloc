import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclon/bloc/my_like_bloc/like_bloc.dart';
import '../bloc/home_bloc/home_bloc.dart';
import '../bloc/home_bloc/home_event.dart';
import '../bloc/home_bloc/home_state.dart';
import '../bloc/my_feed_bloc/feed_bloc.dart';
import 'my_feed_page.dart';
import 'my_likes_page.dart';
import 'my_profile_page.dart';
import 'my_search_page.dart';
import 'my_upload_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();

    homeBloc = BlocProvider.of<HomeBloc>(context);

    homeBloc.pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state){
        return Scaffold(
          body: PageView(
            controller: homeBloc.pageController,
            children: [
              BlocProvider(
                create: (context) => FeedBloc(),
                child: MyFeedPage(pageController: homeBloc.pageController),
              ),
              const MySearchPage(),
              MyUploadPage(pageController: homeBloc.pageController),
              BlocProvider(
                create: (context) => LikeBloc(),
                child: MyLikesPage(pageController: homeBloc.pageController),
              ),
              const MyProfilePage(),
            ],
            onPageChanged: (int index) {
              homeBloc.add(HomePageChangedEvent(index));
            },
          ),
          bottomNavigationBar: CupertinoTabBar(
            onTap: (int index) {
              homeBloc.add(HomeAnimateToPageEvent(index));
            },
            currentIndex: homeBloc.currentTap,
            activeColor: const Color.fromRGBO(193, 53, 132, 1),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 32),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 32),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box, size: 32),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 32),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 32),
              )
            ],
          ),
        );
      },
    );
  }
}