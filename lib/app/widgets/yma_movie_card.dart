import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/app/providers/app_provider.dart';
import 'package:movies_app/app/router/router.dart';
import 'package:movies_app/app/screens/movie_detail/movie_detail_provider.dart';
import 'package:movies_app/app/theme/colors.dart';
import 'package:movies_app/app/types/date.dart';
import 'package:movies_app/app/types/movie.dart';
import 'package:movies_app/app/widgets/yma_icon_save.dart';
import 'package:movies_app/app/widgets/yma_loading.dart';
import 'package:movies_app/app/widgets/yma_picture.dart';
import 'package:movies_app/core/models/movie_list/movie_list.dart';

class YMAMovieCard extends ConsumerWidget {
  final MovieList movie;
  final VoidCallback? onDelete;
  final bool loading;
  final bool fullDescription;

  const YMAMovieCard({
    required this.movie,
    this.onDelete,
    this.loading = false,
    this.fullDescription = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var genres = ref.watch(
      appProvider.select((value) => value.genres),
    );
    if (!fullDescription) {
      genres = genres.sublist(3).toList();
    }
    return InkWell(
      onTap: () async {
        ref.invalidate(movieDetailProvider);
        await appRouter.push(MovieDetailRoute(id: movie.id));
      },
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: EColor.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: YMAPicture(
                  path: movie.posterPath.toMoviePath,
                  fit: BoxFit.fitHeight,
                  height: double.infinity,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (loading) const YMALoading(small: true),
                        YmaIconSave(movie: movie)
                      ],
                    ),
                    Text(
                      movie.releaseDate.toDateFormat(),
                      style: const TextStyle(color: EColor.grey),
                    ),
                    Text(
                      movie.overview,
                      maxLines: fullDescription ? 3 : 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      genres
                          .where((genre) => movie.genreIds.contains(genre.id))
                          .map((genre) => genre.name)
                          .join(', '),
                      style: const TextStyle(color: EColor.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
            ],
          ),
        ),
      ),
    );
  }
}
