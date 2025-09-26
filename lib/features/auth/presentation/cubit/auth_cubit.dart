import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/app_user.dart';

abstract class AuthState {}
class AuthInitial extends AuthState {}
class Authenticated extends AuthState { final AppUser user; Authenticated(this.user); }
class Unauthenticated extends AuthState {}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repo;
  AuthCubit(this._repo) : super(AuthInitial());

  void bootstrap() {
    _repo.authStateChanges().listen((u) {
      if (u == null) emit(Unauthenticated());
      else emit(Authenticated(u));
    });
  }

  Future<void> signIn(String email, String password) async {
    await _repo.signInWithEmail(email, password);
  }

  Future<void> signOut() => _repo.signOut();
}
