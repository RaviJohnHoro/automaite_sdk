class RoomExistsModel {
  final bool roomExists;

  RoomExistsModel({
    this.roomExists = false,
  });

  RoomExistsModel copyWith({
    bool? roomExists,
  }) =>
      RoomExistsModel(
        roomExists: roomExists ?? this.roomExists,
      );

  factory RoomExistsModel.fromJson(Map<String, dynamic> json) =>
      RoomExistsModel(
        roomExists: json["roomExists"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "roomExists": roomExists,
      };
}
