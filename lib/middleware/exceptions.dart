class TExceptions implements Exception{
  final String message;
  const TExceptions([this.message = 'Uma excessão ocorreu.']);

  factory TExceptions.fromCode(String code){
    switch (code){
      case 'email-already-in-use':
        return const TExceptions("Email ja esta em uso.");
      case 'invalid-email':
        return const TExceptions("Email invalido.");
      case 'weak-password':
        return const TExceptions("Senha está muito fraca.");
      case 'user-disable':
        return const TExceptions("Usuario desativado.");
      case 'user-not-found':
        return const TExceptions("Usuario não encontrado na base de dados.");
      case 'wrong-password':
        return const TExceptions("Senha incorreta.");
      case 'too-many-requests':
        return const TExceptions("Muitas requisições, aguarde um momento.");
      case 'invalid-argument':
        return const TExceptions("Argumentos invalidos.");
      case 'invalid-password':
        return const TExceptions("Senha utilizada invalida.");
      case 'invalid-phone-number':
        return const TExceptions("Numero de telefone invalido.");
      case 'operation-not-allowed':
        return const TExceptions("Operação não permitida para o usuario.");
      case 'session-cookie-expired':
        return const TExceptions("Sessão expirada.");
      case 'uid-already-exists':
        return const TExceptions("Usuario ja cadastrado.");
      default:
        return const TExceptions();
    }
  }
}