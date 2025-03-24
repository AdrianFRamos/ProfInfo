String limitText(String text, int limit) {
  return text.length > limit ? '${text.substring(0, limit)}...' : text;
}