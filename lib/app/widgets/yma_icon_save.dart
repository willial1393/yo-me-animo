import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/app/screens/movie_list/movie_list_provider.dart';
import 'package:movies_app/app/widgets/yma_loading.dart';
import 'package:movies_app/app/widgets/yma_notification.dart';
import 'package:movies_app/core/models/movie_list/movie_list.dart';

class YmaIconSave extends ConsumerStatefulWidget {
  final MovieList movie;

  const YmaIconSave({required this.movie, super.key});

  @override
  ConsumerState<YmaIconSave> createState() => _YmaIconSaveState();
}

class _YmaIconSaveState extends ConsumerState<YmaIconSave> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final saved = ref.watch(
      movieListProvider.select(
        (value) => value.isSaved(widget.movie),
      ),
    );
    if (loading) {
      return const YMALoading(small: true);
    }
    return InkWell(
      onTap: save,
      child: Icon(
        saved ? Icons.favorite : Icons.favorite_border,
      ),
    );
  }

  Future<void> save() async {
    setState(() {
      loading = true;
    });
    try {
      await ref.read(movieListProvider.notifier).saveMovie(widget.movie);
    } catch (e) {
      YMANotification.error('Error al guardar la película');
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }
}
