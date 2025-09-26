import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/tickets/presentation/pages/ticket_list_page.dart';

class MaintixApp extends StatelessWidget {
  const MaintixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()..bootstrap()),
      ],
      child: MaterialApp(
        title: 'Maintix',
        theme: AppTheme.light,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) return const TicketListPage();
            if (state is Unauthenticated) return const LoginPage();
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
