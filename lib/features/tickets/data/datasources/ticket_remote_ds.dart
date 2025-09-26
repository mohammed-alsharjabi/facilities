import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../data/models/ticket_model.dart';
import 'package:firebase_functions/firebase_functions.dart';
import 'package:cloud_functions/cloud_functions.dart';
class TicketRemoteDataSource {
  final FirebaseFirestore _fs;
  final FirebaseStorage _stg;
  final FirebaseFunctions _fn; // جاهز للاستخدام لاحقًا (تنبيهات/تريجرز)

  TicketRemoteDataSource(this._fs, this._stg, this._fn);

  CollectionReference<Map<String, dynamic>> get _col =>
      _fs.collection('tickets');

  Stream<List<TicketModel>> watchTickets({
    String? status,
    String? assigneeId,
    String? createdBy,
  }) {
    Query<Map<String, dynamic>> q =
    _col.orderBy('createdAt', descending: true);
    if (status != null) q = q.where('status', isEqualTo: status);
    if (assigneeId != null) q = q.where('assigneeId', isEqualTo: assigneeId);
    if (createdBy != null) q = q.where('createdBy', isEqualTo: createdBy);

    return q.snapshots().map((s) =>
        s.docs.map((d) => TicketModel.fromMap(d.id, d.data())).toList());
  }

  Future<String> uploadPhoto(
      String ticketId,
      String path,
      List<int> bytes,
      ) async {
    final ext = _inferExt(path); // jpg/png/...
    final contentType = ext == 'png' ? 'image/png' : 'image/jpeg';
    final filename = '${DateTime.now().millisecondsSinceEpoch}.$ext';
    final ref = _stg.ref().child('tickets/$ticketId/$filename');

    // التحويل المطلوب لـ Uint8List
    final data = bytes is Uint8List ? bytes : Uint8List.fromList(bytes);

    final task = await ref.putData(
      data,
      SettableMetadata(contentType: contentType),
    );
    return await task.ref.getDownloadURL();
  }

  Future<void> createTicket(TicketModel t) async {
    await _col.add(t.toMap());
  }

  Future<void> updateStatus(
      String id,
      String status, {
        String? assigneeId,
      }) async {
    await _col.doc(id).update({'status': status, 'assigneeId': assigneeId});
  }

  String _inferExt(String path) {
    final i = path.lastIndexOf('.');
    if (i == -1 || i == path.length - 1) return 'jpg';
    final e = path.substring(i + 1).toLowerCase();
    const allowed = {'jpg', 'jpeg', 'png', 'webp', 'heic', 'heif'};
    return allowed.contains(e) ? (e == 'jpeg' ? 'jpg' : e) : 'jpg';
  }
}
