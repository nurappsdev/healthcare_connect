class FirestorePaths {
  FirestorePaths._();

  static const String users = 'users';

  static String user(String uid) => '$users/$uid';
}
