import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_app/application/home/home_bloc.dart';
import 'package:image_app/injection.dart';
import 'package:image_app/presentation/home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) =>
            getIt<HomeBloc>()..add(const HomeEvent.getImages()),
        child: const HomePage(),
      ),
    );
  }
}
