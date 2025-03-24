String daysAgo(DateTime? date) {
  if (date == null) {
    return 'Data não disponível'; 
  }
  
  final now = DateTime.now();
  final difference = now.difference(date).inDays;

  if (difference == 0) {
    return 'Atualizado hoje';
  } else if (difference == 1) {
    return 'Atualizado há 1 dia';
  } else {
    return 'Atualizado há $difference dias';
  }
}

