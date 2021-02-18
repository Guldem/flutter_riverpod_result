import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod_experiment/util/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel());

class HomeState {
  final String homeText;

  const HomeState(this.homeText);
}

class HomeViewModel extends ChangeNotifier {
  HomeViewModel();

  Result<HomeState> _homeState = Result.success(HomeState("initial"));

  Result<HomeState> get homeViewState => _homeState;

  void setStateText(String text) {
    _homeState = Result.success(HomeState(text));
    notifyListeners();
  }

  Future<void> setStateLoadingText() async {
    _homeState = Result.loading();
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    _homeState = Result.success(HomeState("loaded"));
    notifyListeners();
  }

  void crash() {
    _homeState = Result.error("something went wrong!");
    notifyListeners();
  }
}
