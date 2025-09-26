import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../datasources/ticket_remote_ds.dart';
import '../models/ticket_model.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource _ds;
  TicketRepositoryImpl(this._ds);

  @override
  Stream<List<Ticket>> watchTickets({String? status, String? assigneeId, String? createdBy}) {
    return _ds.watchTickets(status: status, assigneeId: assigneeId, createdBy: createdBy);
  }

  @override
  Future<void> create(Ticket t) async {
    await _ds.createTicket(TicketModel(
      id: t.id,
      title: t.title,
      desc: t.desc,
      status: t.status,
      createdBy: t.createdBy,
      assigneeId: t.assigneeId,
      photoUrls: t.photoUrls,
      createdAt: t.createdAt,
    ));
  }

  @override
  Future<void> updateStatus(String id, String status, {String? assigneeId}) {
    return _ds.updateStatus(id, status, assigneeId: assigneeId);
  }
}
