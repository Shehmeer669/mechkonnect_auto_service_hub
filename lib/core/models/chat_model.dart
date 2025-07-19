import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('system')
  system,
}

@JsonSerializable()
class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String? bookingId;
  final MessageType type;
  final String content;
  final String? imageUrl;
  final bool isRead;
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.bookingId,
    required this.type,
    required this.content,
    this.imageUrl,
    required this.isRead,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

  bool get isText => type == MessageType.text;
  bool get isImage => type == MessageType.image;
  bool get isSystem => type == MessageType.system;

  ChatMessage copyWith({
    bool? isRead,
  }) {
    return ChatMessage(
      id: id,
      senderId: senderId,
      receiverId: receiverId,
      bookingId: bookingId,
      type: type,
      content: content,
      imageUrl: imageUrl,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }
}

@JsonSerializable()
class ChatRoom {
  final String id;
  final String userId;
  final String mechanicId;
  final String? bookingId;
  final ChatMessage? lastMessage;
  final int unreadCount;
  final DateTime lastActivity;
  final DateTime createdAt;

  const ChatRoom({
    required this.id,
    required this.userId,
    required this.mechanicId,
    this.bookingId,
    this.lastMessage,
    required this.unreadCount,
    required this.lastActivity,
    required this.createdAt,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);

  bool get hasUnreadMessages => unreadCount > 0;

  ChatRoom copyWith({
    ChatMessage? lastMessage,
    int? unreadCount,
    DateTime? lastActivity,
  }) {
    return ChatRoom(
      id: id,
      userId: userId,
      mechanicId: mechanicId,
      bookingId: bookingId,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      lastActivity: lastActivity ?? this.lastActivity,
      createdAt: createdAt,
    );
  }
}