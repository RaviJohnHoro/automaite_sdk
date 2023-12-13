class UserDataModel {
  final String? identity;
  final String? defaultConnection;
  final String? roomId;
  final String? organizationId;

  UserDataModel({
    this.identity,
    this.defaultConnection,
    this.roomId,
    this.organizationId,
  });

  UserDataModel copyWith({
    String? identity,
    String? defaultConnection,
    String? roomId,
    String? organizationId,
  }) =>
      UserDataModel(
        identity: identity ?? this.identity,
        defaultConnection: defaultConnection ?? this.defaultConnection,
        roomId: roomId ?? this.roomId,
        organizationId: organizationId ?? this.organizationId,
      );

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        identity: json["identity"],
        defaultConnection: json["defaultConnection"],
        roomId: json["roomId"],
        organizationId: json["organization_id"],
      );

  Map<String, dynamic> toJson() => {
        "identity": identity,
        "defaultConnection": defaultConnection,
        "roomId": roomId,
        "organization_id": organizationId,
      };
}
