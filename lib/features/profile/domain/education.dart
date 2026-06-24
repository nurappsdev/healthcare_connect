/// A single education entry shown on the education list screen.
class Education {
  const Education({
    required this.subject,
    required this.universityName,
    required this.location,
    required this.from,
    this.to,
  });

  /// e.g. "Civil engineering".
  final String subject;

  /// e.g. "University name here".
  final String universityName;

  /// e.g. "Jakarta, Indonesia".
  final String location;

  final DateTime from;

  /// `null` means the user is still studying ("Continue").
  final DateTime? to;
}
