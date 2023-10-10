import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:numbertrivia/core/util/input_convertor.dart';
import 'package:numbertrivia/features/numberTrivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:numbertrivia/features/numberTrivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:numbertrivia/features/numberTrivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:numbertrivia/features/numberTrivia/domain/repositories/number_trivia_repository.dart';
import 'package:numbertrivia/features/numberTrivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:numbertrivia/features/numberTrivia/domain/usecases/get_random_number_trivia.dart';
import 'package:numbertrivia/features/numberTrivia/presentation/bloc/bloc.dart';
import 'package:numbertrivia/network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory<NumberTriviaBloc>(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl(),
    ),
  );

  //Use cases

  sl.registerLazySingleton<GetConcreteNumberTrivia>(
      () => GetConcreteNumberTrivia(repository: sl()));
  sl.registerLazySingleton<GetRandomNumberTrivia>(
      () => GetRandomNumberTrivia(repository: sl()));

//Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

//Data sources

  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

//core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: sl()));

//External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
