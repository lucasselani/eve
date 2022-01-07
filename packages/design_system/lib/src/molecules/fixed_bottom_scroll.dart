import 'package:design_system/src/atoms/empty_widget.dart';
import 'package:flutter/material.dart';

class EveScrollWidget extends StatelessWidget {
  final Widget child;
  final Widget? bottomWidget;

  const EveScrollWidget({required this.child, this.bottomWidget, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(child: child),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: bottomWidget ?? const EmptyWidget(),
                ),
              )
            ],
          ),
        ),
      );
}
