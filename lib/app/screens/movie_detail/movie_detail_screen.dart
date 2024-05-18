import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/app/providers/app_provider.dart';
import 'package:movies_app/app/router/router.dart';
import 'package:movies_app/app/screens/movie_detail/movie_detail_provider.dart';
import 'package:movies_app/app/screens/movie_detail/widgets/movie_detail_header.dart';
import 'package:movies_app/app/types/date.dart';
import 'package:movies_app/app/widgets/yma_icon_save.dart';
import 'package:movies_app/app/widgets/yma_loading.dart';
import 'package:movies_app/app/widgets/yma_notification.dart';
import 'package:movies_app/app/widgets/yma_scaffold.dart';
import 'package:movies_app/core/interfaces/movie_interface.dart';
import 'package:movies_app/injection.dart';

@RoutePage()
class MovieDetailScreen extends ConsumerStatefulWidget {
  final int id;

  const MovieDetailScreen({required this.id, super.key});

  @override
  ConsumerState<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  bool loading = false;
  bool error = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_fetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(movieDetailProvider);
    final countries =
        movie?.productionCountries.map((e) => e.name).toList().join(', ') ?? '';
    return EScaffold(
      onBack: () {
        appRouter.back();
      },
      floatActionIcon: movie != null
          ? YmaIconSave(
              movie: movie.getMovieList(),
            )
          : null,
      onFloatAction: () => {},
      title: 'Detalle',
      body: Column(
        children: [
          if (movie != null)
            Expanded(
              child: Column(
                children: [
                  MovieDetailHeader(movie: movie),
                  SizedBox(height: 10.h),
                  Text(
                    movie.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(movie.releaseDate.toDateFormat()),
                  SizedBox(height: 10.h),
                  Text('Puntuación: ${movie.voteAverage}'),
                  Text(movie.genres.map((e) => e.name).join(', ')),
                  SizedBox(height: 10.h),
                  Text('Duración: ${movie.runtime} min'),
                  Text('Idioma: ${movie.originalLanguage}'),
                  Text('País: $countries'),
                  SizedBox(height: 10.h),
                  const Text(
                    'Descripción:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15.w),
                      child: SingleChildScrollView(
                        child: Text(movie.overview),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (error)
            Expanded(
              child: Center(
                child: InkWell(
                  onTap: () {
                    appRouter.back();
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Ocurrio un error'),
                          SizedBox(height: 5.h),
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_back_ios),
                              Text('Volver'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (loading) const Expanded(child: YMALoading())
        ],
      ),
    );
  }

  Future<void> _fetch() async {
    setState(() {
      loading = true;
      error = false;
    });
    try {
      final language = ref.watch(appProvider).language;
      final movie = await getIt<MovieInterface>().detail(
        id: widget.id,
        language: language,
      );
      ref.read(movieDetailProvider.notifier).state = movie;
    } catch (e) {
      error = true;
      YMANotification.error('Error al cargar la información');
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }
}
