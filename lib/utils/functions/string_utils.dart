String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();

String truncateWithEllipsis(String text, int maxLength) {
  return (text.length <= maxLength) ? text : '${text.substring(0, maxLength)}...';
}