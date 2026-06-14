// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/di/register_module.dart' as _i854;
import 'core/network/network_info.dart' as _i75;
import 'features/auth/data/datasources/auth_remote_datasource.dart' as _i588;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;
import 'features/auth/domain/usecases/sign_in.dart' as _i529;
import 'features/auth/domain/usecases/sign_out.dart' as _i872;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i75.NetworkInfo>(
      () => _i75.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i588.AuthRemoteDataSource>(
      () => _i588.AuthRemoteDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i1015.AuthRepository>(
      () => _i111.AuthRepositoryImpl(
        remoteDataSource: gh<_i588.AuthRemoteDataSource>(),
        networkInfo: gh<_i75.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i529.SignIn>(
      () => _i529.SignIn(gh<_i1015.AuthRepository>()),
    );
    gh.lazySingleton<_i872.SignOut>(
      () => _i872.SignOut(gh<_i1015.AuthRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i854.RegisterModule {}
