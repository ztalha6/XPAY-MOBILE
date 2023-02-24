import 'envs.dart';

class Env {
  final String label;
  final EnvUser? user;
  final String baseUrl;
  final bool prefillForms;

  const Env(
    this.label,
    this.user,
    this.baseUrl, {
    this.prefillForms = false,
  });

  static Env currentEnv = Envs.LocalEnv;
}

class EnvUser {
  final String email;
  final String password;

  const EnvUser(this.email, this.password);
}
