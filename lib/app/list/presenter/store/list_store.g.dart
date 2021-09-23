// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListStore on _ListStore, Store {
  final _$searchTextAtom = Atom(name: '_ListStore.searchText');

  @override
  String? get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String? value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  final _$searchVisibleAtom = Atom(name: '_ListStore.searchVisible');

  @override
  bool get searchVisible {
    _$searchVisibleAtom.reportRead();
    return super.searchVisible;
  }

  @override
  set searchVisible(bool value) {
    _$searchVisibleAtom.reportWrite(value, super.searchVisible, () {
      super.searchVisible = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ListStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_ListStore.error');

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$selectedAtom = Atom(name: '_ListStore.selected');

  @override
  int? get selected {
    _$selectedAtom.reportRead();
    return super.selected;
  }

  @override
  set selected(int? value) {
    _$selectedAtom.reportWrite(value, super.selected, () {
      super.selected = value;
    });
  }

  final _$searchAsyncAction = AsyncAction('_ListStore.search');

  @override
  Future<void> search() {
    return _$searchAsyncAction.run(() => super.search());
  }

  final _$_ListStoreActionController = ActionController(name: '_ListStore');

  @override
  void setSearchText(String value) {
    final _$actionInfo = _$_ListStoreActionController.startAction(
        name: '_ListStore.setSearchText');
    try {
      return super.setSearchText(value);
    } finally {
      _$_ListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleSearchVisible() {
    final _$actionInfo = _$_ListStoreActionController.startAction(
        name: '_ListStore.toggleSearchVisible');
    try {
      return super.toggleSearchVisible();
    } finally {
      _$_ListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelected(int index) {
    final _$actionInfo = _$_ListStoreActionController.startAction(
        name: '_ListStore.setSelected');
    try {
      return super.setSelected(index);
    } finally {
      _$_ListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchText: ${searchText},
searchVisible: ${searchVisible},
loading: ${loading},
error: ${error},
selected: ${selected}
    ''';
  }
}
