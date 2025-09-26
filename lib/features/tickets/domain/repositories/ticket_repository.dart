import '../entities/ticket.dart';

abstract class TicketRepository {
  Stream<List<Ticket>> watchTickets({String? status, String? assigneeId, String? createdBy});
  Future<void> create(Ticket t);
  Future<void> updateStatus(String id, String status, {String? assigneeId});
}
