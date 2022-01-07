import 'package:design_system/src/atoms/empty_widget.dart';
import 'package:flutter/material.dart';

class EveInfiniteRefreshScrollWidget extends StatefulWidget {
  /// Future function that triggers when the bottom of the list in reached
  /// This function should fetch more data to increase the list (pagination)
  final Future Function()? onLoadMore;

  /// Future function that triggers when the top of the page is pulled
  /// This function should refresh all the page's data
  final Future Function()? onRefresh;

  /// Signals that the list is still loading
  /// Helpful in cases where you want to only put the list
  /// on loading while showing other widgets
  final bool isListLoading;

  /// Signals that there's more data to load
  /// If false, the widget will not trigger the onLoadMore anymore
  /// and will show the finishedLoadingWidget if it exists
  final bool hasMore;

  /// Adds a padding to the internal list (the one built by the itemBuilder)
  final EdgeInsets? listPadding;

  /// Widget that is shown when there's no more data to load
  final Widget? finishedLoadingWidget;

  /// Widget that is shown above the list
  final Widget? fixedWidget;

  /// Bias to control when the onLoadMore should be triggered
  /// Defaults to 0.9, so when the user is near the bottom of the list
  /// the onLoadMore is triggered
  final double triggerOffsetBias;

  /// Size of the list that the widget showing
  final int itemCount;

  /// Function to build each item of the list
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// Function to build the separator of the items of the list
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  const EveInfiniteRefreshScrollWidget({
    Key? key,
    this.onLoadMore,
    this.onRefresh,
    this.isListLoading = false,
    this.hasMore = true,
    this.listPadding,
    this.finishedLoadingWidget,
    this.fixedWidget,
    this.triggerOffsetBias = 0.9,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScrollState();
}

class _ScrollState extends State<EveInfiniteRefreshScrollWidget> {
  final _controller = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    if (widget.onLoadMore != null) {
      _controller.addListener(() async {
        if (_controller.offset <
                _controller.position.maxScrollExtent *
                    (widget.triggerOffsetBias) ||
            widget.hasMore != true ||
            _isLoadingMore) {
          return;
        }
        setState(() {
          _isLoadingMore = true;
        });
        await widget.onLoadMore!();
        setState(() {
          _isLoadingMore = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.onRefresh != null
      ? RefreshIndicator(onRefresh: widget.onRefresh!, child: _createList())
      : _createList();

  Widget _createList() => ListView(
        controller: _controller,
        physics: BouncingScrollPhysics(
          parent: widget.onRefresh != null
              ? const AlwaysScrollableScrollPhysics()
              : null,
        ),
        shrinkWrap: true,
        children: [
          widget.fixedWidget ?? const EmptyWidget(),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: widget.listPadding,
            itemBuilder: widget.itemBuilder,
            separatorBuilder:
                widget.separatorBuilder ?? (_, __) => const EmptyWidget(),
            itemCount: widget.itemCount,
          ),
          if (_isLoadingMore || widget.isListLoading) _loading,
          if (widget.finishedLoadingWidget != null && !widget.hasMore)
            widget.finishedLoadingWidget!,
        ],
      );

  Widget get _loading => const Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: CircularProgressIndicator(),
        ),
      );
}
