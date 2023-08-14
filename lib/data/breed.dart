class Breed {
  final Map<String, List<String>> message;
  final String status;

  Breed({required this.message, required this.status});

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      message: Map.from(json['message'])
          .map((key, value) => MapEntry(key, List<String>.from(value))),
      status: json['status'],
    );
  }
}
