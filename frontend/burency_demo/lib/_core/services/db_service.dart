import 'package:cloud_firestore/cloud_firestore.dart';

const _contactsRoute = 'contacts/';

class DbCollection {
  /// CONTACTS ROUTES
  static const contacts = _contactsRoute;
}

class DbService {
  // Define Singleton
  DbService._();
  static final instance = DbService._();

  final dbRef = FirebaseFirestore.instance;

  // static String _getDbRoot({bool useProd = true}) {
  //   return useProd ? '' : '_';
  // }

  // static String _getCollectionRef({
  //   required String collectionName,
  //   bool useProd = true,
  // }) {
  //   String dbRoot = _getDbRoot(useProd: useProd);

  //   switch (collectionName) {
  //     case DbCollection.users:
  //       return dbRoot + collectionName;
  //     default:
  //       return '';
  //   }
  // }

  // static String _getDocRef({required String docName, bool useProd = true,}) {
  //   switch (docName) {
  //     case DbDoc.info:
  //     case DbDoc.adSettings:
  //     case DbDoc.covidStats:
  //       return _getCollectionRef(
  //               collectionName: DbCollection.settings, useProd: useProd) +
  //           '/' +
  //           DbDoc.server +
  //           '/' +
  //           DbCollection.public +
  //           '/' +
  //           docName;
  //     default:
  //       return '';
  //   }
  // }

  // static String getCashInOptionsRef({bool useProd = true}) {
  //   return _getCollectionRef(
  //       collectionName: DbCollection.cashInOptions, useProd: useProd);
  // }

  // static String getCashOutOptionsRef({bool useProd = true}) {
  //   return _getCollectionRef(
  //       collectionName: DbCollection.cashOutOptions, useProd: useProd);
  // }

  // static String _getUserRef({@required String uid, bool useProd = true}) {
  //   return _getCollectionRef(
  //           collectionName: DbCollection.users, useProd: useProd) +
  //       '/' +
  //       uid +
  //       '/' +
  //       DbCollection.public;
  // }

  // static String getUserProfileRef({@required String uid, bool useProd = true}) {
  //   return _getUserRef(uid: uid, useProd: useProd) + '/' + DbDoc.userProfile;
  // }

  // static String getUserOnePassRef({@required String uid, bool useProd = true}) {
  //   return _getUserRef(uid: uid, useProd: useProd) + '/' + DbDoc.userOnePass;
  // }

  // // static String getUserCashInsRef({@required String uid, bool useProd = true}) {
  // //   return _getUserRef(uid: uid, useProd: useProd) + '/' + DbCollection.userCashIns;
  // // }
  // //
  // // static String getUserCashOutsRef({@required String uid, bool useProd = true}) {
  // //   return _getUserRef(uid: uid, useProd: useProd) + '/' + DbCollection.userCashOuts;
  // // }

  // // static String getUserNotificationsRef({@required String uid, bool useProd = true}) {
  // //   return _getUserRef(uid: uid, useProd: useProd) + '/' + DbCollection.userNotifications;
  // // }

  // static String getServerInfoRef({bool useProd = true}) {
  //   return _getDocRef(docName: DbDoc.info, useProd: useProd);
  // }

  // static String getServerCovidStatsRef({bool useProd = true}) {
  //   return _getDocRef(docName: DbDoc.covidStats, useProd: useProd);
  // }

  // static String getServerAdSettingsRef({bool useProd = true}) {
  //   return _getDocRef(docName: DbDoc.adSettings, useProd: useProd);
  // }

  // static String getVenueDocRef(
  //     {@required venueId, @required String docName, bool useProd = true}) {
  //   switch (docName) {
  //     case DbDoc.dailyVisitorStats:
  //     case DbDoc.monthlyVisitorStats:
  //       return _getCollectionRef(
  //               collectionName: DbCollection.venues, useProd: useProd) +
  //           '/' +
  //           venueId +
  //           '/' +
  //           DbCollection.public +
  //           '/' +
  //           docName;
  //     default:
  //       return '';
  //   }
  // }

  // Future<void> setData({String path, Map<String, dynamic> data}) async {
  //   final reference = dbRef.doc(path);
  //   print('$path: $data');
  //   await reference.set(data);
  // }

  Stream documentStream(String path) {
    return dbRef.doc(path).snapshots();
  }

  Future<List<QueryDocumentSnapshot>> getPaginatedData({
    required String path,
    QueryDocumentSnapshot? startAfter,
    String orderBy = '',
    bool descending = true,
    int limit = 10,
  }) {
    final dataRef = dbRef.collection(path);

    Query query = dataRef.limit(limit);

    if (orderBy.isNotEmpty) {
      query = query.orderBy(orderBy, descending: descending);
    }

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return query.get().then((querySnapshot) => querySnapshot.docs);
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function({Map<String, dynamic> data, String docId}) builder,
    dynamic whereField,
    dynamic isEqualTo,
    String orderBy = '',
    bool descending = false,
    int limit = 0,
  }) {
    final dataRef = dbRef.collection(path);
    Query? query;
    Stream<QuerySnapshot> snapshots;

    if (whereField != null) {
      if (isEqualTo != null) {
        query = dataRef.where(whereField, isEqualTo: true);
      }
    }

    if (orderBy.isNotEmpty) {
      if (query == null) {
        query = dataRef.orderBy(orderBy, descending: descending);
      } else {
        query = query.orderBy(orderBy, descending: descending);
      }
    }

    if (limit > 0) {
      if (query == null) {
        query = dataRef.limit(limit);
      } else {
        query = query.limit(limit);
      }
    }

    if (query != null) {
      snapshots = query.snapshots();
    } else {
      snapshots = dataRef.snapshots();
    }

    return snapshots.map(
      (snapshot) => snapshot.docs
          .map(
            (snap) => builder(
              data: snap.data() as Map<String, dynamic>,
              docId: snap.id,
            ),
          )
          .toList(),
    );
  }
}
