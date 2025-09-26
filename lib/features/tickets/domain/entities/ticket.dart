class Ticket {
  final String id;
  final String title;
  final String desc;
  final String status; // pending/assigned/in_progress/done
  final String createdBy;
  final String? assigneeId;
  final List<String> photoUrls;
  final DateTime createdAt;

  const Ticket({
    required this.id,
    required this.title,
    required this.desc,
    required this.status,
    required this.createdBy,
    this.assigneeId,
    required this.photoUrls,
    required this.createdAt,
  });
}
