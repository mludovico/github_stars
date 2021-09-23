import 'package:get_it/get_it.dart';
import 'package:github_stars/app/list/domain/entities/user.dart';
import 'package:github_stars/app/list/presenter/usecases/list_usecases.dart';
import 'package:mobx/mobx.dart';

part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {
  @observable
  String? searchText;

  @action
  void setSearchText(String value) {
    searchText = value;
    search();
  }

  @observable
  bool searchVisible = false;

  @action
  void toggleSearchVisible() {
    searchVisible = !searchVisible;
    if (searchVisible) {
      selected = null;
      list.clear();
    }
  }

  @observable
  bool loading = false;

  @observable
  String? error;

  ObservableList<User> list = ObservableList<User>();

  @observable
  int? selected;

  @action
  void setSelected(int index) => selected = index;

  @action
  Future<void> search() async {
    loading = true;
    final useCase = GetIt.I<SearchUsers>();
    try {
      final retrievedUser = await useCase(searchText!);
      list.clear();
      list.addAll(retrievedUser);
    } catch (e) {
      error = e.toString();
    }
    loading = false;
  }
}
