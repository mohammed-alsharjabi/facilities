import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubits/ticket_editor_cubit.dart';

class TicketFormPage extends StatefulWidget {
  const TicketFormPage({super.key});
  @override
  State<TicketFormPage> createState() => _TicketFormPageState();
}

class _TicketFormPageState extends State<TicketFormPage> {
  final titleC = TextEditingController();
  final descC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthCubit>().state as Authenticated).user;
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء بلاغ')),
      body: BlocConsumer<TicketEditorCubit, TicketEditorState>(
        listener: (context, state) {
          if (!state.saving && state.error == null) Navigator.pop(context);
          if (state.error != null) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              TextField(controller: titleC, decoration: const InputDecoration(labelText: 'العنوان')),
              const SizedBox(height: 12),
              TextField(controller: descC, maxLines: 4, decoration: const InputDecoration(labelText: 'الوصف')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: state.saving ? null : () => context.read<TicketEditorCubit>().create(
                    titleC.text.trim(), descC.text.trim(), user.uid),
                child: state.saving ? const CircularProgressIndicator() : const Text('حفظ'),
              ),
            ]),
          );
        },
      ),
    );
  }
}
