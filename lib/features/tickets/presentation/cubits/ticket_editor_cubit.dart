import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_repository.dart';

class TicketEditorState {
  final bool saving;
  final String? error;
  TicketEditorState({this.saving = false, this.error});
}

class TicketEditorCubit extends Cubit<TicketEditorState> {
  final TicketRepository _repo;
  TicketEditorCubit(this._repo) : super(TicketEditorState());

  Future<void> create(String title, String desc, String createdBy) async {
    emit(TicketEditorState(saving: true));
    try {
      final t = Ticket(
        id: '',
        title: title,
        desc: desc,
        status: 'pending',
        createdBy: createdBy,
        assigneeId: null,
        photoUrls: const [],
        createdAt: DateTime.now(),
      );
      await _repo.create(t);
      emit(TicketEditorState(saving: false));
    } catch (e) {
      emit(TicketEditorState(saving: false, error: e.toString()));
    }
  }

  Future<void> updateStatus(String id, String status, {String? assigneeId}) {
    return _repo.updateStatus(id, status, assigneeId: assigneeId);
  }
}
