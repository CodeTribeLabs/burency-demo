class HistoryModel {
  String docId;
  String id;
  String type;
  String phone;
  String changes;
  DateTime? timestamp;

  HistoryModel({
    this.docId = '',
    this.id = '',
    this.type = '',
    this.phone = '',
    this.changes = '',
    this.timestamp,
  });

  factory HistoryModel.from(
    dynamic jsonData, {
    String docId = '',
  }) {
    if (jsonData == null) {
      return HistoryModel();
    }

    // {_seconds: 1676711505, _nanoseconds: 697000000}
    final timestamp = jsonData['timestamp'];

    return HistoryModel(
      docId: jsonData['docId'] ?? '',
      id: jsonData['id'] ?? '',
      type: jsonData['type'] ?? '',
      phone: jsonData['phone'] ?? '',
      changes: jsonData['changes'] ?? '',
      timestamp:
          DateTime.fromMillisecondsSinceEpoch(timestamp['_seconds'] * 1000),
    );
  }

  dynamic toJson() => {
        'docId': docId,
        'id': id,
        'type': type,
        'phone': phone,
        'changes': changes,
        'timestamp': timestamp,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
