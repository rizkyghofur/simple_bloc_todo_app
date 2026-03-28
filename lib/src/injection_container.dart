import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'core/network/dio_client.dart';
import 'data/datasource/todo_remote_datasource.dart';
import 'data/repository/todo_repository_impl.dart';
import 'domain/repositories/todo_repository.dart';
import 'domain/usecase/todo/get_todo_usecase.dart';
import 'domain/usecase/todo/detail_todo_usecase.dart';
import 'domain/usecase/todo/search_todo_usecase.dart';
import 'presentation/bloc/todo/todo_bloc.dart';
import 'presentation/bloc/todo_detail/todo_detail_bloc.dart';
import 'presentation/bloc/network/network_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerLazySingleton(() => TodoBloc(getTodo: sl(), searchTodo: sl()));
  sl.registerLazySingleton(() => TodoDetailBloc(detailTodo: sl()));
  sl.registerFactory(() => NetworkCubit(connectivity: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTodo(sl()));
  sl.registerLazySingleton(() => DetailTodo(sl()));
  sl.registerLazySingleton(() => SearchTodo(sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(dioClient: sl()),
  );

  // External
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton(() => Connectivity());
}
