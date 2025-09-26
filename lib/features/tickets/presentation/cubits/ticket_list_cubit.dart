import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_repository.dart';

class TicketListState {
  final List<Ticket> items;
  final bool loading;
  TicketListState({required this.items, required this.loading});
  TicketListState copyWith({List<Ticket>? items, bool? loading}) =>
      TicketListState(items: items ?? this.items, loading: loading ?? this.loading);
}

class TicketListCubit extends Cubit<TicketListState> {
  final TicketRepository _repo;
  var _sub;
  TicketListCubit(this._repo) : super(TicketListState(items: const [], loading: true));

  void watch({String? status, String? assigneeId, String? createdBy}) {
    _sub?.cancel();
    emit(state.copyWith(loading: true));
    _sub = _repo.watchTickets(status: status, assigneeId: assigneeId, createdBy: createdBy).listen((list) {
      emit(TicketListState(items: list, loading: false));
    });
  }

  @override
  Future<void> close() { _sub?.cancel(); return super.close(); }
}
