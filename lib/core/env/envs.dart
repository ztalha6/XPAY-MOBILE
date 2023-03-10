// ignore_for_file: constant_identifier_names

import 'env.dart';

class Envs {
  static const Env LocalEnv = Env(
    'Local',
    EnvUsers.user2,
    'http://192.168.1.105:4020/api/v1/',
    prefillForms: true,
  );
  static const Env StagingEnv = Env(
    'Staging',
    EnvUsers.user1,
    'https://serveeasy-staging.tekrevol.com/api/v1/',
    prefillForms: true,
  );
  static const Env ProductionEnv = Env(
    'Production',
    null,
    '',
  );

  static const List<Env> envs = [
    LocalEnv,
    StagingEnv,
  ];
}

class EnvUsers {
  static const EnvUser user1 = EnvUser(
    'talha.siddique@tekrevol.com',
    '12345678',
  );
  static const EnvUser user2 = EnvUser(
    'waqar4@yopmail.com',
    'Demo@123',
  );
  /* You can create new users as many as you want like above. */
}
