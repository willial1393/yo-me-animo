import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/app/screens/movie_list/movie_list_provider.dart';
import 'package:movies_app/app/widgets/yma_movie_card.dart';
import 'package:movies_app/app/widgets/yma_notification.dart';
import 'package:movies_app/core/interfaces/movie_interface.dart';
import 'package:movies_app/core/models/movie_list/movie_list.dart';
import 'package:movies_app/injection.dart';

class MovieSaved extends ConsumerStatefulWidget {
  const MovieSaved({super.key});

  @override
  ConsumerState<MovieSaved> createState() => _MovieSavedState();
}

class _MovieSavedState extends ConsumerState<MovieSaved> {
  bool loading = false;
  final _pageController = PageController(
    viewportFraction: 0.9,
  );

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(
      movieListProvider.select((value) => value.saved),
    );
    if (movies.isEmpty) {
      return const SizedBox();
    }
    return SizedBox(
      height: 0.4.sw,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final data = movies[index];
            final movie = MovieList(
              adult: data.adult,
              backdropPath: data.backdropPath,
              genreIds: data.genreIds,
              id: data.id,
              originalLanguage: data.originalLanguage,
              originalTitle: data.originalTitle,
              overview: data.overview,
              popularity: data.popularity,
              posterPath: data.posterPath,
              releaseDate: data.releaseDate,
              title: data.title,
              video: data.video,
              voteAverage: data.voteAverage,
              voteCount: data.voteCount,
            );
            return YMAMovieCard(
              loading: loading,
              movie: movie,
              onDelete: () async {
                await _remove(data);
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _remove(MovieList data) async {
    setState(() {
      loading = true;
    });
    try {
      await getIt<MovieInterface>().removeMovie(data);
      YMANotification.success('Película eliminada');
    } catch (e) {
      YMANotification.error('Error al eliminar la película');
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }
}
