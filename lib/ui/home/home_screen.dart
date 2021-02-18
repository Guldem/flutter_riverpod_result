import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod_experiment/ui/home/home_view_model.dart';
import 'package:flutter_riverpod_experiment/util/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(homeViewModelProvider);

    return Center(
      child: ResultContent<HomeState>(
        result: viewModel.homeViewState,
        onRetry: () => context.read(homeViewModelProvider).setStateText("retried!"),
        builder: (innerContext, success) => Column(
          children: [
            Text(success.homeText),
            MaterialButton(
              onPressed: () {
                context
                    .read(homeViewModelProvider)
                    .setStateText("updated text!");
              },
              child: Text("update text!"),
            ),
            MaterialButton(
              onPressed: () {
                context.read(homeViewModelProvider).setStateLoadingText();
              },
              child: Text("load some"),
            ),
            MaterialButton(
              onPressed: () {
                context.read(homeViewModelProvider).crash();
              },
              child: Text("woepsie"),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultContent<T> extends StatelessWidget {
  final Result<T> result;
  final Widget Function(BuildContext context, T success) builder;
  final Function onRetry;

  const ResultContent({
    @required this.result,
    @required this.builder,
    this.onRetry,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return result.map(
      success: (success) => builder(context, success.value),
      loading: (_) => CircularProgressIndicator(),
      error: (error) => Column(
        children: [
          Text(error.errorMessage),
          if (onRetry != null) ...[
            MaterialButton(
              child: Text("retry"),
              onPressed: onRetry,
            )
          ],
        ],
      ),
    );
  }
}
