// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repository/user_repository_impl.dart' as _i568;
import '../../data/source/user_source.dart' as _i766;
import '../../data/source/user_source_impl.dart' as _i518;
import '../../domain/repository/user_repository.dart' as _i566;
import '../data/api_client/api_client.dart' as _i1067;
import '../data/request_processor.dart' as _i874;
import 'injectable.dart' as _i1027;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i1067.ApiClient<_i361.Dio>>(
      () => registerModule.dioClient(),
    );
    gh.lazySingleton<_i1067.ApiClient<_i519.Client>>(
      () => registerModule.httpClient(),
    );
    gh.lazySingleton<_i874.RequestProcessor>(() => _i874.RequestProcessor());
    gh.lazySingleton<_i766.UserSource>(
      () => _i518.UserSourceImpl(
        gh<_i1067.ApiClient<_i519.Client>>(),
        gh<_i874.RequestProcessor>(),
      ),
    );
    gh.lazySingleton<_i566.UserRepository>(
      () => _i568.UserRepositoryImpl(gh<_i766.UserSource>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i1027.RegisterModule {}
