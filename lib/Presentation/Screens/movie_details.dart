import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwc_movie/Data/Models/movie_detail.dart';
import 'package:pwc_movie/Logic/Movie_Details/cubit/movie_details_cubit.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String id;
  const MovieDetailsScreen({super.key, required this.id});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieDetailsModel? movie;
  @override
  void initState() {
    super.initState();
    movie = BlocProvider.of<MovieDetailsCubit>(context)
        .getMovieDetials(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Movie Details"),
        ),
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            var provider = BlocProvider.of<MovieDetailsCubit>(context);
            if (state is OnComplete) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(provider.model!.title!),
                      Image.network(provider.model!.poster!),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Year : ${provider.model!.year!}"),
                          Text("Director : ${provider.model!.director!}"),
                        ],
                      ),
                      Text("Actors : ${provider.model!.actors!}"),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<MovieDetailsCubit>(context)
                                .shareLinks(
                                    title: provider.model!.title!,
                                    image: provider.model!.poster!,
                                    docId: provider.model!.imdbId!);
                          },
                          child: const Text("SHARE IT"))
                    ],
                  ),
                ),
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
