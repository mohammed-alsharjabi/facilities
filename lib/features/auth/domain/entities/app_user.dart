class AppUser {
  final String uid;
  final String email;
  final String displayName;
  final String role; // admin, technician, requester

  const AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
  });
}
