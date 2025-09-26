import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/ticket.dart';

class TicketModel extends Ticket {
  const TicketModel({
    required super.id,
    required super.title,
    required super.desc,
    required super.status,
    required super.createdBy,
    super.assigneeId,
    required super.photoUrls,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'desc': desc,
    'status': status,
    'createdBy': createdBy,
    'assigneeId': assigneeId,
    'photoUrls': photoUrls,
    'createdAt': createdAt.toUtc(),
  };

  factory TicketModel.fromMap(String id, Map<String, dynamic> m) {
    return TicketModel(
      id: id,
      title: m['title'] ?? '',
      desc: m['desc'] ?? '',
      status: m['status'] ?? 'pending',
      createdBy: m['createdBy'] ?? '',
      assigneeId: m['assigneeId'],
      photoUrls: List<String>.from(m['photoUrls'] ?? const []),
      createdAt: (m['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
