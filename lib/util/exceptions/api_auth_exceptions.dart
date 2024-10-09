class BApiAuthException implements Exception {
  final String message;

  BApiAuthException(this.message);

  // String get message{
  //   switch (_message) {
  //     case 'token_not_valid':
  //       return "El token es inválido o ha expirado";
  //     default:
  //       return "";
  //   }
  // }
}
