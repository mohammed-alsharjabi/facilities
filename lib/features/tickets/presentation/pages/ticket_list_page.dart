import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubits/ticket_list_cubit.dart';
import '../cubits/ticket_editor_cubit.dart';
import 'ticket_form_page.dart';
import 'ticket_details_page.dart';
import '../../../../core/di/service_locator.dart';

class TicketListPage extends StatelessWidget {
  const TicketListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthCubit>().state as Authenticated).user;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<TicketListCubit>()..watch(createdBy: user.role == 'requester' ? user.uid : null)),
        BlocProvider(create: (_) => sl<TicketEditorCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('البلاغات'),
          actions: [
            IconButton(icon: const Icon(Icons.logout), onPressed: () => context.read<AuthCubit>().signOut()),
          ],
        ),
        floatingActionButton: user.role == 'requester' ? FloatingActionButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TicketFormPage())),
          child: const Icon(Icons.add),
        ) : null,
        body: BlocBuilder<TicketListCubit, TicketListState>(
          builder: (context, state) {
            if (state.loading) return const Center(child: CircularProgressIndicator());
            if (state.items.isEmpty) return const Center(child: Text('لا توجد بلاغات'));
            return ListView.separated(
              itemCount: state.items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final t = state.items[i];
                return ListTile(
                  title: Text(t.title),
                  subtitle: Text('${t.status} • ${t.createdAt}'),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TicketDetailsPage(ticket: t))),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
