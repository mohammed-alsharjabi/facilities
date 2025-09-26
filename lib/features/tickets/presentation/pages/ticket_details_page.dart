import 'package:flutter/material.dart';
import '../../domain/entities/ticket.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/ticket_editor_cubit.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class TicketDetailsPage extends StatelessWidget {
  final Ticket ticket;
  const TicketDetailsPage({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthCubit>().state as Authenticated).user;
    final canProgress = user.role == 'technician' || user.role == 'admin';
    return Scaffold(
      appBar: AppBar(title: Text(ticket.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(ticket.desc),
          const SizedBox(height: 12),
          Text('الحالة: ${ticket.status}'),
          const Spacer(),
          if (canProgress)
            Row(children: [
              ElevatedButton(
                onPressed: () => context.read<TicketEditorCubit>().updateStatus(ticket.id, 'in_progress'),
                child: const Text('بدء العمل'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () => context.read<TicketEditorCubit>().updateStatus(ticket.id, 'done'),
                child: const Text('إغلاق'),
              ),
            ]),
        ]),
      ),
    );
  }
}
