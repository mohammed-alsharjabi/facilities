import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _fa;
  FirebaseAuthRepository(this._fa);

  AppUser? _map(User? u, Map<String, dynamic>? data) {
    if (u == null) return null;
    final role = data?['role'] as String? ?? 'requester';
    final name = data?['displayName'] as String? ?? (u.displayName ?? '');
    final email = u.email ?? '';
    return AppUser(uid: u.uid, email: email, displayName: name, role: role);
  }

  @override
  Stream<AppUser?> authStateChanges() async* {
    final fs = FirebaseFirestore.instance;
    await for (final u in _fa.authStateChanges()) {
      if (u == null) {
        yield null;
      } else {
        final snap = await fs.collection('users').doc(u.uid).get();
        yield _map(u, snap.data());
      }
    }
  }

  @override
  Future<AppUser?> currentUser() async {
    final u = _fa.currentUser;
    if (u == null) return null;
    final fs = FirebaseFirestore.instance;
    final d = await fs.collection('users').doc(u.uid).get();
    return _map(u, d.data());
  }

  @override
  Future<AppUser?> signInWithEmail(String email, String password) async {
    final cred = await _fa.signInWithEmailAndPassword(email: email, password: password);
    return currentUser();
  }

  @override
  Future<void> signOut() => _fa.signOut();
}
