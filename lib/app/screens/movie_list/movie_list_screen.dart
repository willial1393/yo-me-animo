import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/app/providers/app_provider.dart';
import 'package:movies_app/app/router/router.dart';
import 'package:movies_app/app/screens/movie_list/movie_list_provider.dart';
import 'package:movies_app/app/screens/movie_list/widgets/movie_saved.dart';
import 'package:movies_app/app/types/movie.dart';
import 'package:movies_app/app/widgets/yma_exit_app.dart';
import 'package:movies_app/app/widgets/yma_list_view.dart';
import 'package:movies_app/app/widgets/yma_loading.dart';
import 'package:movies_app/app/widgets/yma_movie_card.dart';
import 'package:movies_app/app/widgets/yma_retry.dart';
import 'package:movies_app/app/widgets/yma_scaffold.dart';

@RoutePage()
class MovieListScreen extends ConsumerStatefulWidget {
  const MovieListScreen({super.key});

  @override
  ConsumerState<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends ConsumerState<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(fetchData(true));
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(appProvider.select((value) => value.language), (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(fetchData(true));
      });
    });
    ref.listen(movieListProvider.select((value) => value.selectedMovieType),
        (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(fetchData(true));
      });
    });
    final movieList = ref.watch(movieListProvider);
    return EScaffold(
      onFloatAction: () async {
        await appRouter.push(const MovieSearchRoute());
      },
      title: 'Películas',
      body: YMAExitApp(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: DropdownButton<MovieType>(
                isExpanded: true,
                value: movieList.selectedMovieType,
                onChanged: (MovieType? value) async {
                  if (value != null) {
                    ref.read(movieListProvider.notifier).setMovieType(value);
                  }
                },
                items: MovieType.values.map((MovieType value) {
                  return DropdownMenuItem<MovieType>(
                    value: value,
                    child: Text(value.humanize),
                  );
                }).toList(),
              ),
            ),
            const MovieSaved(),
            if (movieList.error)
              Expanded(
                child: YMARetry(
                  onRetry: () => unawaited(
                    fetchData(true),
                  ),
                ),
              ),
            if (movieList.selectedMovies.isEmpty && !movieList.error)
              const Expanded(child: YMALoading()),
            if (movieList.selectedMovies.isNotEmpty && !movieList.error)
              Expanded(
                child: YMAListView(
                  onLoadMore: () async => fetchData(false),
                  onRefresh: () async => fetchData(true),
                  itemCount: movieList.selectedMovies.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: YMAMovieCard(
                        movie: movieList.selectedMovies[index],
                        fullDescription: true,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData(bool refresh) async {
    final language = ref.read(appProvider).language;
    await ref.read(movieListProvider.notifier).getMovies(
          refresh: refresh,
          language: language,
        );
  }
}
