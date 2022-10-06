import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwc_movie/Constants/strings.dart';
import 'package:pwc_movie/Data/Models/movies_list.dart';
import 'package:pwc_movie/Logic/Movies_List/cubit/movies_list_cubit.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  MovieListModel? movieListModel;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesListCubit>(context).initDynamicLinks(context);
    movieListModel = BlocProvider.of<MoviesListCubit>(context)
        .getData(title: "Title", pageNumber: 1);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<MoviesListCubit>(context).getData(
              title: "Title",
              pageNumber: BlocProvider.of<MoviesListCubit>(context).page);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Movie Screen"),
        ),
        body: BlocBuilder<MoviesListCubit, MoviesListState>(
          builder: (context, state) {
            var provider = BlocProvider.of<MoviesListCubit>(context);
            if (state is OnComplete) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: provider.textEditingController,
                        onFieldSubmitted: (text) {
                          provider.searchForMovie(
                              title: text, pageNumber: provider.page);
                        },
                      )),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.movies.search.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  movieDetailsScreen,
                                  arguments: state.movies.search[index].imdbId);
                            },
                            leading: SizedBox(
                                child: Image.network(
                              state.movies.search[index].poster.contains("http")
                                  ? state.movies.search[index].poster
                                  : "http://" +
                                      state.movies.search[index].poster,
                              fit: BoxFit.cover,
                              width: 120,
                              height: 80,
                            )),
                            title: Text(state.movies.search[index].title),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
