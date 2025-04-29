import 'package:getin/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:getin/features/auth/domain/entities/user_entities.dart';
import 'package:getin/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> signInWithEmail(String email, String password) async {
    final userModel = await remoteDataSource.signInWithEmail(email, password);
    return UserEntity(
      id: userModel.id,
      email: userModel.email,
      name: userModel.name,
    );
  }

  @override
  Future<UserEntity> signUpWithEmail(String email, String password) async {
    final userModel = await remoteDataSource.signUpWithEmail(email, password);
    return UserEntity(
      id: userModel.id,
      email: userModel.email,
      name: userModel.name,
    );
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    final userModel = await remoteDataSource.signInWithGoogle();
    return UserEntity(
      id: userModel.id,
      email: userModel.email,
      name: userModel.name,
    );
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
