class SessionModel {
  final String? sessionId;
  final String? parameter;
  final String? lastUsed;

  SessionModel({
    this.sessionId,
    this.parameter,
    this.lastUsed,
  });

  SessionModel copyWith({
    String? sessionId,
    String? parameter,
    String? lastUsed,
  }) =>
      SessionModel(
        sessionId: sessionId ?? this.sessionId,
        parameter: parameter ?? this.parameter,
        lastUsed: lastUsed ?? this.lastUsed,
      );

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        sessionId: json["sessionId"],
        parameter: json["parameter"],
        lastUsed: json["lastUsed"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "parameter": parameter,
        "lastUsed": lastUsed,
      };
}
