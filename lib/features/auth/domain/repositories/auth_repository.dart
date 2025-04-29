import 'package:getin/features/auth/domain/entities/user_entities.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithEmail(String email, String password);
  Future<UserEntity> signUpWithEmail(String email, String password);
  Future<UserEntity> signInWithGoogle();
  Future<void> signOut();
}
