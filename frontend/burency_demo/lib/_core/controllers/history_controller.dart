import 'package:get/get.dart';

import 'package:burency_demo/_core/services/gcf_service.dart';
import 'package:burency_demo/_core/models/history_model.dart';
import 'api_commons.dart';

class HistoryController extends GetxController {
  static const String moduleName = 'HistoryController';

  final GcfService _gcfService = GcfService.instance;

  int _recordsPerPage = 20;
  int _currentPage = 0;

  // Observables
  final _history = <String, HistoryModel>{}.obs;
  final _isLoading = false.obs;
  final _haveMore = true.obs;

  bool get isLoading => _isLoading.value;
  bool get haveMore => _haveMore.value;

  List<HistoryModel> get historyList =>
      _history.entries.map((e) => e.value).toList();

  HistoryModel getHistory(String id) {
    if (_history.containsKey(id)) {
      return _history[id]!;
    }

    return HistoryModel();
  }

  Future<void> _fetch(String id) async {
    final resp = await _gcfService.sendRequest(
      route: ApiRoutes.searchHistory,
      payload: {
        "id": id,
        "sortDesc": true,
        "limit": _recordsPerPage,
        "page": _currentPage,
      },
    );

    if (resp['status'] == HttpResponseCode.ok) {
      final records = List.from(resp['data'])
          .map((data) => HistoryModel.from(data))
          .toList();

      var updatedItems = <String, HistoryModel>{};
      for (var entry in _history.entries) {
        updatedItems[entry.key] = entry.value;
      }

      for (var record in records) {
        final id = record.docId;
        updatedItems.update(
          id,
          (value) => record,
          ifAbsent: () => updatedItems[id] = record,
        );
      }

      _history.value = updatedItems;
      _haveMore.value = records.length >= _recordsPerPage;
    } else {
      _haveMore.value = false;
    }
  }

  Future<void> fetch(String id, {int recordsPerPage = 20}) async {
    _isLoading.value = true;

    _currentPage = 0;
    _recordsPerPage = recordsPerPage;
    _history.clear();

    await _fetch(id);

    _isLoading.value = false;
  }

  Future<void> fetchMore(String id, {bool silentRefresh = true}) async {
    _currentPage++;

    if (!silentRefresh) {
      _isLoading.value = true;
    }

    await _fetch(id);

    if (!silentRefresh) {
      _isLoading.value = false;
    }
  }
}
