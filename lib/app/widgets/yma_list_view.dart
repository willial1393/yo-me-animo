import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/app/widgets/yma_loading.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

class YMAListView extends StatefulWidget {
  final ScrollController? controller;
  final VoidFutureCallBack? onRefresh;
  final VoidFutureCallBack? onLoadMore;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double? cacheExtent;
  final Axis scrollDirection;

  const YMAListView({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
    this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.cacheExtent,
    this.scrollDirection = Axis.vertical,
  });

  @override
  State<YMAListView> createState() => _YMAListViewState();
}

class _YMAListViewState extends State<YMAListView> {
  late ScrollController controller;
  late double cacheExtent;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    controller = widget.controller ?? ScrollController();
    cacheExtent = widget.cacheExtent ?? 1.sh;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: widget.onRefresh != null,
      enablePullUp: widget.onLoadMore != null,
      controller: _refreshController,
      scrollController: controller,
      scrollDirection: widget.scrollDirection,
      cacheExtent: cacheExtent,
      onLoading: () async {
        await widget.onLoadMore!().then((value) {
          _refreshController.loadComplete();
        }).catchError((e) {
          _refreshController.loadFailed();
        });
      },
      onRefresh: () async {
        await widget.onRefresh!().then((value) {
          _refreshController.refreshCompleted();
        }).catchError((e) {
          _refreshController.refreshFailed();
        });
      },
      header: const EListHeader(),
      footer: const EListFooter(),
      child: ListView.builder(
        scrollDirection: widget.scrollDirection,
        cacheExtent: cacheExtent,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
      ),
    );
  }
}

class EListHeader extends StatelessWidget {
  const EListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClassicHeader(
      refreshingIcon: Padding(
        padding: EdgeInsets.all(10),
        child: YMALoading(),
      ),
      refreshingText: '',
    );
  }
}

class EListFooter extends StatelessWidget {
  const EListFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClassicFooter(
      loadingIcon: Padding(
        padding: EdgeInsets.all(10),
        child: YMALoading(),
      ),
      loadingText: '',
    );
  }
}
