import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclon/bloc/splash_bloc/splash_event.dart';
import 'package:instaclon/bloc/splash_bloc/splash_state.dart';
import '../bloc/splash_bloc/splash_bloc.dart';


class SplashPage extends StatefulWidget {
  static const String id = "splash_page";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashBloc splashBloc;

  @override
  void initState() {
    super.initState();
    splashBloc = BlocProvider.of<SplashBloc>(context);

    splashBloc.add(SplashWaitEvent());
    splashBloc.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context,state){
        if(state is SplashLoadedState){
          splashBloc.callNextPage(context);
        }
      },
      builder: (context,state){
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(193, 53, 132, 1),
                      Color.fromRGBO(131, 58, 180, 1),
                    ]
                )
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "Instagram",
                    style: TextStyle(
                        fontSize: 45, fontFamily: "Billabong", color: Colors.white),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          "All rights reserved",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
