import 'package:design_system/src/atoms/empty.dart';
import 'package:flutter/material.dart';

class EveScrollWidget extends StatelessWidget {
  final List<Widget> children;
  final List<Widget>? bottomWidgets;
  final CrossAxisAlignment crossAxisAlignment;

  const EveScrollWidget({
    required this.children,
    this.bottomWidgets,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: crossAxisAlignment,
                    children: bottomWidgets ?? [const EmptyWidget()],
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
