enum ClipType {
  textType('🗒️', 'Text'),
  codeType('💻', 'Code'),
  urlType('🔗', 'URL'),
  jsonType('📊', 'JSON');

  final String emoji;
  final String label;

  const ClipType(this.emoji, this.label);
}
