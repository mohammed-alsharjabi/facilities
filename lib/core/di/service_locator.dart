import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/firebase_auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/tickets/domain/repositories/ticket_repository.dart';
import '../../features/tickets/data/repositories/ticket_repository_impl.dart';
import '../../features/tickets/data/datasources/ticket_remote_ds.dart';

final sl = GetIt.instance;

void initLocator() {
  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => FirebaseMessaging.instance);

  // Auth
  sl.registerLazySingleton<AuthRepository>(
        () => FirebaseAuthRepository(sl()),
  );
  sl.registerFactory(() => AuthCubit(sl()));

  // Tickets
  sl.registerLazySingleton<TicketRemoteDataSource>(
        () => TicketRemoteDataSource(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<TicketRepository>(
        () => TicketRepositoryImpl(sl()),
  );
}
