// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_paginate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListPaginate _$MovieListPaginateFromJson(Map<String, dynamic> json) =>
    MovieListPaginate(
      page: (json['page'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieListPaginateToJson(MovieListPaginate instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
      'results': instance.results,
    };
