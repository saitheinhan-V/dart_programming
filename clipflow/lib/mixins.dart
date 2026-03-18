mixin Searchable {
  String get textContent;

  bool matches(String query) {
    final lowerQuery = query.toLowerCase();
    final lowerContent = textContent.toLowerCase();

    return lowerContent.contains(lowerQuery);
  }
}
