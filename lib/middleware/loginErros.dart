class SignUpFailure {
  final String message;

  const SignUpFailure([this.message = "Um erro foi detectado. "]);

  factory SignUpFailure.code(String code){
    switch(code){
      case 'Senha fraca':
        return const SignUpFailure('Por favor insira uma senha mais forte. ');
      case 'Email invalido':
        return const SignUpFailure('Email não esta na formatação correta. ');
      case 'Email ja em uso':
        return const SignUpFailure('Uma conta com esse email já existe. ');
      case 'Operação não permitida':
        return const SignUpFailure('Operação não permitida. Contate o suporte. ');
      case 'Usuario Desativado':
        return const SignUpFailure('Esse usuario foi desativado. Contate o suporte. ');
      default:
        return const SignUpFailure('Internal Server Error. Contate o suporte');
    }
  }  
}