// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:burency_demo/_core/services/gcf_service.dart';
import 'package:burency_demo/_core/models/contact_model.dart';

import 'api_commons.dart';

class ContactsController extends GetxController {
  static const String moduleName = 'ContactsController';

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GcfService _gcfService = GcfService.instance;

  int _recordsPerPage = 20;
  int _currentPage = 0;
  String _query = '';
  bool _searchNearby = false;
  double? _latitude;
  double? _longitude;
  int? _radiusInMeters;

  // Observables
  final _contacts = <String, ContactModel>{}.obs;
  final _isLoading = false.obs;
  final _haveMore = true.obs;

  bool get isLoading => _isLoading.value;
  bool get haveMore => _haveMore.value;

  List<ContactModel> get contacts =>
      _contacts.entries.map((e) => e.value).toList();

  ContactModel getContact(String id) {
    if (_contacts.containsKey(id)) {
      return _contacts[id]!;
    }

    return ContactModel();
  }

  Future<void> _fetch(uid) async {
    Map payload = {
      "uid": uid,
      "query": _query,
      "limit": _recordsPerPage,
      "page": _currentPage,
    };

    if (_latitude != null && _longitude != null) {
      payload = {
        ...payload,
        "latitude": _latitude,
        "longitude": _longitude,
      };
    }

    if (_radiusInMeters != null) {
      payload = {
        ...payload,
        "radiusInMeters": _radiusInMeters,
      };
    }

    final resp = await _gcfService.sendRequest(
      route: _searchNearby
          ? ApiRoutes.searchNearbyContact
          : ApiRoutes.searchContact,
      payload: payload,
    );

    if (resp['status'] == HttpResponseCode.ok) {
      final records = List.from(resp['data']['hits'])
          .map((data) => ContactModel.from(data))
          .toList();

      var updatedItems = <String, ContactModel>{};
      for (var entry in _contacts.entries) {
        updatedItems[entry.key] = entry.value;
      }

      for (var record in records) {
        final id = record.id;
        updatedItems.update(
          id,
          (value) => record,
          ifAbsent: () => updatedItems[id] = record,
        );
      }

      _contacts.value = updatedItems;
      _haveMore.value = records.length >= _recordsPerPage;
    }
  }

  Future<void> fetch(
    String uid, {
    int recordsPerPage = 20,
    String query = '',
    bool searchNearby = false,
    double? latitude,
    double? longitude,
    int? radiusInMeters,
  }) async {
    _isLoading.value = true;

    _currentPage = 0;
    _recordsPerPage = recordsPerPage;
    _query = query;
    _searchNearby = searchNearby;
    _latitude = latitude;
    _longitude = longitude;
    _radiusInMeters = radiusInMeters;
    _contacts.clear();

    await _fetch(uid);

    _isLoading.value = false;
  }

  Future<void> fetchMore(String uid, {bool silentRefresh = true}) async {
    _currentPage++;

    if (!silentRefresh) {
      _isLoading.value = true;
    }

    await _fetch(uid);

    if (!silentRefresh) {
      _isLoading.value = false;
    }
  }

  String _translateResponse(dynamic resp) {
    final status = resp['status'] ?? 0;
    if (status != HttpResponseCode.ok) {
      final error = ErrorModel.from(resp['data']);
      return error.message.isNotEmpty ? error.message : error.code;
    }

    return '';
  }

  Future<String> addContact({
    required ContactModel contact,
  }) async {
    _isLoading.value = true;

    final resp = await _gcfService.sendRequest(
      route: ApiRoutes.addContact,
      payload: contact.toJson(),
    );

    _isLoading.value = false;

    return _translateResponse(resp);
  }

  Future<String> updateContact({
    required ContactModel contact,
  }) async {
    _isLoading.value = true;

    final resp = await _gcfService.sendRequest(
      route: ApiRoutes.updateContact,
      payload: contact.toJson(),
    );

    _isLoading.value = false;

    return _translateResponse(resp);
  }

  Future<String> removeContact(String id) async {
    _isLoading.value = true;

    final resp = await _gcfService.sendRequest(
      route: ApiRoutes.deleteContact,
      payload: {
        "id": id,
      },
    );

    _isLoading.value = false;

    return _translateResponse(resp);
  }

  // Real-time fetch using Firestore but not good for large collections
  // void subscribeContacts() {
  //   _isLoading.value = true;

  //   _firestore.collection(dbPath).snapshots().listen(
  //     (querySnapshot) {
  //       // Map<String, ContactModel> contacts = {};

  //       for (var change in querySnapshot.docChanges) {
  //         final id = change.doc.id;
  //         final contact = ContactModel.fromFirestore(
  //           change.doc.data(),
  //           docId: id,
  //         );

  //         switch (change.type) {
  //           case DocumentChangeType.added:
  //           case DocumentChangeType.modified:
  //             // final changeType =
  //             //     change.type == DocumentChangeType.added ? 'NEW' : 'UPD';
  //             // print(">>> $changeType: id=$id ${contact.toJson()}");
  //             _contacts.update(
  //               id,
  //               (value) => contact,
  //               ifAbsent: () => _contacts[id] = contact,
  //             );
  //             break;
  //           case DocumentChangeType.removed:
  //             // print(">>> DEL: id=$id ${contact.toJson()}");
  //             if (_contacts.containsKey(id)) {
  //               _contacts.remove(id);
  //             }
  //             break;
  //           default:
  //             // print("FIRESTORE CHANGE: ${change.type}");
  //             break;
  //         }

  //         _isLoading.value = false;
  //       }
  //     },
  //   );
  // }
}
