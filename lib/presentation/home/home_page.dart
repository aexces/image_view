import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_app/application/home/home_bloc.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_app/presentation/view/view_page.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        state.failureOrSuccessOption.fold(
          () => {},
          (a) => a.fold(
            (l) => FlushbarHelper.createError(
              message: l.map(
                serverFailure: (_) => "Something went wrong",
                clientFailure: (_) => "Client failure",
              ),
            ).show(context),
            (r) => null,
          ),
        );
        controller.addListener(() {
          if (controller.position.maxScrollExtent ==
              controller.position.pixels) {
            if (!state.isLoading) {
              context.read<HomeBloc>().add(const HomeEvent.getImagesNextPage());
            }
          }
        });
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: state.showTextField
                ? TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    onChanged: (value) => context
                        .read<HomeBloc>()
                        .add(HomeEvent.searchKeyChanged(value)),
                    onFieldSubmitted: (_) => context
                        .read<HomeBloc>()
                        .add(const HomeEvent.getImages()),
                  )
                : const Text("Pixabay"),
            actions: [
              if (state.isNextPageLoading)
                const SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                      child: CircularProgressIndicator(color: Colors.white)),
                ),
              state.showTextField
                  ? IconButton(
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(const HomeEvent.hideTextField());
                        context
                            .read<HomeBloc>()
                            .add(const HomeEvent.searchKeyChanged(""));
                        context
                            .read<HomeBloc>()
                            .add(const HomeEvent.getImages());
                      },
                      icon: const Icon(Icons.close))
                  : IconButton(
                      onPressed: () => context
                          .read<HomeBloc>()
                          .add(const HomeEvent.showTextField()),
                      icon: const Icon(Icons.search),
                    ),
            ],
          ),
          body: state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GridView(
                  controller: controller,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  children: List.generate(
                    state.images.length,
                    (index) => GestureDetector(
                      child: Image.network(
                        state.images[index].image ?? "",
                        fit: BoxFit.cover,
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ViewPage(state.images[index].largeImage ?? ""),
                      )),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
