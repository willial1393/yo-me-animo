import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/app/types/movie.dart';
import 'package:movies_app/app/widgets/yma_picture.dart';
import 'package:movies_app/core/models/movie_detail/movie_detail.dart';

class MovieDetailHeader extends StatelessWidget {
  final MovieDetail movie;

  const MovieDetailHeader({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        YMAPicture(
          path: movie.backdropPath?.toMoviePath,
          width: 1.sw,
          height: 0.6.sw,
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.05.sw),
          child: Card(
            child: YMAPicture(
              borderRadius: 8.r,
              path: movie.posterPath.toMoviePath,
              height: 0.4.sw,
              width: 0.26.sw,
            ),
          ),
        )
      ],
    );
  }
}
