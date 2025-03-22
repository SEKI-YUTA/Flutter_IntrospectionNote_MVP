class IntrospectionNote {
  final String? id;
  final DateTime date;
  final List<String> positiveParts;
  final List<String> improvementParts;
  final String dailyComment;

  IntrospectionNote({
    this.id,
    required this.date,
    required this.positiveParts,
    required this.improvementParts,
    required this.dailyComment,
  });
}
